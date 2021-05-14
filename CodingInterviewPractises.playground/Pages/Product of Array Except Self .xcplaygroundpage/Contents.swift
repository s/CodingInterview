//: [Previous](@previous)
/*:
 # 238. Product of Array Except Self
 Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].

 The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.

 You must write an algorithm that runs in O(n) time and without using the division operation.
 
 ```
 Example 1:

 Input: nums = [1,2,3,4]
 Output: [24,12,8,6]
 ```
 
 ```
 Example 2:

 Input: nums = [-1,1,0,-3,3]
 Output: [0,0,9,0,0]
 ```

 ```
 Constraints:

 2 <= nums.length <= 105
 -30 <= nums[i] <= 30
 The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.
 ```

 Follow up: Can you solve the problem in O(1) extra space complexity? (The output array does not count as extra space for space complexity analysis.)
 */

import Foundation

class Solution {
//    Runtime: 192 ms, faster than 99.40% of Swift online submissions for Product of Array Except Self.
//    Memory Usage: 20.9 MB, less than 59.68% of Swift online submissions for Product of Array Except Self.
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        let n: Int = nums.count
        var output = Array(repeating: 1, count: nums.count)
        
        output[0] = 1
        for i in 1..<nums.count {
            output[i] = output[i-1] * nums[i-1]
        }
        //1,2,3,4
        //1,1,8,6
        var R: Int = 1
        var i: Int = n - 1
        while i >= 0 {
            output[i] = output[i] * R
            R = R * nums[i]
            i -= 1
        }
        
        return output
    }
    
//    Runtime: 200 ms, faster than 93.81% of Swift online submissions for Product of Array Except Self.
//    Memory Usage: 21.3 MB, less than 27.15% of Swift online submissions for Product of Array Except Self.
    func ____productExceptSelf(_ nums: [Int]) -> [Int] {
        guard !nums.isEmpty else { return [] }
        var leftProducts: [Int] = Array(repeating: 1, count: nums.count)
        var rightProducts: [Int] = Array(repeating: 1, count: nums.count)
        var output: [Int] = Array(repeating: 1, count: nums.count)
        leftProducts[0] = 1
        rightProducts[nums.count - 1] = 1
        for i in 1..<nums.count {
            leftProducts[i] = leftProducts[i-1] * nums[i-1]
        }
        for i in stride(from: nums.count - 2, to: -1, by: -1) {
            rightProducts[i] = rightProducts[i + 1] * nums[i + 1]
        }
        for i in 0..<nums.count {
            output[i] = leftProducts[i] * rightProducts[i]
        }
        
        return output
    }
    
//    Runtime: 228 ms, faster than 26.55% of Swift online submissions for Product of Array Except Self.
//    Memory Usage: 21 MB, less than 47.31% of Swift online submissions for Product of Array Except Self.
    func __productExceptSelf(_ nums: [Int]) -> [Int] {
        guard !nums.isEmpty else { return [] }
        
        let numberOfZeros = nums.filter { $0 == 0 }.count
        
        // If we have more than one 0, then all array becomes 0s
        guard numberOfZeros < 2 else {
            return Array(repeating: 0, count: nums.count)
        }
        
        var output: [Int] = Array(repeating: 0, count: nums.count)
        let nonZeroProduct = nums.filter { $0 != 0 }.reduce(1, *)
        let zeroIndice = nums.firstIndex(of: 0)
        
        // If we have only one zero, then we can set that one to product
        // and return the rest of the array with 0s
        if numberOfZeros == 1, let zeroIndice = zeroIndice {
            output[zeroIndice] = nonZeroProduct
            return output
        }
        
        // If we don't have any zero
        for i in 0...nums.count - 1 {
            output[i] = nonZeroProduct / nums[i]
        }
        return output
    }
    
    
//    Runtime: 224 ms, faster than 31.54% of Swift online submissions for Product of Array Except Self.
//    Memory Usage: 20.8 MB, less than 70.26% of Swift online submissions for Product of Array Except Self.
    func _productExceptSelf(_ nums: [Int]) -> [Int] {
        guard !nums.isEmpty else { return [] }
        
        let numberOfZeros = nums.filter { $0 == 0 }.count
        guard numberOfZeros < 2 else {
            return Array(repeating: 0, count: nums.count)
        }
    
        let productWithoutZeros = nums.filter { $0 != 0 }.reduce(1, *)
        var output: [Int] = Array(repeating: productWithoutZeros,
                                  count: nums.count)
        for i in 0..<nums.count {
            if nums[i] == 0 {
                output[i] = productWithoutZeros
            } else {
                if numberOfZeros > 0 {
                    output[i] = 0
                } else {
                    output[i] = output[i] / nums[i]
                }
            }
        }
        return output
    }
}
print(Solution().productExceptSelf([1,2,3,4]))
//: [Next](@next)
