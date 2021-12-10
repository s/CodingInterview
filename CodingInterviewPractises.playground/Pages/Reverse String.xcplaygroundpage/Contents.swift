//: [Previous](@previous)
/*:
 344. Reverse String
 Write a function that reverses a string. The input string is given as an array of characters s.

 You must do this by modifying the input array in-place with O(1) extra memory.
 
 ```
 Example 1:

 Input: s = ["h","e","l","l","o"]
 Output: ["o","l","l","e","h"]
 ```
 
 ```
 Example 2:

 Input: s = ["H","a","n","n","a","h"]
 Output: ["h","a","n","n","a","H"]
 ```
 */
import Foundation

class Solution {
    func reverseString(_ s: inout [Character]) {
        _swap(0, s.count-1, &s)
    }
    func _swap(_ lhs:Int, _ rhs:Int, _ s: inout [Character]) {
        guard lhs < rhs else { return }
        let tmp = s[lhs]
        s[lhs] = s[rhs]
        s[rhs] = tmp
        _swap(lhs+1, rhs-1, &s)
    }
}
var char: [Character] = ["h","e","l","l","o"]
Solution().reverseString(&char)
print(char)
//: [Next](@next)
