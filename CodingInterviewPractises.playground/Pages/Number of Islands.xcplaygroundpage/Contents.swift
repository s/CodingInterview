//: [Previous](@previous)
/*:
 # 200. Number of Islands
 
 Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.

 An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.
 */
import Foundation

class Solution {
    func numIslands(_ grid: [[Character]]) -> Int {
        guard !grid.isEmpty else { return 0 }
        var visited: [[Int]] = Array(repeating:Array(repeating:0, count: grid[0].count), count:grid.count)
        var numIslands: Int = 0
        
        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                if grid[i][j] == Character("1") {
                    numIslands += dfs(grid, visited:&visited, i: i, j: j)
                }
            }
        }
        
        return numIslands
    }
    
    func dfs(_ grid: [[Character]], visited: inout [[Int]], i: Int, j: Int) -> Int {
        guard
            i >= 0,
            j >= 0,
            i < grid.count,
            j < grid[i].count,
            grid[i][j] == Character("1"),
            visited[i][j] == 0
        else {
            return 0
        }
        visited[i][j] = 1
        dfs(grid, visited:&visited, i: i+1, j: j)
        dfs(grid, visited:&visited, i: i-1, j: j)
        dfs(grid, visited:&visited, i: i, j: j+1)
        dfs(grid, visited:&visited, i: i, j: j-1)
        return  1
    }
}

//: [Next](@next)
