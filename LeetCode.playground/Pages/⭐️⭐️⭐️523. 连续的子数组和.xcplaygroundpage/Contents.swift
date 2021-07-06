//: [Previous](@previous)

import Foundation

/*:
 给你一个整数数组 nums 和一个整数 k ，编写一个函数来判断该数组是否含有同时满足下述条件的连续子数组：
 
 子数组大小 至少为 2 ，且
 子数组元素总和为 k 的倍数。
 如果存在，返回 true ；否则，返回 false 。
 
 如果存在一个整数 n ，令整数 x 符合 x = n * k ，则称 x 是 k 的一个倍数。
 
 示例 1：
 
 输入：nums = [23,2,4,6,7], k = 6
 输出：true
 解释：[2,4] 是一个大小为 2 的子数组，并且和为 6 。
 示例 2：
 
 输入：nums = [23,2,6,4,7], k = 6
 输出：true
 解释：[23, 2, 6, 4, 7] 是大小为 5 的子数组，并且和为 42 。
 42 是 6 的倍数，因为 42 = 7 * 6 且 7 是一个整数。
 示例 3：
 
 输入：nums = [23,2,6,4,7], k = 13
 输出：false
  
 
 提示：
 
 1 <= nums.length <= 10^5
 0 <= nums[i] <= 10^9
 0 <= sum(nums[i]) <= 2^31 - 1
 1 <= k <= 2^31 - 1
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/continuous-subarray-sum
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

//let nums = [5,0,0,0,0], k = 3
//let nums = [23,2,6,4,7], k = 13
let nums = [23,2,4,6,6], k = 7

func checkSubarraySum(_ nums: [Int], _ k: Int) -> Bool {
    
    return false
}

// MARK: - 同余性质
func checkSubarraySum4(_ nums: [Int], _ k: Int) -> Bool {
    if nums.count < 2 {
        return false
    }
    var moMap: [Int : Int] = [:]
    moMap[0] = -1 // 这样才能正确的吧从0开始复合条件的找出来
    var sum: Int = 0
    for (index, n) in nums.enumerated() {
        sum += n
        let mo = sum % k
        if moMap.keys.contains(mo) {
            if let sameMoIndex = moMap[mo], index - sameMoIndex > 1 { // 长度至少为2
                return true
            }
        }
        else {
            moMap[mo] = index
        }
    }
    return false
}

checkSubarraySum4(nums, k)

//: [Next](@next)
