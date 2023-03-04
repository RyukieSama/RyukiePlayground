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

var nums = [1,3,-1,-3,5,3,6,7], k = 3
//nums = []
//k = 0

/**
 2023-03-04
 
 认真审题。。。
 */
func maxSlidingWindow230304(_ nums: [Int], _ k: Int) -> [Int] {
    guard nums.isEmpty == false, k > 0 else {
        return []
    }
    var left = 0, sum = 0, right = k - 1, maxPair = (left, right)
    
    for idx in 0...right {
        sum += nums[idx]
    }
    
    while right < nums.count {
        if right + 1 < nums.count {
            let nextSum = (sum - nums[left] + nums[right + 1])
            if nextSum > sum {
                maxPair = (left + 1, right + 1)
                sum = nextSum
            }
        }
        left += 1
        right += 1
    }
    
    return Array(nums[maxPair.0...maxPair.1])
}
maxSlidingWindow230304(nums, 3)

/**
 2023-02-13
 */
// 超时，内部循环虽然去除了一些情况，还是会有较多的循环
//func maxSlidingWindow23213(_ nums: [Int], _ k: Int) -> [Int] {
//    if nums.count == 0 || nums.count < k { return [] }
//
//    var left = 0, right = left + k - 1
//    var res: [Int] = []
//
//    while right < nums.count {
//        let sub = Array(nums[left...right])
//        let val = nums[right]
//        if let last = res.last {
//            if last < val {
//                // 窗口新元素比旧窗口的最大值还大，那么窗口最大值就是这个值
//                res.append(val)
//            }
//            else {
//                // 窗口新元素比前一个窗口的最大值小
//                if nums[left - 1] < last {
//                    // 旧窗口的第一个元素不是最大值
//                    res.append(last)
//                }
//                else if let max = sub.max() {
//                    // 旧窗口的第一个元素是最大值，就要在 sub 里面重新找最大值了
//                    res.append(max)
//                }
//            }
//        }
//        else if let max = sub.max() {
//            res.append(max)
//        }
//        left += 1
//        right += 1
//    }
//
//    return res
//}

func maxSlidingWindow23213(_ nums: [Int], _ k: Int) -> [Int] {
    if nums.count == 0 || nums.count < k { return [] }
    
    var left = 0, right = left + k - 1
    var res: [Int] = [], dp: [Int: Int] = [:] // key: 右边界 val：最大值所在下标

    while right < nums.count {
        let valNew = nums[right]
        
        if let lastMaxValIdx = dp[right - 1], lastMaxValIdx >= left {
            // 上一个滑动窗口最大值的下标，在当前滑动窗口内部
            let lastMax = nums[lastMaxValIdx]
//            print("=")
            if lastMax > valNew {
                res.append(lastMax)
                dp[right] = lastMaxValIdx
            }
            else {
                res.append(valNew)
                dp[right] = right
            }
        }
        else {
            var maxIdx: Int = left, max: Int = nums[maxIdx]
            
            for idx in left...right {
                let val = nums[idx]
//                print(idx)
                if val >= max {
                    max = val
                    maxIdx = idx
                }
            }
            
            res.append(max)
            dp[right] = maxIdx
        }
        
        left += 1
        right += 1
    }
    
    return res
}
maxSlidingWindow23213(nums, k)


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

maxSlidingWindow(nums, k)

//: [Next](@next)
