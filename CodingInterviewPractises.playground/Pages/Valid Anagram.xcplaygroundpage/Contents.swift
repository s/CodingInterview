//: [Previous](@previous)

/*:
 # 242. Valid Anagram
 Given two strings s and t, return true if t is an anagram of s, and false otherwise.

 ```
 Example 1:

 Input: s = "anagram", t = "nagaram"
 Output: true
 ```
 
 ```
 Example 2:

 Input: s = "rat", t = "car"
 Output: false
 ```
 */

import Foundation
/*
 Runtime: 468 ms, faster than 7.46% of Swift online submissions for Valid Anagram.
 Memory Usage: 16.4 MB, less than 19.34% of Swift online submissions for Valid Anagram.
 */
func _isAnagram(_ s: String, _ t: String) -> Bool {
    if s.count != t.count {
        return false
    }
    return s.sorted() == t.sorted()
}

/*
 Runtime: 52 ms, faster than 62.98% of Swift online submissions for Valid Anagram.
 Memory Usage: 14.2 MB, less than 97.24% of Swift online submissions for Valid Anagram.
 */
func isAnagram(_ s: String, _ t: String) -> Bool {
    if s.isEmpty || t.isEmpty {
        return false
    }
    var dict: [UnicodeScalar: Int] = [:]
    for ch in s.unicodeScalars {
        dict[ch, default: 0] += 1
    }
    for ch in t.unicodeScalars {
        if var val = dict[ch] {
            val -= 1
            dict[ch] = val
        } else {
            return false
        }
    }
    
    for v in dict.values {
        if v != 0 {
            return false
        }
    }
    return true
}

print(isAnagram("a", "ab"))
//: [Next](@next)
