//: [Previous](@previous)
/*:
 53. Maximum Subarray
 
 Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

 A subarray is a *contiguous* part of an array.

 ```
 Example 1:

 Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
 Output: 6
 Explanation: [4,-1,2,1] has the largest sum = 6.
 ```
 
 ```
 Example 2:

 Input: nums = [1]
 Output: 1
 ```
 
 ```
 Example 3:

 Input: nums = [5,4,-1,7,8]
 Output: 23
 ```

 ```
 Constraints:

 1 <= nums.length <= 105
 -104 <= nums[i] <= 104
 ```
 
 Follow up: If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.


 */
import Foundation

func maxSubArray_bruteForce(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }
    guard let first = nums.first else { return 0 }
    guard nums.count > 1 else { return first }
    var maxSubArray =  Int.min
    for i in 0..<nums.count {
        var currentSum = 0
        for j in i..<nums.count {
            currentSum += nums[j]
            maxSubArray = max(currentSum, maxSubArray)
        }
    }
    return maxSubArray
}

func maxSubArray(_ nums: [Int]) -> Int {
    guard !nums.isEmpty, let first = nums.first else { return 0 }
    var currentSubarray = first
    var maxSubarray = first
    var num = 0
    
    for i in 1..<nums.count {
        num = nums[i]
        currentSubarray = max(currentSubarray + num, num)
        maxSubarray = max(maxSubarray, currentSubarray)
    }
    return maxSubarray
}

//: [Next](@next)
