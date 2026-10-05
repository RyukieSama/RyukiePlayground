//: [上一题](@previous)

/*:
# 57-和为s的两个数字

## 题目

输入一个递增排序的数组和一个数字s，在数组中查找两个数，使得它们的和正好是s。如果有多对数字的和等于s，则输出任意一对即可。

## 用例 1

**输入：** nums = [2,7,11,15], target = 9

**输出：** [2,7] 或者 [7,2]

## 用例 2

**输入：** nums = [10,26,30,31,47,60], target = 40

**输出：** [10,30] 或者 [30,10]

## 约束

1 <= nums.length <= 10^5

1 <= nums[i] <= 10^6

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/he-wei-sde-liang-ge-shu-zi-lcof)
*/
import Foundation

func find20261005(_ nums:[Int], _ sum: Int) -> [Int] {
    guard nums.count >= 2 else {
        return []
    }
    // 元素都是正数，简单一些
    var left = 0, right = nums.count - 1
    
    while left < right {
        let LV = nums[left], RV = nums[right]
        let temp = LV + RV
        
        if temp > sum {
            right -= 1
        }
        else if temp < sum {
            left += 1
        }
        else {
            return [LV, RV]
        }
    }
    return []
}

func find(_ nums:[Int], _ sum: Int) -> [Int] {
    guard nums.count > 1 else {
        return []
    }
    // 双指针
    var left = 0, right = nums.count - 1
    
    while left < right {
        let leftV = nums[left], rightV = nums[right]
        let s = leftV + rightV
        /**
         为什么可以这样移动：
         - 如果 nums[left] + nums[right] < sum，当前最小值太小，right 再怎么移动只会让和更小，所以只能增大 left；
         - 如果和大于 sum，当前最大值太大，只能减小 right。
         */
        if s < sum {
            left += 1
        }
        else if s > sum {
            right -= 1
        }
        else {
            return [leftV, rightV]            
        }
    }
    
    return []
}


//: [下一题](@next)
