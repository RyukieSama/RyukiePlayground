//: [Previous](@previous)

import Foundation

/*:
 实现 pow(x, n) ，即计算 x 的 n 次幂函数（即，xn）。不得使用库函数，同时不需要考虑大数问题。
 
 示例 1：
 
 ```
 输入：x = 2.00000, n = 10
 输出：1024.00000
 ```
 
 示例 2：
 
 ```
 输入：x = 2.10000, n = 3
 输出：9.26100
 ```
 
 示例 3：
 
 ```
 输入：x = 2.00000, n = -2
 输出：0.25000
 解释：2^(-2) = 1 / (2^(2)) = 1/4 = 0.25
 ```
 
 提示：
 
 -100.0 < x < 100.0
 -231 <= n <= 231-1
 -104 <= xn <= 104
 
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/shu-zhi-de-zheng-shu-ci-fang-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

func myPow(_ x: Double, _ n: Int) -> Double {
    // 特殊处理 0 1 -1 可以直接 return 结果
    if x == 0 || x == 1 {
        return x
    }
    else if x == -1 {
        return (n & 1 == 1 ? -1 : 1)
    }
    
    if n == 0 {
        return 1
    }
    else if n < 0 {
        return myPow(1/x, -n)
    }
    else if n == 1 {
        return x
    }
    
    let temp = myPow(x, n >> 1)
    return temp * temp * ((n & 1 == 1) ? x : 1)
}

func myPow2(_ x: Double, _ n: Int) -> Double {
    // 特殊处理 0 1 -1 可以直接 return 结果
    if x == 0 || x == 1 {
        return x
    }
    else if x == -1 {
        return (n & 1 == 1 ? -1 : 1)
    }
    
    if n == 0 {
        return 1
    }
    
    var ans: Double = 1
    var power = abs(n)
    var newX = x
    while power > 0 {
        if power & 1 == 1 {
            ans *= newX
        }
        newX *= newX
        power = power >> 1
    }
    return n < 0 ? 1 / ans : ans
}

myPow(2, 10)
myPow(2.1, 3)
myPow(2, -2)
myPow(0, 19999999)
myPow(-1, 19999999)
myPow(1, 19999999)

myPow2(2, 10)
myPow2(2.1, 3)
myPow2(2, -2)
myPow2(0, 19999999)
myPow2(-1, 19999999)
myPow2(1, 19999999)

//: [Next](@next)
