//: [Previous](@previous)
/*:
 # 206. Reverse Linked List

 Given the head of a singly linked list, reverse the list, and return the reversed list.

 ```
 Input: head = [1,2,3,4,5]
 Output: [5,4,3,2,1]
 ```
 
 ```
 Input: head = [1,2]
 Output: [2,1]
 ```
 
 ```
 Input: head = []
 Output: []
 ```
 
 ```
 Constraints:

 The number of nodes in the list is the range [0, 5000].
 -5000 <= Node.val <= 5000
 ```

 */

/**
 * Definition for singly-linked list.
 */

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    func reverseList(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil { return head }
        var cur = head
        var prev: ListNode? = nil
        while cur?.next != nil {
            let n = cur?.next
            cur?.next = prev
            prev = cur
            cur = n
        }
        cur?.next = prev
        return cur
    }

    func reverseList(_ head: ListNode?) -> ListNode? {
        return _reverseList(head, prev: nil)
    }
    
    func _reverseList(_ head: ListNode?, prev: ListNode?) -> ListNode? {
        guard var c: ListNode = head else {
            return prev
        }
        guard var n: ListNode = c.next else {
            c.next = prev
            return c
        }
        let nn = n.next
        n.next = c
        c.next = prev
        return _reverseList(nn, prev: n)
    }
}

//: [Next](@next)
