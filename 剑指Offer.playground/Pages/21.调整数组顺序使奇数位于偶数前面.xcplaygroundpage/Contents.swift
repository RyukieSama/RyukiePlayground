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

let nums = [1,2,3,4]

exchange(nums)

exchange1(nums)
//: [Next](@next)
