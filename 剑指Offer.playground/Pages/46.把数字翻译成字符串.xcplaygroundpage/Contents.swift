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
    
    return dp[stringArr.count - 1]
}

let num = 12258
translateNum(num)

//: [Next](@next)
