//: [上一题](@previous)

/*:
# 11-旋转数组的最小数字

## 题目

把一个数组最开始的若干个元素搬到数组的末尾，我们称之为数组的旋转。输入一个递增排序的数组的一个旋转，输出旋转数组的最小元素。例如，数组 [3,4,5,1,2] 为 [1,2,3,4,5] 的一个旋转，该数组的最小值为1。

## 用例 1

**输入：** [3,4,5,1,2]
**输出：** 1
## 用例 2

**输入：** [2,2,2,0,1]
**输出：** 0
注意：本题与主站 154 题相同：https://leetcode-cn.com/problems/find-minimum-in-rotated-sorted-array-ii/

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/find-minimum-in-rotated-sorted-array-ii/)
*/

import Foundation

let nums = [3,4,5,1,2]

func sol(_ nums: [Int]) -> Int? {
    if nums.count < 2 {
        return nums.first
    }
    // 旋转数组有个一断崖处 最大值和最小值
    var p1 = 0, p2 = 1
    
    while p1 < p2, p2 < nums.count {
        if nums[p1] > nums[p2] {
            return nums[p2]
        }
        else {
            p1 += 1
            p2 += 1
        }
    }
    
    return nums.first
}

sol(nums)

/*:
## 旋转数组最小值：总结

### 核心思路

原数组是递增或不降序数组，旋转后通常会在旋转点出现一次下降：

```
[3, 4, 5, 1, 2]
       ↑
```

当发现前一个元素大于后一个元素时，后一个元素就是旋转后的最小值：

```swift
if nums[p1] > nums[p2] {
    return nums[p2]
}
```

如果遍历过程中始终没有出现下降，说明数组没有旋转，最小值就是第一个元素。

### 当前实现为什么正确

- 从左到右检查每一对相邻元素。
- 对于旋转数组，最小值前面一定存在一个比它大的元素。
- 发现下降时，下降位置右侧的元素就是最小值。
- 对于没有旋转的数组，所有相邻元素都满足递增关系，最后返回首元素。

重复元素不会影响这个判断。例如：

```
[2, 2, 2, 0, 1]
      ↑
```

仍然可以通过 `2 > 0` 找到最小值 `0`。

### 边界情况

- 空数组：返回 `nil`。
- 单元素数组：直接返回该元素。
- 没有旋转：返回第一个元素。
- 完全相同的数组，例如 `[2, 2, 2]`：不会找到下降，返回 `2`。
- 旋转点位于最后一个元素之前时，会在相邻元素比较中被发现。

### 复杂度

当前实现逐个检查相邻元素：

- 时间复杂度：`O(n)`
- 空间复杂度：`O(1)`

### 关于二分查找

这道题的重点通常是使用二分查找。没有重复数字时，可以根据中间值和右边界的关系，
每次排除一半区间，时间复杂度为 `O(log n)`。

但本题允许重复数字。当 `nums[mid] == nums[right]` 时，无法判断最小值位于哪一侧，
通常只能执行 `right -= 1`，因此最坏情况会退化为 `O(n)`。

当前线性扫描版本虽然不是二分法，但逻辑直观，并且在最坏情况下已经达到允许的线性复杂度。

### 小细节

- `p1 < p2` 始终成立，因为 `p2` 一直等于 `p1 + 1`，这个判断可以省略。
- `p1`、`p2` 实际表示相邻下标，命名为 `previousIndex`、`currentIndex` 可读性更好。
- 函数返回 `Int?` 是为了兼容空数组；如果题目保证数组非空，可以返回普通的 `Int`。
*/


// 双指针，并非二分
func doublePSol(_ nums: [Int]) -> Int? {
    if nums.count < 2 {
        return nums.first
    }
    var left = 0, right = nums.count - 1
    
    while left < right {
        if nums[left] > nums[left + 1] {
            return nums[left + 1]
        }
        
        if nums[right] < nums[right - 1] {
            return nums[right]
        }
        
        left += 1
        right -= 1
    }
    
    return nums.first
}

//: [下一题](@next)
