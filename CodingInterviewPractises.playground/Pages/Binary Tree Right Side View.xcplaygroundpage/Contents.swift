//: [Previous](@previous)

/*:
 # 199. Binary Tree Right Side View

 Given the root of a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.
 */
import Foundation
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

class Solution {
    func __rightSideView(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        
        var rightView: [Int] = []
        var nodes: [TreeNode] = []
        var tmp: Int
        
        nodes.append(root)
        while !nodes.isEmpty {
            
            if let last = nodes.last {
                rightView.append(last.val)
            }
            
            tmp = nodes.count
            nodes.forEach {
                nodes.append(contentsOf: children(of: $0))
            }
            nodes.removeFirst(tmp)
        }
        
        return rightView
    }
    
    func _rightSideView(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        
        var dict: [Int: [Int]] = [:]
        var nodes: [TreeNode] = []
        var level: Int = 0
        
        nodes.append(root)
        while !nodes.isEmpty {
            
            // at each level we'll have 2^level nodes
            var numberOfNodesAtThisLevel = Int(pow(Double(2), Double(level)))
            numberOfNodesAtThisLevel = min(numberOfNodesAtThisLevel, nodes.count)
            let nodesAtThisLevel = nodes.suffix(Int(numberOfNodesAtThisLevel))
            nodes.removeLast(numberOfNodesAtThisLevel)
            
            let valuesOfNodesAtThisLevel = nodesAtThisLevel.map { $0.val }
            dict[level, default: []].append(contentsOf: valuesOfNodesAtThisLevel)
            
            nodesAtThisLevel.forEach {
                nodes.append(contentsOf: children(of: $0))
            }
            level += 1
        }
        
        var rightView: [Int] = []
        let sortedKeys = dict.keys.sorted()
        for key in sortedKeys {
            guard
                let nodeValuesAtThisLevel = dict[key],
                let last = nodeValuesAtThisLevel.last
            else {
                continue
            }
            rightView.append(last)
        }
        return rightView
    }
    
    func children(of node: TreeNode) -> [TreeNode] {
        var children: [TreeNode] = []
        if let left = node.left {
            children.append(left)
        }
        if let right = node.right {
            children.append(right)
        }
        return children
    }
    
    func rightSideView(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        var rightView: [Int] = []

        var dict: [Int: [Int]] = [:]
        traverseTree(root: root, dict: &dict, levelNumber: 1)
        
        let sortedKeys = dict.keys.sorted()
        for key in sortedKeys {
            if let arr = dict[key], let last = arr.last {
                rightView.append(last)
            }
        }
        return rightView
    }

    func traverseTree(root: TreeNode, dict: inout [Int: [Int]], levelNumber: Int) {
        dict[levelNumber, default:[]].append(root.val)
        if let left = root.left {
            traverseTree(root: left, dict: &dict, levelNumber: levelNumber + 1)
        }
        if let right = root.right {
            traverseTree(root: right, dict: &dict, levelNumber: levelNumber + 1)
        }
    }
}

let solution = Solution()

let six = TreeNode(6, nil, nil)
let four = TreeNode(4, nil, TreeNode(9, nil, nil))
let five = TreeNode(5, nil, nil)

let two = TreeNode(2, four, five)
let three = TreeNode(3, six, nil)
let root = TreeNode(1, two, three)

print(solution._rightSideView(root))
//: [Next](@next)
