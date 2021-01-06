//: [Previous](@previous)

/*:
 找出数组中重复的数字。
 
 
 在一个长度为 n 的数组 nums 里的所有数字都在 0～n-1 的范围内。数组中某些数字是重复的，但不知道有几个数字重复了，也不知道每个数字重复了几次。请找出数组中任意一个重复的数字。
 
 示例 1：
 
 输入：
 [2, 3, 1, 0, 2, 5, 3]
 输出：2 或 3
  
 
 限制：
 
 2 <= n <= 100000
 
 通过次数188,858提交次数280,286
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/shu-zu-zhong-zhong-fu-de-shu-zi-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


import Foundation

var nums: [Int] =  [2, 3, 1, 0, 2, 5, 3]

// MARK: - 1. 超时了
/// 时间复杂度O(n) 空间O(n)
//func findSame(in nums: [Int]) -> Int {
//    var result: [Int] = []
//    for item in nums {
//        if result.contains(item) == true {
//            return item
//        }
//        else {
//            result.append(item)
//        }
//    }
//    return -1
//}

/// 同上面的，上面的在LeetCode就超时了
//func findSame(in nums: [Int]) -> Int {
//    /**
//     1:一个集合不允许出现两个相同的元素
//     2:集合中的元素是无序的
//     3:并不是所有的类型对象都能作为集合的元素，不过swift的基本类型都可以
//     */
//    var bag: Set<Int> = []
//    for num in nums {
//        if !bag.insert(num).inserted {
//            return num
//        }
//    }
//    return -1
//}

// MARK: - 先排序，再遍历 时间n 空间 1
//func findSame(in nums: [Int]) -> Int {
//    let temp = nums.sorted(by: <)
//    var last: Int = -1
//    for item in temp {
//        if last == item {
//            return item
//        }
//        else {
//            last = item
//        }
//    }
//    return last
//}

// MARK: - 这里限定了长度和范围，可以一个萝卜一个坑，不会越界 每个数值对应的下标都可以有个对应的，如果发现里面有了一样的就试重复的了 O(n) O(1)
func findSame(in nums: [Int]) -> Int {
    var temp = nums
    for (index, item) in temp.enumerated() {
        while item != index {
            // 如果相同就说明一样
            if item == temp[item] {
                return item
            }
            
            // 原地交换
            let tp = item
            temp[index] = temp[tp]
            temp[tp] = tp
        }
    }
    return -1
}

let result = findSame(in: nums)

//: [Next](@next)
