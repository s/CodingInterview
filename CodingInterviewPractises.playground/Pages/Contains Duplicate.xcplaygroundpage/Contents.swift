//: [Previous](@previous)

/*:
 # 217. Contains Duplicate
 Given an integer array nums, return true if any value appears at least twice in the array, and return false if every element is distinct.
 
 ```
 Example 1:

 Input: nums = [1,2,3,1]
 Output: true
 ```
 
 ```
 Example 2:

 Input: nums = [1,2,3,4]
 Output: false
 ```
 
 ```
 Example 3:

 Input: nums = [1,1,1,3,3,4,3,2,4,2]
 Output: true
 ```
 */

import Foundation


// Doesn't work with negative numbers; Always ask if the array can contain negative numbers
func _____containsDuplicate(_ nums: [Int]) -> Bool {
    guard !nums.isEmpty else { return false }
    guard let maxElm = nums.max() else { return false }
    var counts: [Int] = []
    for i in 0...maxElm {
        counts.append(0)
    }
    
    for elm in nums {
        counts[elm] += 1
    }
    
    for elm in counts {
        if elm > 1 {
            return true
        }
    }
    return false
}

/*
 Runtime: 132 ms, faster than 73.68% of Swift online submissions for Contains Duplicate.
 Memory Usage: 21.6 MB, less than 5.99% of Swift online submissions for Contains Duplicate.
 */
func ____containsDuplicate(_ nums: [Int]) -> Bool {
    guard let max = nums.max() else { return true }
    guard let min = nums.min() else { return true }
    
    let offset = 0 - min
    
    var arr = Array(repeating: 0, count: max + offset + 1)
    
    for num in nums {
        let idx = num + offset
        arr[idx] += 1
    }
    for elm in arr {
        if elm >= 2 {
            return true
        }
    }
    return false
}

/*
 Runtime: 148 ms, faster than 63.66% of Swift online submissions for Contains Duplicate.
 Memory Usage: 15.8 MB, less than 62.23% of Swift online submissions for Contains Duplicate.
 */
func __containsDuplicate(_ nums: [Int]) -> Bool {
    return nums.count != Set(nums).count
}

/*
 Runtime: 160 ms, faster than 20.43% of Swift online submissions for Contains Duplicate.
 Memory Usage: 15.7 MB, less than 77.43% of Swift online submissions for Contains Duplicate.
 */
func _containsDuplicate(_ nums: [Int]) -> Bool {
    let sorted = nums.sorted()
    var i: Int = 0
    while i < sorted.endIndex - 1 {
        if sorted[i] == sorted[i+1] { return true }
        i += 1
    }
    return false
}

/*
 Runtime: 148 ms, faster than 63.66% of Swift online submissions for Contains Duplicate.
 Memory Usage: 18.9 MB, less than 7.60% of Swift online submissions for Contains Duplicate.
 */
func containsDuplicate(_ nums: [Int]) -> Bool {
    var _numsStorage: [Int: Int] = [:]
    for num in nums {
        if let _ = _numsStorage[num] {
            return true
        }
        _numsStorage[num, default: 0] += 1
    }
    return false
}

//: [Next](@next)
