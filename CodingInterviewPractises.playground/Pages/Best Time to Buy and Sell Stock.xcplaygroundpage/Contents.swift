//: [Previous](@previous)
/*:
 
 You are given an array prices where prices[i] is the price of a given stock on the ith day.

 You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.

 Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.

 ```
 Example 1:

 Input: prices = [7,1,5,3,6,4]
 Output: 5
 Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
 Note that buying on day 2 and selling on day 1 is not allowed because you must buy before you sell.
 ```
 
 ```
 Example 2:

 Input: prices = [7,6,4,3,1]
 Output: 0
 Explanation: In this case, no transactions are done and the max profit = 0.
 ```
 */

import Foundation

class Solution {
    /*
     Brute Force: Time Limit Exceeded
     */
    func maxProfit_bruteForce(_ prices: [Int]) -> Int {
        guard !prices.isEmpty else { return 0 }
        var maxProfit = Int.min
        var curProfit = 0
        for i in 0..<(prices.count - 1)  {
            for j in (i+1)..<prices.count {
                curProfit = prices[j] - prices[i]
                if curProfit > maxProfit {
                    maxProfit = curProfit
                }
            }
        }
        return max(0, maxProfit)
    }
    
    /*
     Runtime: 896 ms, faster than 81.26% of Swift online submissions for Best Time to Buy and Sell Stock.
     Memory Usage: 17.7 MB, less than 44.62% of Swift online submissions for Best Time to Buy and Sell Stock.
     */
    func maxProfit(_ prices: [Int]) -> Int {
        guard !prices.isEmpty, let first = prices.first else { return 0 }
        var minEntry = first
        var maxProfit = 0
        
        for i in 1..<prices.count {
            if prices[i] < minEntry {
                minEntry = prices[i]
            }
            maxProfit = max(prices[i] - minEntry, maxProfit)
        }
        return maxProfit
    }
}


//: [Next](@next)
