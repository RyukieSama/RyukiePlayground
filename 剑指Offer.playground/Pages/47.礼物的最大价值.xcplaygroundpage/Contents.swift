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

var pool: [[Int]] =  [
    [1, 3, 1],
    [1, 5, 1],
    [4, 2, 1]
]

pool = [
    [1,2,5],
    [3,2,1]
]

/**
 2023-03-04
 */
func maxValue230304(_ grid: [[Int]]) -> Int {
    let height = grid.count, width = grid.first?.count ?? 0
    guard height > 0, width > 0 else {
        return 0
    }
    var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: width), count: height)
    
    for y in 0..<height {
        for x in 0..<width {
            let val = grid[y][x]
            if x == 0, y == 0 {
                dp[y][x] = val
            }
            else if x == 0 {
                dp[y][x] = dp[y - 1][x] + val
            }
            else if y == 0 {
                dp[y][x] = dp[y][x - 1] + val
            }
            else {
                dp[y][x] = max(dp[y][x - 1], dp[y - 1][x]) + val
            }
        }
    }
    
    return dp[height - 1][width - 1]
}
maxValue230304(pool)

/**
 2023-02-11
 */
func maxValue23211(_ grid: [[Int]]) -> Int {
    /**
     很容易想到用动态规划
     */
    let height = grid.count, width = grid[0].count
    var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: width), count: height)
    
    for v in 0..<height {
        for h in 0..<width {
            let val = grid[v][h]
            if v == 0, h == 0 {
                dp[v][h] = val
            }
            else if v == 0, h > 0 {
                dp[v][h] = dp[v][h-1] + val
            }
            else if v > 0, h == 0 {
                dp[v][h] = dp[v-1][h] + val
            }
            else {
                dp[v][h] = max(dp[v-1][h], dp[v][h-1]) + val
            }
        }
    }
    
    return dp[height - 1][width - 1]
}

maxValue23211(pool)

// 错，会一步错，步步错
//func maxValue232112(_ grid: [[Int]]) -> Int {
//    let height = grid.count, width = grid[0].count
//    var res = 0, v = 0, h = 0
//
//    while v < height, h < width {
//        res += grid[v][h]
//        let right = h + 1 < width ? grid[v][h+1] : 0
//        let down = v + 1 < height ? grid[v+1][h] : 0
//        if right > down {
//            h += 1
//        }
//        else {
//            v += 1
//        }
//    }
//
//    return res
//}
//maxValue232112(pool)

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

maxValue(pool)

//: [Next](@next)
