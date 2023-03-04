//: [Previous](@previous)

/*:
 
 给定一个数字，我们按照如下规则把它翻译为字符串：0 翻译成 “a” ，1 翻译成 “b”，……，11 翻译成 “l”，……，25 翻译成 “z”。一个数字可能有多个翻译。请编程实现一个函数，用来计算一个数字有多少种不同的翻译方法。
 
 示例 1:
 
 输入: 12258
 
 输出: 5
 
 解释: 12258有5种不同的翻译，分别是"bccfi", "bwfi", "bczi", "mcfi"和"mzi"
 
 提示：
 
 0 <= num < 231
 
 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/ba-shu-zi-fan-yi-cheng-zi-fu-chuan-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */

import Foundation

var num = 1225//8

/**
 2023-03-04
 */
func translateNum230304(_ num: Int) -> Int {
    var numbers: [Int] = []
    Array(String(num)).forEach {
        if let n = Int(String($0)) {
            numbers.append(n)
        }
    }
    
    guard numbers.isEmpty == false else {
        return 0
    }
    var dp: [Int] = Array(repeating: 0, count: numbers.count)
    
    for idx in 0..<numbers.count {
        let val = numbers[idx]
        guard idx > 0 else {
            dp[idx] = 1
            continue
        }

        let last = numbers[idx - 1], sum = last * 10 + val
        
        if sum >= 10, sum <= 25 { // 可以分两个
            // 选择分或者不分
            if idx > 1 {
                dp[idx] = dp[idx - 2] + dp[idx - 1] // 不分 + 分
            }
            else {
                dp[idx] = 1 + dp[idx - 1] // 不分 + 分
            }
        }
        else {
            dp[idx] = dp[idx - 1]
        }
    }
    
    return dp[numbers.count - 1]
}
translateNum230304(num)

/**
 dp[0] = 1
 dp[1] = 1,2-12 = 2
 dp[2] = 1,2,2-1,22-12,2 = 3
 dp[3] = 1,2,2,5-12,25-12,2,5-1,2,25-1,22,5 = 5
 dp[4] = dp[3]
 */

/**
 2023-02-10
 */
func translateNum23210(_ num: Int) -> Int {
    /**
     就是看能分成对少种形式 按照 0～25 划分
     两种划分方式 一位 或者 两位
     动态规划
     */
    var numbers: [Int] = []
    Array("\(num)").forEach {
        if let n = Int(String($0)) {
            numbers.append(n)
        }
    }
    // dp[i] = 下标为 i 的子数组有多少种划分方式
    var dp: [Int] = Array(repeating: 1, count: numbers.count)
    var idx = 0
    
    while idx < numbers.count {
        if idx > 0 {
            let last = numbers[idx - 1]
            
            if last == 0 { // 上一位为 0，这位没得选
                dp[idx] = dp[idx - 1]
            }
            else { // 不为0就看上一位作为10位再加上这一位的值，是否在 10 ～ 25 范围内
                let temp = last * 10 + numbers[idx]
                if temp >= 10, temp <= 25 {
                    dp[idx] = idx > 1 ? dp[idx - 2] + dp[idx - 1] : dp[idx - 1] + 1
                }
                else {
                    dp[idx] = dp[idx - 1]
                }
            }
        }
        else {
            dp[idx] = 1
        }
        idx += 1
    }
    
    print(dp)
    
    return dp[numbers.count - 1]
}
translateNum23210(num)

/**
 其实就是求拆分为小于等于 25 的子数组有多少种
 */

func translateNum(_ num: Int) -> Int {
    let stringArr: [Character] = Array(String(num))
    var dp: [Int] = Array(repeating: 1, count: stringArr.count)
    var idx = 1
    
    while idx < stringArr.count {
        if idx >= 1, let pre = Int(String(stringArr[(idx - 1)...idx])), pre <= 25, pre >= 10 {
            if idx > 1 {
                dp[idx] = dp[idx - 2] + dp[idx - 1]
            }
            else {
                dp[idx] = 2
            }
        }
        else {
            dp[idx] = dp[idx - 1]
        }
        idx += 1
    }
    
    print(dp)
    
    return dp[stringArr.count - 1]
}

translateNum(num)

//: [Next](@next)
