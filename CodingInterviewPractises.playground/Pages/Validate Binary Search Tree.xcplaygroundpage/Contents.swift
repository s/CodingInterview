//: [Previous](@previous)
/*:
 98. Validate Binary Search Tree

 Given the root of a binary tree, determine if it is a valid binary search tree (BST).

 A valid BST is defined as follows:

 The left subtree of a node contains only nodes with keys less than the node's key.
 The right subtree of a node contains only nodes with keys greater than the node's key.
 Both the left and right subtrees must also be binary search trees.
 
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
    func isValidBST(_ root: TreeNode?) -> Bool {
        return validate(root, max:nil, min:nil)
    }
    
    func validate(_ root: TreeNode?, max: Int?, min: Int?) -> Bool {
        guard let root = root else { return true }
        if let max = max {
            if root.val >= max {
                return false
            }
        }
        if let min = min {
            if root.val <= min {
                return false
            }
        }
        return validate(root.left, max: root.val, min: min) && validate(root.right, max: max, min: root.val)
    }
}

//: [Next](@next)
