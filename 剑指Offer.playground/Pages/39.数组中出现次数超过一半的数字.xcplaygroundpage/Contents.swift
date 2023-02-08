//: [Previous](@previous)

import Foundation

/*:
 
 数组中有一个数字出现的次数超过数组长度的一半，请找出这个数字。

 你可以假设数组是非空的，并且给定的数组总是存在多数元素。

 示例 1:

 输入: [1, 2, 3, 2, 2, 2, 5, 4, 2]
 输出: 2

 限制：

 1 <= 数组长度 <= 50000

 注意：本题与主站 169 题相同：https://leetcode-cn.com/problems/majority-element/

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/shu-zu-zhong-chu-xian-ci-shu-chao-guo-yi-ban-de-shu-zi-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */

let numbers: [Int] = [1, 2, 3, 2, 2, 2, 5, 4, 2]

/**
 2023-02-08
 */

func majorityElement2308(_ nums: [Int]) -> Int {
    /**
     求众数
     
     投票法
     
     对于目标数字而言，其他元素具体是什么并不重要。
     目标数字记为 1票 其他元素记为 -1票
     到最后一定是 目标元素胜出
     */
    var winner = 0
    var tickets = 0
    
    for n in nums {
        if tickets == 0 {
            winner = n
        }
        if winner == n {
            tickets += 1
        }
        else {
            tickets -= 1
        }
    }
    
    return winner
}

majorityElement2308(numbers)

/// 哈希表统计法
func majorityElementHash(_ nums: [Int]) -> Int {
    var temp: [Int : Int] = [:]
    
    for item in nums {
        if let count = temp[item] {
            if count == (nums.count / 2) {
                return item
            }
            temp[item] = count + 1
        }
        else {
            temp[item] = 1
        }
    }
    
    return nums[0]
}

/// 数组排序法： 将数组 nums 排序，数组中点的元素 一定为众数。
func majorityElementArray(_ nums: [Int]) -> Int {
    nums.sorted()[nums.count / 2]
}

/// 摩尔投票法： 核心理念为 票数正负抵消 。此方法时间和空间复杂度分别为 O(N) O(1) 为本题的最佳解法。
func majorityElementMo(_ nums: [Int]) -> Int {
    var score = 0
    var x = 0
    for n in nums {
        if score == 0 {
            x = n
        }
        score += (x == n ? 1 : -1)
    }
    return x
}

majorityElementHash(numbers)
majorityElementArray(numbers)
majorityElementMo(numbers)




//: [Next](@next)
