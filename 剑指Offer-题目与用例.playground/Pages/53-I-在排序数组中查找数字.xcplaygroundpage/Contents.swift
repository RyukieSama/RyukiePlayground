//: [上一题](@previous)

/*:
# 53-I-在排序数组中查找数字

## 题目

统计一个数字在排序数组中出现的次数。

## 用例 1

**输入：** nums = [5,7,7,8,8,10], target = 8

**输出：** 2

## 用例 2

**输入：** nums = [5,7,7,8,8,10], target = 6

**输出：** 0

## 提示

0 <= nums.length <= 105

-109 <= nums[i] <= 109

nums 是一个非递减数组

-109 <= target <= 109

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/zai-pai-xu-shu-zu-zhong-cha-zhao-shu-zi-lcof)
*/

// O(n)
func countOfNum2(target: Int, in nums: [Int]) -> Int {
    guard nums.isEmpty == false else { return 0 }
    
    func findStart() -> Int? {
        for idx in nums.indices {
            if nums[idx] == target {
                return idx
            }
        }
        return nil
    }
    
    func findEnd() -> Int? {
        for idx in nums.indices {
            let i = nums.count - idx - 1
            if nums[i] == target {
                return i
            }
        }
        return nil
    }
    
    let start = findStart(), end = findEnd()
    
    guard let start = start, let end = end else {
        return 0
    }
    return end - start + 1
}

// O(n)
func countOfNum(target: Int, in nums: [Int]) -> Int {
    guard nums.isEmpty == false else { return 0 }
    var startIdx: Int?, endIndex: Int?
    
    for idx in nums.indices {
        let v = nums[idx]
        if v == target {
            if startIdx == nil {
                startIdx = idx
            }
            else {
                endIndex = idx
            }
        }
    }
    
    // 错误，只支持了多个的情况，只出现一次就错了
//    guard let endIndex = endIndex, let startIdx = startIdx else {
//        return 0
//    }
//    
//    return endIndex - startIdx + 1
    
    guard let startIdx = startIdx else {
        return 0
    }
    
    if let endIndex = endIndex {
        return endIndex - startIdx + 1
    }
    return 1
}

//: [下一题](@next)
