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

/**
 O(logn) 二分
 
 注意如果二分后还去遍历就不是 logn 而是 N
 二分一定不是遍历的
 
 */
func countOfNum3(_ target: Int, in nums: [Int]) -> Int {
    // 找到第一个 >= target 的位置
    func lowerBound(_ value: Int) -> Int {
        var left = 0
        var right = nums.count
        
        while left < right {
            let mid = left + (right - left) / 2
            
            if nums[mid] < value {
                left = mid + 1
            }
            else {
                right = mid
            }
        }
        
        return left
    }
    
    // 找到第一个 > target 的位置
    func upperBound(_ value: Int) -> Int {
        var left = 0
        var right = nums.count
        
        while left < right {
            let mid = left + (right - left) / 2
            
            if nums[mid] <= value {
                left = mid + 1
            }
            else {
                right = mid
            }
        }
        
        return left
    }
    
    let first = lowerBound(target)
    let afterLast = upperBound(target)
    
    return afterLast - first
}

/**
 错误的二分
 
 右侧递归没有缩小范围
 找到中间值后，左右扫描是 O(n)
 递归切片会复制数组
 */
//func countOfNum3(_ target: Int, in nums: [Int]) -> Int {
//    guard nums.isEmpty == false else { return 0 }
//    // 非递减，就是递增咯
//    var centerIdx = nums.count / 2
//    var centerVal = nums[centerIdx]
//    
//    if centerVal == target {
//        // 首尾在两侧
//        var st = centerIdx, ed = centerIdx
//        
//        while st - 1 >= 0 {
//            st -= 1
//            if nums[st] != target {
//                st += 1
//                break
//            }
//        }
//        
//        while ed + 1 < nums.count {
//            ed += 1
//            if nums[ed] != target {
//                ed -= 1
//                break
//            }
//        }
//        return ed - st + 1
//    }
//    else if centerVal > target {
//        // 在左侧可能
//        return countOfNum3(target, in: Array(nums[0..<centerIdx]))
//    }
//    else if centerVal < target {
//        // 在右侧可能
//        return countOfNum3(target, in: Array(nums[centerIdx..<nums.count]))
//    }
//    
//    return 0
//}

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

/*:
## 二分边界解析

统计有序数组中目标值的出现次数，可以寻找两个边界：

- `lowerBound(target)`：第一个大于等于 `target` 的位置；
- `upperBound(target)`：第一个大于 `target` 的位置。

目标值的出现次数就是：

`upperBound(target) - lowerBound(target)`。

例如数组 ` [5, 7, 7, 8, 8, 10] ` 中，目标值 `8` 的边界是：

- 第一个 `>= 8` 的位置为 `3`；
- 第一个 `> 8` 的位置为 `5`；
- 出现次数为 `5 - 3 = 2`。

### 为什么 `lowerBound` 使用 `>=`

`lowerBound` 要找的是第一个目标值，而不是任意一个目标值。即使 `nums[mid] == target`，`mid` 左侧仍然可能存在相同元素，所以不能直接返回，而应该继续收缩右边界：

`nums[mid] < target` 时，左边界移动到 `mid + 1`；否则令右边界为 `mid`。

这样最终留下的就是第一个大于等于目标值的位置。

例如：

`[1, 2, 2, 2, 3]`

即使中间位置已经遇到 `2`，还要继续向左查找，最终得到第一个 `2` 的下标 `1`。

### 为什么 `upperBound` 使用 `>`

`upperBound` 要找第一个严格大于目标值的位置。遇到 `nums[mid] == target` 时，目标值仍可能在右侧继续出现，所以需要把左边界移动到 `mid + 1`；只有 `nums[mid] > target` 时，才收缩右边界。

如果目标值不存在，两个边界会落在同一个插入位置，相减后自然得到 `0`。

### 复杂度

- 每次边界查找的时间复杂度是 `O(log n)`；
- 两次查找仍然是 `O(log n)`；
- 额外空间复杂度是 `O(1)`。
*/
//: [下一题](@next)
