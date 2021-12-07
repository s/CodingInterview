//: [Previous](@previous)
/*:
 
 We build a table of n rows (1-indexed). We start by writing 0 in the 1st row. Now in every subsequent row, we look at the previous row and replace each occurrence of 0 with 01, and each occurrence of 1 with 10.

 For example, for n = 3, the 1st row is 0, the 2nd row is 01, and the 3rd row is 0110.
 Given two integer n and k, return the kth (1-indexed) symbol in the nth row of a table of n rows.

 ```
 Example 1:

 Input: n = 1, k = 1
 Output: 0
 Explanation: row 1: 0
 ```
 
 ```
 Example 2:

 Input: n = 2, k = 1
 Output: 0
 Explanation:
 row 1: 0
 row 2: 01
 ```
 
 ```
 Example 3:

 Input: n = 2, k = 2
 Output: 1
 Explanation:
 row 1: 0
 row 2: 01
 ```
 
 ```
 Example 4:

 Input: n = 3, k = 1
 Output: 0
 Explanation:
 row 1: 0
 row 2: 01
 row 3: 0110
 ```
 */

import Foundation

class Solution {
    func kthGrammar(_ n: Int, _ k: Int) -> Int {
        if k == 1, n == 1 { return 0 }
        let middleIndex = Int(pow(Double(2), Double(n-1))) / 2
        
        if k <= middleIndex {
            return kthGrammar(n-1, k)
        }
        return kthGrammar(n-1, k-middleIndex) == 0 ? 1 : 0
        
        // n = 5, k = 15, mid = 8
        // n = 4, k = 8, mid = 4
        // n = 3, k = 4, mid = 2
        // n = 2, k = 2, mid = 1
        // n = 1,
    }
    
    func __kthGrammar(_ n: Int, _ k: Int) -> Int {
        // Rows:
        // 0
        // 0 1
        // 0 1 10
        // 0 1 10 1001
        // 0 1 10 1001 10010110
        
        
        /*
            f(n, k) -> Int {
                guard k > 1 else { return 0 }
        
                if k % 2 == 0 {
                    if f(n-1, k/2) == 0 { return 1 }    // because 0 becomes 0(1)
                    else { return 0 }                   // because 1 becomes 1(0)
                } else {
                    return f(n-1, k/2)
                }
            }
        */
        
        // (n, k), val
        // 5, 5 => 4, 3
        // 4, 3 => 2, 2
        // 2, 2 => 1, 1
        
        guard n > 1, k > 1 else { return 0 }
        let newK: Int = Int(ceil(Double(k) / 2))
        let prev = kthGrammar(n-1, newK)
        if k % 2 == 0 {
            return (prev == 0) ? 1 : 0
        }
        return prev
        
        // Some observations:
        // 1. In each row we have pow(2, n-1) charachters long entry
        // 2. The nth row's entry has two parts: (first_part) + (second_part)
        // 3. XOR(first_part, second_part) = 1
    }
    
    /*
     First Attempt
     Output Limit Exceeded
     */
    func _kthGrammar(_ n: Int, _ k: Int) -> Int {
        var arr: [String] = []
        arr.append("-")
        arr.append("0")
        // -
        // 0
        // 01
        // 0110
        // 1. Initialize first row with "0"
        // 2. Check if we have nth row in the store
        // 3. Check if we have n-1 in the store
            // 3.1. If we don't have it, calculate n-1
        // 4. Calculate nth row based on the n-1
        return findKthGrammar(n, k, &arr)
    }
    
    private func calculateNthRow(_ n: Int, _ arr: inout [String]) -> String {
        if arr.count > n {
            return arr[n]
        }
        let prev = calculateNthRow(n-1, &arr)
        let cur = generateNext(from: prev)
        arr.insert(cur, at: n)
        print(arr)
        return cur
    }
    
    private func generateNext(from: String) -> String {
        var res = ""
        for ch in from {
            if ch == "0" {
                res.append("01")
            } else if ch == "1" {
                res.append("10")
            }
        }
        return res
    }
    
    private func findKthGrammar(_ n: Int, _ k: Int, _ arr: inout [String]) -> Int {
        guard arr.count <= n else {
            let res = arr[n]
            if let resStr = res[k-1], let resInt = Int(resStr) {
                return resInt
            }
            fatalError("This code should never execute")
        }
        
        let nthRow = calculateNthRow(n, &arr)
        print(nthRow, arr)
        guard let resStr = nthRow[k-1], let resInt = Int(resStr) else { return -1 }
        return resInt
    }
}

extension String {
    subscript(_ idx: Int) -> String? {
        guard idx < self.count else { return nil }
        let offsetIdx = self.index(self.startIndex, offsetBy: idx)
        return String(self[offsetIdx])
    }
}

//: [Next](@next)
print(Solution().helper(4))
