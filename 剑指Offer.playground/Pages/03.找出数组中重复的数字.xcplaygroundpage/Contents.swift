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
 
 
 链接：https://leetcode-cn.com/problems/shu-zu-zhong-zhong-fu-de-shu-zi-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


import Foundation

var nums: [Int] =  [4, 3, 1, 0, 2, 5, 3]

// 二分法 时间O(log2N) 空间 O(N)
func findRepeatNumberA(_ nums: [Int]) -> Int {
    var dic: [Int : Int] = [:]
    var left = 0, right = nums.count - 1
    
    while left <= right {
        if let _ = dic[nums[left]] {
            return nums[left]
        }
        else {
            dic[nums[left]] = 1
        }
        
        if let _ = dic[nums[right]] {
            return nums[right]
        }
        else {
            dic[nums[right]] = 1
        }
        
        left += 1
        right -= 1
    }
    
    return 0
}

findRepeatNumberA(nums)

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
    var temp = nums, index = 0
    
    while index < temp.count {
        let currentValue = temp[index]
        
        if currentValue == index {
            index += 1
            continue
        }
        
        if currentValue == temp[currentValue] {
            return currentValue
        }
        
        temp.swapAt(index, currentValue)
    }
    
    return -1
}

let result = findSame(in: [3, 4, 2, 0, 0, 1])

// MARK: - 2022-11-08
var test = [2, 3, 1, 0, 2, 5, 3]

/// 动态规划 时间 空间 N
class Solution1 {
    func findRepeatNumber(_ nums: [Int]) -> Int {
        var dp: [Int : Int] = [:]
        
        for num in nums {
            if let _ = dp[num] {
                return num
            }
            else {
                dp[num] = 1
            }
        }
        
        return nums[0]
    }
}

Solution1().findRepeatNumber(test)

/// 双指针 空间 n 时间 log2n
class Solution2 {
    func findRepeatNumber(_ nums: [Int]) -> Int {
        var dp: [Int : Int] = [:]
        var left = 0, right = nums.count - 1
        
        while left < right {
            let leftNum = nums[left]
            let rightNum = nums[right]
            
            if let _ = dp[leftNum] {
                return leftNum
            }
            
            dp[leftNum] = 1
            
            if let _ = dp[rightNum] {
                return rightNum
            }
            
            dp[rightNum] = 1
            
            left += 1
            right -= 1
        }
        
        return nums[0]
    }
}

Solution2().findRepeatNumber(test)

/// 一个萝卜一个坑
class Solution3 {
    func findRepeatNumber(_ nums: [Int]) -> Int {
        var nums = nums, idx = 0
        
        while idx < nums.count {
            let num = nums[idx]
            
            if num == idx { // 下标和所在的值相同，即占坑了，就检查下一位
                idx += 1
                continue // 占坑
            }
            else if num == nums[num] { // 当前值对应的下标内的元素，和当前的值相同，
                return num // 被占坑了
            }
            
            nums.swapAt(num, idx)
//            idx += 1
        }
        
        return nums[0]
    }
}
Solution3().findRepeatNumber(test)

//: [Next](@next)
