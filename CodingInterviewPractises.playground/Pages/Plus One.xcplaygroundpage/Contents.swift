//: [Previous](@previous)
/*:
 66. Plus One
 You are given a large integer represented as an integer array digits, where each digits[i] is the ith digit of the integer. The digits are ordered from most significant to least significant in left-to-right order. The large integer does not contain any leading 0's.

 Increment the large integer by one and return the resulting array of digits.

 ```
 Example 1:

 Input: digits = [1,2,3]
 Output: [1,2,4]
 Explanation: The array represents the integer 123.
 Incrementing by one gives 123 + 1 = 124.
 Thus, the result should be [1,2,4].
 ```
 
 ```
 Example 2:

 Input: digits = [4,3,2,1]
 Output: [4,3,2,2]
 Explanation: The array represents the integer 4321.
 Incrementing by one gives 4321 + 1 = 4322.
 Thus, the result should be [4,3,2,2].
 ```
 
 ```
 Example 3:

 Input: digits = [0]
 Output: [1]
 Explanation: The array represents the integer 0.
 Incrementing by one gives 0 + 1 = 1.
 Thus, the result should be [1].
 ```
 
 ```
 Example 4:

 Input: digits = [9]
 Output: [1,0]
 Explanation: The array represents the integer 9.
 Incrementing by one gives 9 + 1 = 10.
 Thus, the result should be [1,0].
 ```
 */
import Foundation

class Solution {
    func plusOne(_ digits: [Int]) -> [Int] {
        var arr = digits
        for i in stride(from: digits.count - 1, to: -1, by: -1) {
            if arr[i] == 9 {
                arr[i] = 0
            } else {
                arr[i] += 1
                return arr
            }
        }
        return [1] + arr
    }
    
    func _plusOne(_ digits: [Int]) -> [Int] {
        var carry: Int = 0
        var arr = digits
        for i in stride(from: digits.count - 1, to: -1, by: -1) {
            let newSum: Int
            if i == (digits.count-1) {
                newSum = arr[i] + 1 + carry
            } else {
                newSum = arr[i] + carry
            }
            if carry > 0 {
                carry -= 1
            }
            if newSum >= 10 {
                arr[i] = 0
                carry += 1
            } else {
                arr[i] = newSum
            }
        }
        if carry > 0 {
            return [carry] + arr
        }
        return arr
    }
}

//: [Next](@next)
