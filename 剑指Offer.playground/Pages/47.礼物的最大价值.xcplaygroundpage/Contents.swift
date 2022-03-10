//: [Previous](@previous)


/*:
 
 在一个 m*n 的棋盘的每一格都放有一个礼物，每个礼物都有一定的价值（价值大于 0）。你可以从棋盘的左上角开始拿格子里的礼物，并每次向右或者向下移动一格、直到到达棋盘的右下角。给定一个棋盘及其上面的礼物的价值，请计算你最多能拿到多少价值的礼物？
  
 示例 1:
 
 输入:
 [
   [1,3,1],
   [1,5,1],
   [4,2,1]
 ]
 输出: 12
 解释: 路径 1→3→5→2→1 可以拿到最多价值的礼物
  
 
 提示：
 
 0 < grid.length <= 200
 0 < grid[0].length <= 200
 
 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/li-wu-de-zui-da-jie-zhi-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */

import Foundation

func maxValue(_ grid: [[Int]]) -> Int {
    let w = grid[0].count
    let h = grid.count
    var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: w), count: h)
    
    for y in 0..<h {
        for x in 0..<w {
            let value = grid[y][x]
            if x == 0, y == 0 { dp[y][x] = value }
            else if y == 0, x > 0 { dp[y][x] = dp[y][x-1] + value }
            else if y > 0, x == 0 { dp[y][x] = dp[y-1][x] + value }
            else { dp[y][x] = max(dp[y][x-1], dp[y-1][x]) + value }
        }
    }
    
    return dp[h-1][w-1]
}

let pool: [[Int]] =  [
    [1, 3, 1],
    [1, 5, 1],
    [4, 2, 1]
]
maxValue(pool)

//: [Next](@next)
