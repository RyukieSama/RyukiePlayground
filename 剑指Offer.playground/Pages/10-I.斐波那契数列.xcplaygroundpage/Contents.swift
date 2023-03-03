//: [Previous](@previous)

/*:
 写一个函数，输入 n ，求斐波那契（Fibonacci）数列的第 n 项（即 F(N)）。斐波那契数列的定义如下：
 
 F(0) = 0,   F(1) = 1
 F(N) = F(N - 1) + F(N - 2), 其中 N > 1.
 斐波那契数列由 0 和 1 开始，之后的斐波那契数就是由之前的两数相加而得出。
 
 答案需要取模 1e9+7（1000000007），如计算初始结果为：1000000008，请返回 1。
 
  
 
 示例 1：
 
 输入：n = 2
 输出：1
 示例 2：
 
 输入：n = 5
 输出：5
  
 
 提示：
 
 0 <= n <= 100
 
 
 链接：https://leetcode-cn.com/problems/fei-bo-na-qi-shu-lie-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

var basrNum = 8

/**
 2023-03-03
 */
func fib230303(_ n: Int) -> Int {
    guard n > 1 else {
        return n
    }
    var dp: [Int] = Array(repeating: 0, count: n + 1)
    dp[1] = 1
    
    for idx in 2...n {
        dp[idx] = (dp[idx - 1] + dp[idx - 2]) % 1000000007
    }
    
    return dp[n]
}
fib230303(5)



/**
 2023-02-27
 */
func fib23227(_ n: Int) -> Int {
    guard n > 1 else {
        return n
    }
    var dp: [Int] = Array(repeating: 0, count: n + 1)
    dp[0] = 0
    dp[1] = 1
    for i in 2...n {
        dp[i] = (dp[i-1] + dp[i-2]) % 1_000_000_007
    }
    return dp.last ?? 0
}
fib23227(basrNum)

// 动态规划

func fib(_ n: Int) -> Int {
    if n == 0 { return 0 }
    var dp = [Int](repeating: 0, count: n + 1)
    dp[1] = 1;
    if n >= 2 {
        for i in 2...n {
            dp[i] = (dp[i - 1] + dp[i - 2]) % 1_000_000_007
        }
    }
    return dp[n]
}

fib(basrNum)

//: [Next](@next)
