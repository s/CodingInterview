//: [Previous](@previous)
/*:
 # 70. Climbing Stairs
 You are climbing a staircase. It takes n steps to reach the top.

 Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
 */
import Foundation

class Solution {
    func climbStairs(_ n: Int) -> Int {
        // var mem: [Int: Int] = [:]
        // return _climbStairs(n, &mem)
        return _climbingStairsDP(n)
    }
    
    /*
     Runtime: 0 ms, faster than 100.00% of Swift online submissions for Climbing Stairs.
     Memory Usage: 14.2 MB, less than 9.05% of Swift online submissions for Climbing Stairs.
     */
    func _climbStairs(_ n: Int, _ mem: inout [Int: Int]) -> Int {
        if n == 0 { return 1 }
        if n < 0 { return 0 }
        if let ans = mem[n] { return ans }
        mem[n] = _climbStairs(n-1, &mem) + _climbStairs(n-2, &mem)
        return mem[n] ?? 0
    }
    
    /*
     Runtime: 0 ms, faster than 100.00% of Swift online submissions for Climbing Stairs.
     Memory Usage: 13.9 MB, less than 48.62% of Swift online submissions for Climbing Stairs.
     */
    func _climbingStairsDP(_ n: Int) -> Int {
        var dp: [Int] = Array()
        dp.append(contentsOf: [0, 1, 2])
        if n < 3 { return dp[n] }
        for i in 3...n {
            dp.append(dp[i-1] + dp[i-2])
        }
        return dp[n]
    }
}

//: [Next](@next)
