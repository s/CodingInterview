//: [Previous](@previous)
/*:
 # 680. Valid Palindrome II
 
 Given a string s, return true if the s can be palindrome after deleting at most one character from it.
 
 ```
 Example 1:

 Input: s = "aba"
 Output: true
 ```
 
 ```
 Example 2:

 Input: s = "abca"
 Output: true
 Explanation: You could delete the character 'c'.
 ```
 
 ```
 Example 3:

 Input: s = "abc"
 Output: false
 ```
 
 ```
 Constraints:

 1 <= s.length <= 105
 s consists of lowercase English letters.
 ```
 */
import Foundation

extension String {
    subscript(_ offset: Int) -> Element {
        self[index(startIndex, offsetBy:offset)]
    }
}

class Solution {
    func isPalindrome(_ s: [Character], _ i: Int, _ j: Int) -> Bool {
        var l = i
        var h = j
        while l < h {
            if s[l] != s[h] {
                return false
            }
            l += 1
            h -= 1
        }
        return true
    }
    func validPalindrome(_ s: String) -> Bool {
        guard !s.isEmpty else { return true }
        var i: Int = 0
        var j: Int = s.count - 1
        while i < j {
            if s[i] != s[j] {
                return isPalindrome(s, i+1, j) || isPalindrome(s, i, j-1)
            }
            i += 1
            j -= 1
        }
        return true
    }
}

//: [Next](@next)
