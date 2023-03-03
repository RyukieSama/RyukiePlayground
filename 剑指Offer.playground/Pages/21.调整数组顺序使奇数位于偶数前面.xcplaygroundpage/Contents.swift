//: [Previous](@previous)

import Foundation

/*:
 输入一个整数数组，实现一个函数来调整该数组中数字的顺序，使得所有奇数位于数组的前半部分，所有偶数位于数组的后半部分。
 
 示例：
 
 输入：nums = [1,2,3,4]
 输出：[1,3,2,4]
 注：[3,1,2,4] 也是正确的答案之一。
 
 提示：
 
 0 <= nums.length <= 50000
 1 <= nums[i] <= 10000
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/diao-zheng-shu-zu-shun-xu-shi-qi-shu-wei-yu-ou-shu-qian-mian-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

let nums = [1,2,3,4]

/**
 2023-03-03
 */
func exchange230303(_ nums: [Int]) -> [Int] {
    var res: [Int] = []
    
    nums.forEach {
        if $0 & 1 == 0 {
            res.append($0)
        }
        else {
            res.insert($0, at: 0)
        }
    }
    
    return res
}
exchange230303(nums)

// 原地
func exchange230303A(_ nums: [Int]) -> [Int] {
    var nums = nums, left = 0, right = nums.count - 1
    
    while left < right {
        // 从左开始找第一个偶数
        while left < right, nums[left] & 1 != 0 {
            left += 1
        }
        
        // 从右开始找第一个奇数
        while left < right, nums[right] & 1 == 0 {
            right -= 1
        }
        
        nums.swapAt(left, right)
        left += 1
        right -= 1
    }
    
    return nums
}
exchange230303A(nums)

/**
 2023-0207
 */
func exchange2327(_ nums: [Int]) -> [Int] {
    if nums.count < 2 { return nums }
    var res = nums
    var left = 0, right = nums.count - 1
    
    while left < right {
        if res[left] % 2 == 0 {
            if res[right] % 2 == 0 {
                right -= 1
            }
            else {
                res.swapAt(left, right)
            }
        }
        else {
            left += 1
        }
    }
    
    return res
}
exchange2327(nums)

/**
 2023-02-06
 
 双指针
 */
func exchange2326(_ nums: [Int]) -> [Int] {
    var arr = nums
    var left = 0, right = 1
    while left < right, right < arr.count {
        if arr[left] % 2 == 0 {
            if arr[right] % 2 == 1 {
                arr.swapAt(left, right)
                left += 1
                right += 1
            }
            else {
                right += 1
            }
        }
        else {// left 为奇数就不用管，继续往后找，以前写的，五十这种情况也可以，就是翻转的没必要
            left += 1
            right += 1
        }
    }
    return arr
}

exchange2326(nums)

/**
 最容易想到的
 */
func exchange(_ nums: [Int]) -> [Int] {
    var temp: [Int] = []
    nums.forEach {
        if $0 & 1 == 1 {
            temp.insert($0, at: 0)
        }
        else {
            temp.append($0)
        }
    }
    return temp
}

/**
 差速双指针
 */
func exchange1(_ nums: [Int]) -> [Int] {
    var fastP: Int = 0
    var slowP: Int = 0
    var temp = nums
    
    while fastP < nums.count {
        if temp[fastP] & 1 == 1 {
            temp.swapAt(fastP, slowP)
            slowP += 1
        }
        fastP += 1
    }
    
    return temp
}

exchange(nums)

exchange1(nums)
//: [Next](@next)
