/*
 
 There are two sorted arrays nums1 and nums2 of size m and n respectively.

 Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).

 You may assume nums1 and nums2 cannot be both empty.

 Example 1:

 nums1 = [1, 3]
 nums2 = [2]

 The median is 2.0
 Example 2:

 nums1 = [1, 3]
 nums2 = [2, 4]

 The median is (2 + 3)/2 = 2.5
 */
import Foundation
import XCTest

class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        
    }
    
    // Complexity is O(m+n)
    func findMedianSortedArrays2(_ nums1: [Int], _ nums2: [Int]) -> Double {
        var tempVal: Int
        var leftIndex: Int = 0
        var rightIndex: Int = 0
        var mergedArray: [Int] = []
        
        // Iterating over two arrays
        while (leftIndex < nums1.count) && (rightIndex < nums2.count) {
            
            // Adding from left array while it's less than right index
            while (leftIndex < nums1.count) && (nums1[leftIndex] <= nums2[rightIndex]) {
                mergedArray.append(nums1[leftIndex])
                leftIndex += 1
            }
            
            // if we overflow the index of left, using tempVal to be on safe side
            // against index out of bound error
            if leftIndex >= nums1.count {
                tempVal = nums1[nums1.count-1]
            } else {
                tempVal = nums1[leftIndex]
            }
            
            // Adding from right array while it's less than left index
            while (rightIndex < nums2.count) && (nums2[rightIndex] <= tempVal) {
                mergedArray.append(nums2[rightIndex])
                rightIndex += 1
            }
        }
        
        // If we have any leftovers from left array appending them..
        if leftIndex < nums1.count {
            mergedArray.append(contentsOf: nums1[leftIndex..<nums1.count])
        }
        
        // If we have any leftovers from right array appending them..
        if rightIndex < nums2.count {
            mergedArray.append(contentsOf: nums2[rightIndex..<nums2.count])
        }
        
        // Finding median
        var median: Double
        let halfIndex = mergedArray.count / 2
        if mergedArray.count % 2 == 0 {
            median = Double(mergedArray[halfIndex-1] + mergedArray[halfIndex]) / 2
        } else {
            median = Double(mergedArray[halfIndex])
        }
        
        return median
    }
}

Solution().findMedianSortedArrays([1, 3], [2, 4])
