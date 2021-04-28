//: [Previous](@previous)

import Foundation

/*:
 给定一个非负整数 c ，你要判断是否存在两个整数 a 和 b，使得 a^2 + b^2 = c 。
 
 示例 1：
 
 输入：c = 5
 输出：true
 解释：1 * 1 + 2 * 2 = 5
 示例 2：
 
 输入：c = 3
 输出：false
 示例 3：
 
 输入：c = 4
 输出：true
 示例 4：
 
 输入：c = 2
 输出：true
 示例 5：
 
 输入：c = 1
 输出：true
  
 
 提示：
 
 0 <= c <= 2^31 - 1
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/sum-of-square-numbers
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

let num = 1123

// 使用系统API开方 或者双指针，不过感觉太low了
func judgeSquareSum(_ c: Int) -> Bool {
    var start: Int = 0
    while start <= c {
        let dd = Double(c - start * start)
        if dd < 0 {
            return false
        }
        let result = sqrt(dd)
        let intValue = Int(result)
        if result == Double(intValue) {
            return true
        }
        start += 1
    }
    return false
}

judgeSquareSum(0)

//: [Next](@next)
