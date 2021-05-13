//: [Previous](@previous)
/*:
 # 104. Maximum Depth of Binary Tree

 Given the root of a binary tree, return its maximum depth.

 A binary tree's maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.
 
 ```
 Input: root = [3,9,20,null,null,15,7]
 Output: 3
 ```
*/

import Foundation
/**
 * Definition for a binary tree node.
 */

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
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        return depth(underNode: root, currentDepth: 0)
    }
    
    func depth(underNode node: TreeNode?, currentDepth: Int) -> Int {
        if node == nil { return currentDepth }
        let left = depth(underNode: node?.left, currentDepth: currentDepth + 1)
        let right = depth(underNode: node?.right, currentDepth: currentDepth + 1)
        return max(left, right)
    }
}

//: [Next](@next)
