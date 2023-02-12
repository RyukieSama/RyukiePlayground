//: [Previous](@previous)

import Foundation

/*:
 输入一个递增排序的数组和一个数字s，在数组中查找两个数，使得它们的和正好是s。如果有多对数字的和等于s，则输出任意一对即可。

 示例 1：

 输入：nums = [2,7,11,15], target = 9
 
 输出：[2,7] 或者 [7,2]
 
 示例 2：

 输入：nums = [10,26,30,31,47,60], target = 40
 
 输出：[10,30] 或者 [30,10]
  

 限制：

 1 <= nums.length <= 10^5
 
 1 <= nums[i] <= 10^6

 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/he-wei-sde-liang-ge-shu-zi-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

let nums = [10,26,30,31,47,60], target = 40

/**
 2023-02-12
 */
func twoSum23212(_ nums: [Int], _ target: Int) -> [Int] {
    var left = 0, right = nums.count - 1
    while left < right {
        let leftVal = nums[left], rightVal = nums[right]
        if leftVal + rightVal > target {
            right -= 1
        }
        else if leftVal + rightVal < target {
            left += 1
        }
        else {
            return [leftVal, rightVal]
        }
    }
    return []
}


// 超时
//func twoSum23212(_ nums: [Int], _ target: Int) -> [Int] {
//    guard nums.count >= 1 else {
//        return []
//    }
//    var slow = 0, fast = 1
//
//    while slow < fast, fast < nums.count {
//        let val = nums[slow], fastVal = nums[fast], deta = target - val
//
//        guard val < target else {
//            return []
//        }
//
//        if fastVal == deta {
//            return [nums[slow], nums[fast]]
//        }
//        else if (fastVal > deta || fast == nums.count - 1) {
//            /**
//             fastVal 大于差值，下一轮
//             fast 到头了，下一轮
//             */
//            slow += 1
//            fast = slow + 1
//        }
//        else {
//            fast += 1
//        }
//    }
//
//    return []
//}
//
//twoSum23212(nums, target)



/*:
 需要的是一对数字
 那么他们可以互为 key - value
 
 O(N) O(logN)
 */
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var temp: [Int : Int] = [:]
    for num in nums {
        guard target >= num else { break }
        if let other = temp[num] {
            return [num, other]
        }
        temp[target - num] = num
    }
    return []
}

/*:
 双指针 O(N) O(1)
 */
func twoSum2(_ nums: [Int], _ target: Int) -> [Int] {
    var l = 0, r = nums.count - 1
    
    while l < r {
        let a = nums[l], b = nums[r]
        if a + b > target {
            r -= 1
        }
        else if a + b < target {
            l += 1
        }
        else {
            return [a, b]
        }
    }
    
    return []
}

twoSum(nums, target)
twoSum2(nums, target)

//: [Next](@next)
