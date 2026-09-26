//: [上一题](@previous)

/*:
# 53-II-0～n-1中缺失的数字

## 题目

一个长度为n-1的递增排序数组中的所有数字都是唯一的，并且每个数字都在范围0～n-1之内。在范围0～n-1内的n个数字中有且只有一个数字不在该数组中，请找出这个数字。

## 用例 1

**输入：** [0,1,3]

**输出：** 2

## 用例 2

**输入：** [0,1,2,3,4,5,6,7,9]

**输出：** 8

## 约束

1 <= 数组长度 <= 10000

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/que-shi-de-shu-zi-lcof)
*/

// O(logn)
func findLostNum(_ nums: [Int]) -> Int {
    var left = 0, right = nums.count - 1
    
//    while left < right {
    while left <= right {
        let mid = left + (right - left) / 2
        if nums[mid] == mid {
//            left = mid// 可能死循环
            left = mid + 1
        }
        else {
//            right = mid
            right = mid - 1
        }
    }
    
    return left
}

// O(n) 暴力遍历
func find(_ nums: [Int]) -> Int {
    for idx in nums.indices {
        if idx != nums[idx] {
            return idx
        }
    }
//    return -1
    return nums.count // 都没缺应该这样
}

/*:
## 解法解析

数组原本应该包含 `0...n` 中的所有数字，但现在少了一个数字，并且数组仍然保持递增、有序且没有重复。

正常情况下，下标和数字满足：

`nums[index] == index`

从缺失数字的位置开始，后面的数字会整体向左移动一个位置，因此会出现：

`nums[index] != index`

### `find`：线性查找

`find` 从左到右检查每个位置：

- 第一个 `nums[index] != index` 的位置，就是缺失数字；
- 如果整个数组都满足 `nums[index] == index`，说明缺失数字在数组末尾，应返回 `nums.count`，不能返回 `-1`。

例如：

```text
[0, 1, 3] → 第一个错位位置是 2
[0, 1, 2] → 没有错位，缺失数字是 nums.count，也就是 3
[1, 2, 3] → 第一个位置就错位，缺失数字是 0
```

线性解法的时间复杂度是 `O(n)`，额外空间复杂度是 `O(1)`。

### `findLostNum`：二分查找

因为数组有序，可以利用错位位置的单调性进行二分查找。当前实现使用闭区间 `[left, right]`：

- 如果 `nums[mid] == mid`，说明 `mid` 位置正常，缺失数字在右侧，令 `left = mid + 1`；
- 如果 `nums[mid] != mid`，说明 `mid` 已经发生错位，缺失数字在 `mid` 或左侧，令 `right = mid - 1`。

循环结束时，`left` 指向第一个错位位置。如果所有位置都正常，`left` 会移动到 `nums.count`，自然处理缺失数字在末尾的情况。

二分解法的时间复杂度是 `O(log n)`，额外空间复杂度是 `O(1)`。
*/
//: [下一题](@next)
