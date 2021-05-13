//: [Previous](@previous)
/*:
 # Reverse Operations
 
 You are given a singly-linked list that contains N integers. A subpart of the list is a contiguous set of even elements, bordered either by either end of the list or an odd element. For example, if the list is [1, 2, 8, 9, 12, 16], the subparts of the list are [2, 8] and [12, 16].
 
 Then, for each subpart, the order of the elements is reversed. In the example, this would result in the new list, [1, 8, 2, 9, 16, 12].
 
 The goal of this question is: given a resulting list, determine the original order of the elements.
 
 ```
 Implementation detail:
 
 You must use the following definition for elements in the linked list:
 
 class Node {
     int data;
     Node next;
 }
 ```
 
 ```
 Signature
 Node reverse(Node head)
 ```
 
 ```
 Constraints
 1 <= N <= 1000, where N is the size of the list
 1 <= Li <= 10^9, where Li is the ith element of the list
 ```
 
 ```
 Example
 Input:
 N = 6
 list = [1, 2, 8, 9, 12, 16]
 ```
 
 ```
 Output:
 [1, 8, 2, 9, 16, 12]
 ```
 */
import Foundation

class Node {
    let data: Int
    var nextNode: Node?
    
    init(data: Int, next: Node? = nil) {
        self.data = data
        self.nextNode = next
    }
}

private extension Node {
    func update(with nextNode:Node?) -> Node {
        Node(data: data, next: nextNode)
    }
}

func reverseEvens( head: inout Node) -> Node {
    var prev: Node? = nil
    var cur: Node? = head
    var tmp: Node? = nil
    
    while cur != nil, let d = cur?.data, d % 2 == 0 {
        tmp = cur?.nextNode
        cur?.nextNode = prev
        prev = cur
        cur = tmp
    }
    head.nextNode = cur
    return prev!
}
// dummy, 1, 2, 8, 9, 12, 16
private extension Node {
    func reverse() -> Node {
        let dummy = Node(data: Int.max - 1, next: self)
        var prev: Node? = dummy
        var cur: Node? = self
        
        while cur != nil {
            if let d = cur?.data, d % 2 == 0 {
                prev?.nextNode = reverseEvens(head: &cur!)
            }
            
            prev = cur
            cur = cur?.nextNode
        }
        
        return dummy.nextNode!
    }
}


// These are the tests we use to determine if the solution is correct.
// You can add your own at the bottom, but they are otherwise not editable!

struct NodeView: IteratorProtocol {
    var node: Node?
    mutating func next() -> Int? {
        defer { node = node?.nextNode }
        return node?.data
    }
}
 
extension Node: Sequence {
    public typealias Element = Int
    public func makeIterator() -> NodeView {
        return NodeView(node: self)
    }
}

private extension Node {
    static func from(array: [Int]) -> Node {
        var array = array
        var tail = Node(data: array.removeLast())
        for num in array.reversed() {
            tail = Node(data: num, next: tail)
        }
        return tail
    }
}

extension Node: Equatable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        return Array(lhs) == Array(rhs)
    }
}

var testCaseNumber = 1

func check(_ expectedHead: Node, matches outputHead: Node) {
    let rightTick = "\u{2713}"
    let wrongTick = "\u{2717}"
    
    if expectedHead == outputHead {
        print("\(rightTick) Test #\(testCaseNumber)")
    } else {
        print("\(wrongTick) Test #\(testCaseNumber) Expected: \(Array(expectedHead)) Your output: \(Array(outputHead))")
    }
    testCaseNumber += 1
}

let head1 = Node.from(array: [1, 2, 8, 9, 12, 16])
let expected1 = Node.from(array: [1, 8, 2, 9, 16, 12])
let output1 = head1.reverse()
check(expected1, matches: output1)

let head2 = Node.from(array: [2, 18, 24, 3, 5, 7, 9, 6, 12])
let expected2 = Node.from(array: [24, 18, 2, 3, 5, 7, 9, 12, 6])
let output2 = head2.reverse()
check(expected2, matches: output2)

// Add your tests here


//: [Next](@next)
