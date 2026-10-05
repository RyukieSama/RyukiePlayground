//: [上一题](@previous)

/*:
# 56-I-数组中数字出现的次数

## 题目

一个整型数组 nums 里除两个数字之外，其他数字都出现了两次。请写程序找出这两个只出现一次的数字。要求时间复杂度是O(n)，空间复杂度是O(1)。

## 用例 1

**输入：** nums = [4,1,4,6]

**输出：** [1,6] 或 [6,1]

## 用例 2

**输入：** nums = [1,2,10,4,1,4,3,3]

**输出：** [2,10] 或 [10,2]

## 约束

2 <= nums.length <= 10000

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/shu-zu-zhong-shu-zi-chu-xian-de-ci-shu-lcof)
*/
import Foundation

func countOf20261005(_ nums: [Int]) -> [Int] {
    guard nums.isEmpty == false else {
        return []
    }
    /**
     位运算 相同的数字异或的结果 == 0，所以一次循环可以过滤出 a b 异或的结果
     a b 不同 所以异或结果一定有一位是 1
     
     再把数组分成两部分，一部分这位是 1 一部分这位是 0
     两部分分别异或 就能过滤出来 a 和 b
     */
    
    var result = 0
    
    nums.forEach {
        result ^= $0
    }
    // 这时的 result 是 a b 异或的结果
    
    var one = 1
    while result & one == 0 {
        // 找 1 位
        one <<= 1
    }
    
    var a = 0, b = 0
    nums.forEach {
//        if $0 ^ one == 0 { // 这是判断两个数是否相等了
        if $0 & one == 0 {
            // 这位是 1 的元素
            a ^= $0
        }
        else {
            b ^= $0
        }
    }
    
    return [a, b]
}


func countOf(_ nums: [Int]) -> [Int] {
    var res = 0
    /**
     异或过滤出，会过滤掉相同的数字
     */
    nums.forEach {
        res ^= $0
    }
    
    /**
     必定两个不同数字，异或结果二进制位中一定有一位是 1，找到这一位
     */
    var p = 1
    while res & p == 0 {
        p <<= 1
    }
    
    /**
     由此，将数组分为两部分
     该位为 1 的，设 x 为所有元素异或的结果
     该位为 0 的，设 y 为所有元素异或的结果
     */
    var x = 0, y = 0
    
    nums.forEach {
        if $0 & p > 0 {
            // $0 这一位是1
            x ^= $0
        }
        else {
            // $0 这一位是0
            y ^= $0
        }
    }
    
    return [x, y]
}

//: [下一题](@next)
