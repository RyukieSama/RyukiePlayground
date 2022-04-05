//: [Previous](@previous)

import Foundation

/*:
 给定一个数组 nums 和滑动窗口的大小 k，请找出所有滑动窗口里的最大值。
 
 示例:
 
 输入: nums = [1,3,-1,-3,5,3,6,7], 和 k = 3
 
 输出: [3,3,5,5,6,7]
 
 解释:
 
 ```
 滑动窗口的位置                最大值
 [1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7
 ```
 
 提示：
 
 你可以假设 k 总是有效的，在输入数组不为空的情况下，1 ≤ k ≤ 输入数组的大小。
 
 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/hua-dong-chuang-kou-de-zui-da-zhi-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/*:
 动态规划
 */
func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
    var res: [Int] = []
    guard nums.isEmpty == false else {
        return res
    }
    var left = 0, right = k - 1
    /// 存放每个段落的最大值下标，Key为右边界
    var dp: [Int : Int] = [:]
    
    while right < nums.count {
        let newItem = nums[right]
        if let lastmaxIdx = dp[right - 1], lastmaxIdx >= left {// 上一个最大值在当前范围内
            let lastMax = nums[lastmaxIdx]
            if lastMax > newItem {
                res.append(lastMax)
                dp[right] = lastmaxIdx
            }
            else {
                res.append(newItem)
                dp[right] = right
            }
        }
        else {
            var curMaxIdx = right
            var curMax = nums[curMaxIdx]
            for i in left..<right {
                if nums[i] > curMax {
                    curMaxIdx = i
                    curMax = nums[curMaxIdx]
                }
            }
            res.append(curMax)
            dp[right] = curMaxIdx
        }
        
        right += 1
        left += 1
    }
    
    return res
}

let nums = [1,3,-1,-3,5,3,6,7], k = 3
//let nums: [Int] = [], k = 0
maxSlidingWindow(nums, k)

//: [Next](@next)
