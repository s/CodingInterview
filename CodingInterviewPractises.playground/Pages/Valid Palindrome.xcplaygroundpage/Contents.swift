//: [Previous](@previous)
/*
 A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.

 Given a string s, return true if it is a palindrome, or false otherwise.

```
 Example 1:
 Input: s = "A man, a plan, a canal: Panama"
 Output: true
 Explanation: "amanaplanacanalpanama" is a palindrome.
 ```
 
 ```
 Example 2:
 Input: s = "race a car"
 Output: false
 Explanation: "raceacar" is not a palindrome.
 ```
 
 ```
 Example 3:
 Input: s = " "
 Output: true
 Explanation: s is an empty string "" after removing non-alphanumeric characters.
 Since an empty string reads the same forward and backward, it is a palindrome.
 ```
 */
import Foundation

class Solution {
    /*
     Runtime: 16 ms, faster than 73.86% of Swift online submissions for Valid Palindrome.
     Memory Usage: 15.1 MB, less than 77.18% of Swift online submissions for Valid Palindrome.
     */
    func isPalindrome(_ s: String) -> Bool {
        guard !s.isEmpty else { return true }
        
        let lowercasedStr = s.lowercased()
        guard !lowercasedStr.isEmpty else { return true }
        
        let allowedCharsSet = CharacterSet.alphanumerics
        let filteredStr = lowercasedStr.unicodeScalars.filter {
            return allowedCharsSet.contains($0)
        }
        let arr = Array(filteredStr)
        if arr.isEmpty { return true }
        var leftCursor = 0
        var rightCursor = filteredStr.count - 1
        var isPalindrome = true
        
        while rightCursor > leftCursor, isPalindrome {
            if arr[leftCursor] != arr[rightCursor] {
                isPalindrome = false
                continue
            }
            leftCursor += 1
            rightCursor -= 1
        }
        return isPalindrome
    }
}

let sol = Solution()
if !sol.isPalindrome("race a car") {
    print("Case 1 checked")
} else {
    print("Case 1 failed")
}

//: [Next](@next)
