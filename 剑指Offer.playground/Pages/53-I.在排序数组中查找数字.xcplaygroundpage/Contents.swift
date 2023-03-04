//: [Previous](@previous)

import Foundation

/*:
 统计一个数字在排序数组中出现的次数。
 
 示例 1:
 
 输入: nums = [5,7,7,8,8,10], target = 8
 
 输出: 2
 
 示例 2:
 
 输入: nums = [5,7,7,8,8,10], target = 6
 
 输出: 0
  
 提示：
 
 0 <= nums.length <= 105
 
 -109 <= nums[i] <= 109
 
 nums 是一个非递减数组
 
 -109 <= target <= 109
 
 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/zai-pai-xu-shu-zu-zhong-cha-zhao-shu-zi-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

let nums = [5,7,7,8,8,10]
let tar = 7

/**
 2023-03-04
 */
func search230304(_ nums: [Int], _ target: Int) -> Int {
    guard nums.isEmpty == false else {
        return 0
    }

    // 二分
    var left = 0, right = nums.count - 1, match = false
    
    while left <= right {
        if nums[left] == nums[right], nums[right] == target {
            match = true
            break
        }
        else if nums[right] != target {
            right -= 1
        }
        else {
            match = true
        }
        if nums[left] != target {
            left += 1
        }
        else {
            match = true
        }
    }
    
    return match ? right - left + 1 : 0
}
search230304(nums, tar)


/**
 2023-02-11
 */
func search23211(_ nums: [Int], _ target: Int) -> Int {
    var res = 0
    nums.forEach {
        if $0 == target {
            res += 1
        }
    }
    return res
}
search23211(nums, tar)

// 二分
func search232112(_ nums: [Int], _ target: Int) -> Int {
    // 二分游标
    var findLeft = 0, findRight = nums.count - 1
    // 目标起始位置
    var start: Int?, end: Int?
    // 找到右边界
    while findLeft <= findRight {
        let midx = (findRight + findLeft) / 2
        let midData = nums[midx]
        if midData > target {
            findRight = midx - 1
        }
        else if midData < target {
            findLeft = midx + 1
        }
        else {
            findLeft = midx + 1
        }
    }
    end = findLeft // 最后一个 target 下一个元素下标
    findLeft = 0
    findRight = nums.count - 1
    // 找到左边界
    while findLeft <= findRight {
        let midx = (findRight + findLeft) / 2
        let midData = nums[midx]
        if midData > target {
            findRight = midx - 1
        }
        else if midData < target {
            findLeft = midx + 1
        }
        else {
            findRight = midx - 1
        }
    }
    start = findRight // 第一个 target 上一个元素下标
    
    guard let start = start, let end = end else { return 0 }
    
    return end - start - 1
}
search232112(nums, tar)

func search(_ nums: [Int], _ target: Int) -> Int {
    guard
        let first = nums.firstIndex(of: target),
        let last = nums.lastIndex(of: target)
    else {
        return 0
    }
    return last - first + 1
}

search(nums, tar)

//: [Next](@next)
