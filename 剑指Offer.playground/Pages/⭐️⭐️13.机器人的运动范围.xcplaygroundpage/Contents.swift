//: [Previous](@previous)

import Foundation

/*:
 地上有一个m行n列的方格，从坐标 [0,0] 到坐标 [m-1,n-1] 。
 
 一个机器人从坐标 [0, 0] 的格子开始移动，它每次可以向左、右、上、下移动一格（不能移动到方格外），也不能进入行坐标和列坐标的数位之和大于k的格子。
 
 例如，当k为18时，机器人能够进入方格 [35, 37] ，因为3+5+3+7=18。但它不能进入方格 [35, 38]，因为3+5+3+8=19。请问该机器人能够到达多少个格子？
 
 
 示例 1：
 
 ```C++
 输入：m = 2, n = 3, k = 1
 输出：3
 ```
 
 示例 2：
 
 ```C++
 输入：m = 3, n = 1, k = 0
 输出：1
 ```
 
 提示：
 
 ```C++
 1 <= n,m <= 100
 0 <= k <= 20
 ```
 
 来源：力扣（LeetCode）
 
 
 链接：https://leetcode-cn.com/problems/ji-qi-ren-de-yun-dong-fan-wei-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/**
 回溯法
 */

func movingCount(_ m: Int, _ n: Int, _ k: Int) -> Int {
    if m <= 0 || n <= 0 || k < 0 {
        return 0
    }
    var flags: [[Bool]] = Array(repeating: Array(repeating: false, count: n), count: m)
    return moveTo(0, 0, k, flags: &flags)
}

func moveTo(_ x: Int, _ y: Int, _ k: Int, flags: inout [[Bool]]) -> Int {
    if (x < 0 || x >= flags.first?.count ?? 0) ||
        (y < 0 || y >= flags.count) ||
        (flags[y][x] == true) ||
        (digitSum(x) + digitSum(y) > k)
    {
        return 0
    }
    
    flags[y][x] = true
    
    let count = 1
        + moveTo(x + 1, y, k, flags: &flags)
        + moveTo(x - 1, y, k, flags: &flags)
        + moveTo(x, y + 1, k, flags: &flags)
        + moveTo(x, y - 1, k, flags: &flags)
    
    return count
}

func digitSum(_ num: Int) -> Int {
    var temp = num
    var result = 0
    while temp > 0 {
        result += temp % 10
        temp = Int(floor(Double(temp) / 10.0))
    }
    return result
}

digitSum(191111111)

let m = 2, n = 3, k = 1
//let m = 3, n = 1, k = 0

movingCount(m, n, k)

//: [Next](@next)
