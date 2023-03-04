//: [Previous](@previous)

import Foundation

/*:
 一个长度为n-1的递增排序数组中的所有数字都是唯一的，并且每个数字都在范围0～n-1之内。在范围0～n-1内的n个数字中有且只有一个数字不在该数组中，请找出这个数字。

 示例 1:

 输入: [0,1,3]
 
 输出: 2
 
 示例 2:

 输入: [0,1,2,3,4,5,6,7,9]
 
 输出: 8

 限制：

 1 <= 数组长度 <= 10000

 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/que-shi-de-shu-zi-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
var nums = [0,1,2,3,4,5,6,7,9]
//nums = [0]
//nums = [1]
//nums = [0, 2]

/**
 2023-03-04
 */
func missingNumber230304(_ nums: [Int]) -> Int {
    // 位运算
    guard nums.isEmpty == false else {
        return 0
    }
    var res = 0
    for i in 1...nums.count {
        res ^= i
    }
    nums.forEach {
        res ^= $0
    }
    return res
}
missingNumber230304(nums)


/**
 2023-02-11
 */
func missingNumber23211(_ nums: [Int]) -> Int {
    /**
     二分
     */
    var left = 0, right = nums.count - 1
    while left <= right {
        let midIdx = (right + left) / 2
        let midData = nums[midIdx]
        
        if nums[midIdx] == midIdx {
            // 相等，缺的在后面
            left = midIdx + 1
        }
        else {// 不相等，只可能缺的在前面
            right = midIdx - 1
        }
    }
    return left
}




func missingNumber(_ nums: [Int]) -> Int {
    var tmp = 0
    
    for i in nums {
        if tmp != i {
            return tmp
        }
        else {
            tmp += 1
        }
    }
    
    return tmp
}

/// 排序数组中的搜索问题，首先想到 二分法 解决。
func missingNumber2(_ nums: [Int]) -> Int {
    var per = 0, aft = nums.count - 1
    
    while per <= aft {
        // 求中间下标
        let m = (per + aft) / 2

        if nums[m] == m {
            per = m + 1
        }
        else {
            aft = m - 1
        }
        
    }
    
    return per
}

missingNumber(nums)
missingNumber2(nums)

//: [Next](@next)
