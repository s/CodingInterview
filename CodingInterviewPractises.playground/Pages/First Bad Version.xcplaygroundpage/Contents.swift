//: [Previous](@previous)
/*:
 # 278. First Bad Version

 You are a product manager and currently leading a team to develop a new product. Unfortunately, the latest version of your product fails the quality check. Since each version is developed based on the previous version, all the versions after a bad version are also bad.

 Suppose you have n versions [1, 2, ..., n] and you want to find out the first bad one, which causes all the following ones to be bad.

 You are given an API bool isBadVersion(version) which returns whether version is bad. Implement a function to find the first bad version. You should minimize the number of calls to the API.
 
 
 ```
 Input: n = 5, bad = 4
 
 Output: 4
 
 Explanation:
 call isBadVersion(3) -> false
 call isBadVersion(5) -> true
 call isBadVersion(4) -> true
 Then 4 is the first bad version.
 ```
 
 ```
 Input: n = 1, bad = 1
 Output: 1
 ```
 
Constraints: 1 <= bad <= n <= 231 - 1
 */

class VersionControl {
    static let badVersion = 4
    func isBadVersion(_ n: Int) -> Bool {
        Self.badVersion == n
    }
}
class Solution : VersionControl {
    
    func _binarySearch(l: Int, r: Int) -> Int {
        guard l < r else { return l }
        let m = (r+l) / 2
        guard !isBadVersion(m) else {
            return binarySearch(l: l, r: m)
        }
        return binarySearch(l: m+1, r: r)
    }
    
    func binarySearch(l: Int, r: Int) -> Int {
        guard l < r else { return l }
        let m = l + (r - l) / 2
        if isBadVersion(m) {
            return binarySearch(l: l, r: m)
        }
        return binarySearch(l: m+1, r: r)
    }

    func firstBadVersion(_ n: Int) -> Int {
        return binarySearch(l: 1, r: n)
    }
    
    func _firstBadVersion(_ n: Int) -> Int {
        var left: Int = 1
        var right: Int = n
        var middle: Int = right / 2
        
        while left < right {
            middle = left + (right - left) / 2
            if isBadVersion(middle) {
                left = middle + 1
            } else {
                right = middle
            }
        }
        return left
    }
    
    func ___firstBadVersion(_ n: Int) -> Int {
        guard n > 0 else { return 0 }
        guard n > 1 else { return isBadVersion(1) ? 1 : 0 }
        
        var left: Int = 0
        var right: Int = n
        var middle: Int = right / 2
        
        while left + 1 < right {
            if isBadVersion(middle) {
                right = middle
                middle = (right - left) / 2
            } else {
                left = middle
                middle = left + ((right - left) / 2)
            }
        }
        if isBadVersion(right) {
            return right
        }
        return middle
    }
}
//: [Next](@next)
