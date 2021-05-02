//: [Previous](@previous)

/*:
 # Add Two Numbers
 You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

  You may assume the two numbers do not contain any leading zero, except the number 0 itself.

 ---
 Example:

 Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
 Output: 7 -> 0 -> 8
 Explanation: 342 + 465 = 807.
 */
import Foundation
import XCTest

// MARK: - ListNode
public class ListNode {
    // MARK: - Properties
    public var val: Int
    public var next: ListNode?
    public var cumulativeVal: Int {
        var idx: Int = 1
        var sum = val
        var nextNode: ListNode? = next

        while nextNode != nil {
            let cofactor = Int(pow(Double(10),Double(idx)))
            sum = sum + cofactor * (nextNode?.val ?? 0)
            idx+=1
            nextNode = nextNode?.next
        }
        return sum
    }
    
    // MARK: - Lifecycle
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    
    // MARK: - Public
    public func append(node:ListNode) {
        var curNode: ListNode? = self
        var nextNode: ListNode? = next
        while curNode?.next != nil {
            curNode = nextNode
            nextNode = nextNode?.next
        }
        curNode?.next = node
    }
    
    public func printDescription() {
        var output = "\(val)"
        var n = next
        while n != nil {
            if let nextVal = n?.val {
                output = "\(output) -> \(nextVal)"
            }
            n = n?.next
        }
        print(output)
    }
}

// MARK: - Extension
public extension Int {
    func convertToNode() -> ListNode {
        let node = ListNode(self % 10)
        var num = self / 10
        while num != 0 {
            node.append(node: ListNode(num % 10))
            num /= 10
        }
        return node
    }
}

// MARK: - Solution
class Solution {
    // This solution scales up
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var lhs = l1
        var rhs = l2
        var idx = 0
        var carry = 0
        var result: ListNode? = nil // 7 ->
        var currentDigit = 0
        var lastNode: ListNode? = nil
        
        while lhs != nil || rhs != nil {
            currentDigit = (lhs?.val ?? 0) + (rhs?.val ?? 0) + carry
            carry = currentDigit / 10
            currentDigit %= 10
            
            if result == nil {
                result = ListNode(currentDigit)
            } else {
                let newNode = ListNode(currentDigit) //0
                if lastNode == nil {
                    lastNode = newNode
                    result?.next = lastNode
                } else {
                    lastNode?.next = newNode
                    lastNode = newNode
                }
            }
            
            
            idx += 1
            lhs = lhs?.next
            rhs = rhs?.next
        }
        if carry > 0 {
            let newNode = ListNode(carry)
            if lastNode == nil {
                result?.next = newNode
            } else {
                lastNode?.next = newNode
            }
        }
        return result
    }
        
    // This solution is not safe for large numbers
    func addTwoNumbersNotScalable(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let firstNumber = l1?.cumulativeVal ?? 0
        let secondNumber = l2?.cumulativeVal ?? 0
        return (firstNumber + secondNumber).convertToNode()
    }
}

// MARK: - Tests
class SolutionTests: XCTestCase {
    // MARK: - Properties
    private let solution = Solution()
    
    // MARK: - Test Cases
    func testLCCaseOne() {
        let numberOne = ListNode(5)
        let numberTwo = ListNode(5)
        guard let result = solution.addTwoNumbers(numberOne, numberTwo) else {
            XCTFail()
            return
        }
        print(result.printDescription())
        XCTAssertEqual(result.val, 7)
        XCTAssertNotNil(result.next)
        guard let next = result.next else {
            XCTFail()
            return
        }
        XCTAssertEqual(next.val, 0)
        guard let nextNext = next.next else {
            XCTFail()
            return
        }
        XCTAssertEqual(nextNext.val, 8)
    }
}
SolutionTests.defaultTestSuite.run()

/*:
[Next](@next)

*/
