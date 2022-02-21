//: [Previous](@previous)

/*:

输入一个整型数组，数组中的一个或连续多个整数组成一个子数组。求所有子数组的和的最大值。

要求时间复杂度为O(n)。

 

示例1:

输入: nums = [-2,1,-3,4,-1,2,1,-5,4]
输出: 6
解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。
 

提示：

1 <= arr.length <= 10^5
-100 <= arr[i] <= 100
注意：本题与主站 53 题相同：https://leetcode-cn.com/problems/maximum-subarray/



来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/lian-xu-zi-shu-zu-de-zui-da-he-lcof
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。


*/

import Foundation

/*:
 解法一： 规律分析
 
 */
func maxSubArray2(_ nums: [Int]) -> Int {
    var currentSum = nums[0]
    var maxSum = nums[0]
    
    for idx in 1..<nums.count {
        if currentSum < 0 { // 当前是下降趋势，丢弃之前的
            currentSum = nums[idx]
        }
        else {
            currentSum += nums[idx]
        }
        maxSum = max(maxSum, currentSum)
    }
    return maxSum
}

/*:
 解法二： 动态规划
 
 
 */

func maxSubArray1(_ nums: [Int]) -> Int {
    var dp: [Int] = Array(repeating: 0, count: nums.count)
    
    for i in 0..<nums.count {
        if i == 0 || (i > 0 && dp[i-1] <= 0) {
            dp[i] = nums[i]
        }
        else {
            dp[i] = dp[i - 1] + nums[i]
        }
    }
    
    return dp.max() ?? nums[0]
}


//let nums = [-1]
//let nums = [-2, 1]
//let nums = [1, 2]
let nums = [-2, -1]
//let nums = [-2,1,-3,4,-1,2,1,-5,4]
maxSubArray1(nums)
maxSubArray2(nums)

//: [Next](@next)
