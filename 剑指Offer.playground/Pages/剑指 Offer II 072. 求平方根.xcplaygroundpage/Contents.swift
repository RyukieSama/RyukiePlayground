//: [Previous](@previous)

import Foundation

/*:
 
 给定一个非负整数 x ，计算并返回 x 的平方根，即实现 int sqrt(int x) 函数。

 正数的平方根有两个，只输出其中的正数平方根。

 如果平方根不是整数，输出只保留整数的部分，小数部分将被舍去。

  

 示例 1:

 输入: x = 4
 输出: 2
 示例 2:

 输入: x = 8
 输出: 2
 解释: 8 的平方根是 2.82842...，由于小数部分将被舍去，所以返回 2
  

 提示:

 0 <= x <= 231 - 1
  

 注意：本题与主站 69 题相同： https://leetcode-cn.com/problems/sqrtx/
 
 */

var number = 8
//number = 0
//number = 1
/**
 2023-02-21
 
 标记为简单，但还是有点儿难度
 */

// 超时
func mySqrt(_ x: Int) -> Int {
    guard x > 0 else {
        return 0
    }
    var left = 1, right = x
    var res = 0
    
    while left <= right {
        var temp = (left + right) / 2
        if temp * temp <= x {
            res = temp
            left += 1
        }
        else {
            right -= 1
        }
    }
    
    return res
}

mySqrt(number)

func mySqrt23221(_ x: Int) -> Int {
    var left = 1, right = x
    var res = 0
    
    while left <= right {
        var temp = left + ((right - left) >> 1)
        if temp * temp <= x {
            res = temp
            left = temp + 1
        }
        else {
            right = temp - 1
        }
    }
    
    return res
}

mySqrt23221(number)
//: [Next](@next)
