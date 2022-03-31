//: [Previous](@previous)

import Foundation

/*:
 输入一个正整数 target ，输出所有和为 target 的连续正整数序列（至少含有两个数）。

 序列内的数字由小到大排列，不同序列按照首个数字从小到大排列。

 示例 1：

 输入：target = 9
 
 输出：[[2,3,4],[4,5]]
 
 示例 2：

 输入：target = 15
 
 输出：[[1,2,3,4,5],[4,5,6],[7,8]]
  
 限制：

 1 <= target <= 10^5

 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/he-wei-sde-lian-xu-zheng-shu-xu-lie-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/*:
 这种找范围的双指针很常见
 */
func findContinuousSequence(_ target: Int) -> [[Int]] {
    var res: [[Int]] = []
    var left = 1, right = 2
    
    while left < right {
        let temp: [Int] = Array(left...right)
        var sum = 0
        temp.forEach { sum += $0 }
        if sum == target {
            res.append(temp)
        }
        
        if sum >= target {
            left += 1
        }
        else {
            right += 1
        }
    }
    
    return res.isEmpty ? [] : res
}

/*:
 优化
 */
func findContinuousSequence2(_ target: Int) -> [[Int]] {
    var res: [[Int]] = []
    var left = 1, right = 2
    var sum = 3
    
    while left < right {
        if sum == target {
            let temp: [Int] = Array(left...right)
            res.append(temp)
        }
        
        if sum >= target {
            sum -= left
            left += 1
        }
        else {
            right += 1
            sum += right
        }
    }
    
    return res.isEmpty ? [] : res
}

findContinuousSequence(15)
findContinuousSequence2(15)

//: [Next](@next)
