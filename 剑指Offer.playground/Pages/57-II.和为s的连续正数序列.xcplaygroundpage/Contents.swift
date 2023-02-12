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

/**
 2023-02-12
 */
func findContinuousSequence23212(_ target: Int) -> [[Int]] {
    /**
     滑动窗口的重要性质是：窗口的左边界和右边界永远只能向右移动，而不能向左移动。这是为了保证滑动窗口的时间复杂度是 O(n)O(n)O(n)。如果左右边界向左移动的话，这叫做“回溯”，算法的时间复杂度就可能不止 O(n)O(n)O(n)。

     作者：nettee
     链接：https://leetcode.cn/problems/he-wei-sde-lian-xu-zheng-shu-xu-lie-lcof/solutions/133768/shi-yao-shi-hua-dong-chuang-kou-yi-ji-ru-he-yong-h/
     来源：力扣（LeetCode）
     著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
     */
    var res: [[Int]] = []
    var left = 1, right = left + 1
    
    while left <= target / 2 {
        var rangeArr: [Int] = Array(left...right)
        var sum = 0
        
        rangeArr.forEach {
            sum += $0
        }
        
        if sum < target {
            right += 1 // 窗口加宽
        }
        else if sum > target {
            left += 1// 窗口变窄
        }
        else {
            left += 1
            right += 1
            res.append(rangeArr)
        }
    }
    
    return res
}

findContinuousSequence23212(15)



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
