/*
 Given a string, find the length of the longest substring without repeating characters.

 Example 1:

 Input: "abcabcbb"
 Output: 3
 Explanation: The answer is "abc", with the length of 3.
 
 Example 2:
 Input: "bbbbb"
 Output: 1
 Explanation: The answer is "b", with the length of 1.
 
 Example 3:
 Input: "pwwkew"
 Output: 3
 Explanation: The answer is "wke", with the length of 3.
              Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
 
 
 */
import Foundation
class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard s.count > 1 else { return s.count }
        
        var maxLength = 0
        var buffer: [Character] = []
        let charArray = Array(s)
        buffer.append(charArray[0])

        for i in 1...charArray.count-1 {
            if let index = buffer.firstIndex(of: charArray[i]){
                buffer.removeFirst(index+1)
            }
            buffer.append(charArray[i])
            maxLength = max(maxLength, buffer.count)
        }
        return maxLength
    }
}

print(Solution().lengthOfLongestSubstring("abcabcbb"), "abcabcbb")
print(Solution().lengthOfLongestSubstring("bbbbb"), "bbbbb")
print(Solution().lengthOfLongestSubstring("pwwkew"), "pwwkew")
print(Solution().lengthOfLongestSubstring("au"), "au")
print(Solution().lengthOfLongestSubstring("ntgnrzumltoefnkpdhbiptzgzdhgqmighqtzpnnchbgmqrduaeesaeybjiiawqgdgbcxorzxuillbrhdxlvx"), "ntgnrzumltoefnkpdhbiptzgzdhgqmighqtzpnnchbgmqrduaeesaeybjiiawqgdgbcxorzxuillbrhdxlvx")
