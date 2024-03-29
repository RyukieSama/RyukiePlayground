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

/*
 2023-03-03
 **/
func myPow230303(_ x: Double, _ n: Int) -> Double {
    guard n != 0 else {
        return 1
    }
    
    let half = n > 0 ? myPow230303(x, n >> 1) : myPow230303(1/x, (-n) >> 1)
    
    if abs(n) & 1 == 0 {
        return half * half
    }
    else {
        return half * half * (n > 0 ? x : (1 / x))
    }
}
//myPow230303(2, -2)
myPow230303(34.00515, -3)

/**
 2023-02-27
 */
func myPow23227(_ x: Double, _ n: Int) -> Double {
    // 二分
    if n == 0 { return 1 }
    if n == 1 { return x }
    let half = n > 0 ? myPow23227(x, n >> 1) : myPow23227(1 / x, (-n) >> 1)
    return abs(n) & 1 == 0 ? half * half : half * half * (n > 0 ? x : 1 / x)
}
//myPow23227(10, 2)
//myPow23227(2, -2)
myPow23227(34.00515, -3)


/**
 2023-02-04
 
 二分
 
 */
func myPow3(_ x: Double, _ n: Int) -> Double {
    guard n != 0 else { return 1 }
    var res: Double = n > 0 ? myPow3(x, n >> 1) : myPow3(1 / x, -(n >> 1))
    return res * res * (n & 1 == 1 ? x : 1)
}
myPow3(34.00515, -3)

// 逻辑一样用除法不行就很奇怪
//func myPow3(_ x: Double, _ n: Int) -> Double {
//    guard n != 0 else { return 1 }
//
//    var n = n
//    var res: Double = 0
//
//    if n > 0 {
//        res = myPow3(x, n / 2)
//    }
//    else {
//        res = myPow3(1 / x, -(n / 2))
//    }
//
//    if n & 1 == 1 {
//        return res * res * x
//    }
//    return res * res
//}

myPow3(34.00515, -3)
myPow3(2, 10)
//myPow3(2.1, 3)
myPow3(2, -2)
//myPow3(0, 19999999)
//myPow3(-1, 19999999)
//myPow3(1, 19999999)

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
