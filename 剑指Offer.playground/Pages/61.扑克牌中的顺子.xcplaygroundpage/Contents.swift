//: [Previous](@previous)

import Foundation

/*:
 从若干副扑克牌中随机抽 5 张牌，判断是不是一个顺子，即这5张牌是不是连续的。2～10为数字本身，A为1，J为11，Q为12，K为13，而大、小王为 0 ，可以看成任意数字。A 不能视为 14。

 示例 1:

 输入: [1,2,3,4,5]

 输出: True
  

 示例 2:

 输入: [0,0,1,2,5]

 输出: True

 
 限制：

 数组长度为 5

 数组的数取值为 [0, 13] .

 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/bu-ke-pai-zhong-de-shun-zi-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

var cards = [0,0,1,2,5]
cards = [8,7,11,0,9]

/**
 2023-02-13
 */
func isStraight23213(_ nums: [Int]) -> Bool {
    var nums = nums
    var idx = 0
    var zeroCount = 0
    
    while idx < nums.count {
        let val = nums[idx]
        if val == 0 {
            zeroCount += 1
            nums.remove(at: idx)
        }
        else {
            idx += 1
        }
    }
    
    idx = 0
    
    guard nums.count > 1 else {
        return true
    }
    
    nums = nums.sorted()
    
    while idx < nums.count - 1 {
        let deta = abs(nums[idx] - nums[idx + 1])
        if deta == 1 {
            // 顺
            idx += 1
        }
        else if deta == 0 {
            return false
        }
        else { // 不顺
            // 有 0 可以补
            if zeroCount > 0, deta - 1 <= zeroCount {
                zeroCount -= deta - 1
                idx += 1
            }
            // 没 0 可以补
            else {
                return false
            }
        }
    }
    
    return true
}

isStraight23213(cards)

func isStraight(_ nums: [Int]) -> Bool {
    var zeroCount = 0
    var last: Int?
    
    for i in nums.sorted() {
        if i == 0 {
            zeroCount += 1
        }
        else if let l = last {
            let deta = i - l
            if deta > 0 {
                zeroCount -= (deta - 1)
                last = i
            }
            else {
                return false
            }
        }
        else {
            last = i
        }
        
        if zeroCount < 0 {
            return false
        }
    }
    
    return true
}

isStraight(cards)

//: [Next](@next)
