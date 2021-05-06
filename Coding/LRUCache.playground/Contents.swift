/*:
 # LRU Cache implementation
 
 Design a data structure that follows the constraints of a Least Recently Used (LRU) cache.
 
 */


import Foundation
import XCTest

protocol LRUCache {
    associatedtype Key: Hashable
    associatedtype Element
    
    init(capacity: Int)
    func set(key: Key, element: Element)
    func get(key: Key) -> Element?
    func printAllEntries()
}

// MARK: - Solution
typealias LRUCacheSolKey = Hashable & CustomStringConvertible
typealias LRUCacheSolVal = CustomStringConvertible
// MARK: - LRUCacheSol
/// `LRUCacheSol` implements `LRUCache` protocol with a thread safe and generic API.
final class LRUCacheSol<Key: LRUCacheSolKey, Element: LRUCacheSolVal>: LRUCache {
    
    
    // MARK: - LRUCacheNode
    /// `LRUCacheNode` represents each node within a LRUCache
    final class LRUCacheNode<K: LRUCacheSolKey, E>: Hashable {
        typealias Key = K
        typealias Element = E
        
        let key: Key
        var element: E?
        var next: LRUCacheNode<K, E>?
        var prev: LRUCacheNode<K, E>?
        
        init(key: Key, element: Element? = nil) {
            self.key = key
            self.element = element
        }
        
        static func == (lhs: LRUCacheNode<K, E>, rhs: LRUCacheNode<K, E>) -> Bool {
            lhs.key == rhs.key
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(key)
        }
    }
    
    // MARK: - Properties
    let capacity: Int
    private let firstNode: LRUCacheNode<Key, Element>
    private let lastNode: LRUCacheNode<Key, Element>
    
    var currentCacheSize: Int {
        var _cnt: Int = -1
        inputOutputQueue.sync {
            _cnt = nodesMap.count - 2
        }
        return _cnt
    }
    private var nodesMap: Dictionary<Key, LRUCacheNode<Key, Element>> = [:]
    
    private var inputOutputQueue = DispatchQueue(label: "com.LRUCacheSol.IOQueue",
                                                 attributes: .concurrent)
    private var workItemQueue = DispatchQueue(label: "com.LRUCacheSol.WorkItemQueue")
    private var workItems: [DispatchWorkItem] = []
    
    init(capacity: Int) {
        self.capacity = capacity
        self.firstNode = LRUCacheNode(key: "first_node" as! Key)
        self.lastNode = LRUCacheNode(key: "last_node" as! Key)
        self.firstNode.next = self.lastNode
        self.firstNode.prev = nil
        self.lastNode.prev = self.firstNode
        self.lastNode.next = nil
        self.nodesMap["first_node" as! Key] = self.firstNode
        self.nodesMap["last_node" as! Key] = self.lastNode
    }
    
    deinit {
        workItems.forEach {
            $0.cancel()
        }
    }
    
    func set(key: Key, element newElement: Element) {
        // Checking if we already have this value on cache
        if let existingObj = self.nodesMap[key] {
            // Cache hit: updating existing value
            existingObj.element = newElement
            self.prioritize(existingObj)
        } else {
            // Cache miss: adding new entry
            let node = LRUCacheNode(key: key, element: newElement)
            self.add(node)
        }
    }
    
    func get(key: Key) -> Element? {
        inputOutputQueue.sync { [weak self] in
            guard let self = self else { return nil }
            guard let accessedNode = self.nodesMap[key] else {
                return nil
            }
            self.prioritize(accessedNode)
            return accessedNode.element
        }
    }
    
    func printAllEntries() {
        guard let next = firstNode.next, next.next != nil else {
            print("No elements to print.")
            return
        }
        self._print(node: next)
    }
    
    // MARK: -
    private func prioritize(_ node: LRUCacheNode<Key, Element>) {
        // All writes should happen with a barrier
        let workItem = DispatchWorkItem(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            // Re-linking first node's links: first -> (new node) -> last
            let oldNode = self.firstNode.next
            
            // first <-> new node
            self.firstNode.next = node
            node.prev = self.firstNode
            
            // new node <-> old node
            node.next = oldNode
            oldNode?.prev = node
        }
        
        inputOutputQueue.async(execute: workItem)
    }
    
    private func add(_ node: LRUCacheNode<Key, Element>) {
        if currentCacheSize > 0,
           currentCacheSize >= capacity,
           let leastRecentlyUsedNode = lastNode.prev {
            // We would like to add a new node but we will be full if we add that
            // So we are removing least recently used element from the cache
            lastNode.prev = leastRecentlyUsedNode.prev
            leastRecentlyUsedNode.prev?.next = lastNode
            
            _write { [weak self] in
                guard let self = self else { return }
                self.nodesMap.removeValue(forKey: leastRecentlyUsedNode.key) // O(1)
            }
        }
        _write { [weak self] in
            guard let self = self else { return }
            self.nodesMap[node.key] = node // O(1)
            self.prioritize(node) // O(1)
        }
    }
    
    private func _print(node: LRUCacheNode<Key, Element>) {
        print("Node(key:\(node.key.description), value:\(String(describing: node.element?.description))) -> ")
        
        if let nodeToPrint = node.next, node.next?.next != nil {
            _print(node: nodeToPrint)
        }
    }
    
    private func addWorkItemOp(_ workItem: DispatchWorkItem) {
        workItemQueue.async { [weak self] in
            guard let self = self else { return }
            self.workItems.append(workItem)
        }
    }
    
    private func _write(_ op: @escaping () -> Void) {
        let workItem = DispatchWorkItem(flags:.barrier) {
            op()
        }
        addWorkItemOp(workItem)
        inputOutputQueue.async(execute: workItem)
    }
}

// MARK: -
class LRUCacheTestCase: XCTestCase {
    func testEmptyCache() {
        let lruCache = LRUCacheSol<String, Int>(capacity: 1)
        assert(lruCache.currentCacheSize == 0)
    }
    
    func testOneElement() {
        let lruCache = LRUCacheSol<String, Int>(capacity: 1)
        lruCache.set(key: "key", element: 10)
        assert(lruCache.currentCacheSize == 1)
        assert(lruCache.get(key: "key") == 10)
    }

    func testTwoElements() {
        let lruCache = LRUCacheSol<String, Int>(capacity: 1)

        lruCache.set(key: "ten", element: 10)
        assert(lruCache.currentCacheSize == 1)
        assert(lruCache.get(key: "ten") == 10)


        lruCache.set(key: "eleven", element: 11)
        assert(lruCache.currentCacheSize == 1)
        assert(lruCache.get(key: "ten") == nil)
        assert(lruCache.get(key: "eleven") == 11)
    }

    func testUpdatingSameValue() {
        let lruCache = LRUCacheSol<String, Int>(capacity: 1)

        lruCache.set(key: "one", element: 1)
        assert(lruCache.currentCacheSize == 1)

        lruCache.set(key: "one", element: 2)
        assert(lruCache.get(key: "one") == 2)
        assert(lruCache.currentCacheSize == 1)
    }

}

LRUCacheTestCase.defaultTestSuite.run()
