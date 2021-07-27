//: [Previous](@previous)

import Foundation

/*:
 给你一根长度为 n 的绳子，请把绳子剪成整数长度的 m 段（m、n都是整数，n>1并且m>1），每段绳子的长度记为 k[0],k[1]...k[m - 1] 。请问 k[0]*k[1]*...*k[m - 1] 可能的最大乘积是多少？例如，当绳子的长度是8时，我们把它剪成长度分别为2、3、3的三段，此时得到的最大乘积是18。

 答案需要取模 1e9+7（1000000007），如计算初始结果为：1000000008，请返回 1。

 示例 1：

 ```Swift
 输入: 2
 输出: 1
 解释: 2 = 1 + 1, 1 × 1 = 1
 ```
 
 示例 2:

 ```Swift
 输入: 10
 输出: 36
 解释: 10 = 3 + 3 + 4, 3 × 3 × 4 = 36
  ```

 提示：

 2 <= n <= 1000
 
 注意：本题与[主站 343 题](https://leetcode-cn.com/problems/integer-break/)相同

 来源：[力扣（LeetCode）](https://leetcode-cn.com/problems/jian-sheng-zi-ii-lcof)
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/**
 超出范围
 */
func cuttingRope(_ n: Int) -> Int {
    if n < 4 {
        return n - 1
    }
    var dp = [Int](repeating: 1, count: n + 1)
    for i in 3...n {
        for j in 2..<i {
            dp[i] = max(dp[i], max(j * (i - j), j * dp[i - j]))
        }
    }
    return dp[n] % 1_000_000_007
}


/**
 255 时精度丢失
 */
func cuttingRope2(_ n: Int) -> Int {
    let base = NSDecimalNumber(decimal: Decimal(1_000_000_007))
    
    if n < 4 {
        return n - 1
    }

    var dp = [Decimal](repeating: 1, count: n + 1)
    for i in 3...n {
        for j in 2..<i {
            dp[i] = max(dp[i], max(Decimal(j) * Decimal(i - j), Decimal(j) * dp[i - j]))
        }
    }

    let handler = NSDecimalNumberHandler(roundingMode: .down, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)

    let result = NSDecimalNumber(decimal: dp[n])
    let baseCount = result.dividing(by: base).rounding(accordingToBehavior: handler)

    let tp = result.subtracting(base.multiplying(by: baseCount))

    return Int(truncating: tp)
}

//cuttingRope2(255)
//cuttingRope2(120)

func cuttingRope3(_ n: Int) -> Int {
    if n < 4 {
        return n - 1
    }
    var res = 1
    var n = n
    while n > 4 {
        res = res * 3 % 1_000_000_007
        n -= 3
    }
    return res * n % 1_000_000_007
}

//cuttingRope3(255)

/**
 快速幂
 */
func cuttingRope4(_ n: Int) -> Int {
    if n < 4 {
        return n - 1
    }
    let a = n / 3, b = n % 3
    
    if b == 0 {
        return modPow(3, a) % 1_000_000_007
    }
    else if b == 1 {
        return modPow(3, a - 1) * 4 % 1_000_000_007
    }
    else {
        return modPow(3, a) * 2 % 1_000_000_007
    }
}

func modPow(_ x: Int, _ n: Int) -> Int {
    var res = 1
    var x = x
    var n = n
    
    while n > 0 {
        if n & 1 == 1 {
            res *= x
            res %= 1_000_000_007 // 限制了数据范围
        }
        x *= x
        x %= 1_000_000_007 // 限制了数据范围
        n >>= 1
    }
    
    return res
}

cuttingRope4(255)
cuttingRope4(5)

//: [Next](@next)
