//: [Previous](@previous)

/*:
 # Two Sum
 
 Given an array of integers, return indices of the two numbers such that they add up to a specific target.

 You may assume that each input would have exactly one solution, and you may not use the same element twice.

 ---
 Example:

 Given nums = [2, 7, 11, 15], target = 9,

 Because nums[0] + nums[1] = 2 + 7 = 9,
 return [0, 1].
 */
import Foundation
import XCTest

class Solution {
    func twoSumSecondIteration(_ nums:[Int], _ target: Int) -> [Int] {
        var possiblePairs: [Int: Int] = [:]
        for (index, num) in nums.enumerated() {
            if let pair = possiblePairs[num], (target == nums[pair] + num) {
                return [pair, index]
            }
            let diff = target - num
            possiblePairs[diff] = index
        }
        return []
    }
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var indexes: [Int] = []
        var dictionary: [Int: [Int]] = [:]
        for (index, num) in nums.enumerated() {
            let sub = target - num
            if dictionary[sub] == nil {
                dictionary[sub] = []
            }
            dictionary[sub]?.append(index)
        }
        for (index, num) in nums.enumerated() {
            guard let val = dictionary[num] else { continue }
            guard val.count == 1 else {
                indexes.append(contentsOf: val)
                return indexes
            }
            if let first = val.first, index != first {
                indexes.append(first)
            }
        }
        return indexes
    }
}

class SolutionTests: XCTestCase {
    private let solution = Solution()
    func testEmptyArray() {
        let result = solution.twoSumSecondIteration([], -1)
        XCTAssertTrue(result.isEmpty)
    }

    func testNegativeElements() {
        let result = solution.twoSumSecondIteration([-1, 1, 7], 0)
        XCTAssertTrue(!result.isEmpty)
        XCTAssertTrue(result.count == 2)
        XCTAssert(result.contains(0))
        XCTAssert(result.contains(1))
    }

    func testArray() {
        let result = solution.twoSumSecondIteration([0, 1, 2, 9, 6, 5], 5)
        XCTAssertTrue(!result.isEmpty)
        XCTAssertTrue(result.count == 2)
        XCTAssert(result.contains(0))
        XCTAssert(result.contains(5))
    }
    
    func testLCCase1() {
        let result = solution.twoSumSecondIteration([3,2,4], 6)
        XCTAssertTrue(!result.isEmpty)
        XCTAssertTrue(result.count == 2)
        XCTAssertTrue(result.contains(1))
        XCTAssertTrue(result.contains(2))
    }
    
    func testLCCase2() {
        let result = solution.twoSumSecondIteration([3,3], 6)
        XCTAssertTrue(!result.isEmpty)
        XCTAssertTrue(result.count == 2)
        XCTAssertTrue(result.contains(0))
        XCTAssertTrue(result.contains(1))
    }
}

SolutionTests.defaultTestSuite.run()


//: [Next](@next)
