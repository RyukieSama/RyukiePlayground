//: [Previous](@previous)

/*:
 一只青蛙一次可以跳上1级台阶，也可以跳上2级台阶。求该青蛙跳上一个 n 级的台阶总共有多少种跳法。
 
 答案需要取模 1e9+7（1000000007），如计算初始结果为：1000000008，请返回 1。
 
 示例 1：
 
 输入：n = 2
 输出：2
 示例 2：
 
 输入：n = 7
 输出：21
 示例 3：
 
 输入：n = 0
 输出：1
 提示：
 
 0 <= n <= 100
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/qing-wa-tiao-tai-jie-wen-ti-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

let floor = 100

// 错误思路：没算出来
//// X + 2Y = n -> y = (n - x) / 2 -> Y是整数
//
//// 还要进行排序，x个1 y个2 的组合有多少种形态
//
//func numWays(_ n: Int) -> Int {
//    var count = 0
//
//    for num in 0...n {
//        if (n - num) % 2 == 0 {
//            count += 1
//        }
//    }
//
//    return count % 1_000_000_007
//}

// 其实就是斐波拉契数列
// 跳n阶楼梯的方法数=跳n-1阶楼梯的方法数+跳n-2阶楼梯的方法数
// 动态规划

func numWays(_ n: Int) -> Int {
    if n == 0 {
        return 1
    }
    var dp: [Int] = [Int](repeating: 0, count: n + 1)
    dp[0] = 1
    dp[1] = 1
    
    if n >= 2 {
        for index in 2...n {
            dp[index] = (dp[index - 1] + dp[index - 2]) % 1_000_000_007
        }
    }
    
    return dp[n]
}

// 优化 空间压缩 只需要保存 n-1 和 n-2 的就行
func numWays2(_ n: Int) -> Int {
    if n >= 2 {
        // n-2
        var a = 1
        // n-1
        var b = 1
        var c = 0
        
        for _ in 2...n {
            c = (a + b) % 1_000_000_007
            a = b
            b = c
        }
        
        return c
    }
    return 1
}


numWays(floor)

numWays2(floor)

//: [Next](@next)
