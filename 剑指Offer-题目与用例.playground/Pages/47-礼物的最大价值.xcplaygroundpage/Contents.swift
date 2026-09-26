//: [上一题](@previous)

/*:
# 47-礼物的最大价值

## 题目

在一个 m*n 的棋盘的每一格都放有一个礼物，每个礼物都有一定的价值（价值大于 0）。你可以从棋盘的左上角开始拿格子里的礼物，并每次向右或者向下移动一格、直到到达棋盘的右下角。给定一个棋盘及其上面的礼物的价值，请计算你最多能拿到多少价值的礼物？

## 用例 1

**输入：** 
[
[1,3,1],
[1,5,1],
[4,2,1]
]
**输出：** 12
解释: 路径 1→3→5→2→1 可以拿到最多价值的礼物

## 提示

0 < grid.length <= 200
0 < grid[0].length <= 200

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/li-wu-de-zui-da-jie-zhi-lcof)
*/

func maxGift(_ grid: [[Int]]) -> Int {
    let height = grid.count
    
    guard
        let firstLine = grid.first
    else {
        return 0
    }
    
    let width = firstLine.count
    
    guard width > 0, height > 0 else {
        return 0
    }
    
    var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: width), count: height)
    
    for y in 0..<height {
        for x in 0..<width {
            let val = grid[y][x]
            
            if x == 0, y == 0 {
                dp[y][x] = val
            }
            else if y == 0 {
                dp[y][x] = dp[y][x - 1] + val
            }
            else if x == 0 {
                dp[y][x] = dp[y - 1][x] + val
            }
            else {
                dp[y][x] = max(dp[y-1][x], dp[y][x-1]) + val
            }
            
        }
    }
    
    return dp[height - 1][width - 1]
}

/*:
## 题目解析

这道题要求从左上角走到右下角，每次只能向右或向下，求路径上礼物价值的最大和。它是一个二维动态规划问题。

### 行和列

二维数组的访问方式是 `grid[行][列]`。因此 `height` 表示行数，`width` 表示列数，外层循环遍历 `y` 行，内层循环遍历 `x` 列。之前把两个范围写反时，正方形矩阵可能看不出问题，但矩形矩阵会访问越界。

### 状态定义

`dp[y][x]` 表示从左上角走到位置 `(y, x)` 时能够获得的最大礼物价值。当前位置只能从上方或左方到达，所以普通位置的转移是：

`dp[y][x] = max(dp[y - 1][x], dp[y][x - 1]) + grid[y][x]`

### 边界情况

- 左上角没有前驱，直接取当前格子的价值。
- 第一行只能从左边到达。
- 第一列只能从上面到达。
- 其他格子比较上方和左方的最大路径。

以示例棋盘计算后，`dp` 为：

`1  4  5`

`2  9  10`

`6  11  12`

右下角的 `12` 就是最大礼物价值。当前实现已经正确处理这四种情况。

### 复杂度

- 时间复杂度：`O(height × width)`，每个格子只计算一次。
- 额外空间复杂度：`O(height × width)`，用于保存 `dp` 数组。

题目保证输入是规则矩阵，因此使用第一行的列数作为 `width` 是安全的。
*/
//: [下一题](@next)
