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

// 二分法

//func half(_ nums: [Int]) -> Int? { // 错误
//    switch nums.count {
//    case 0, 1:
//        return nums.first
//    case 2:
//        return nums[0] > nums[1] ? nums[1] : nums[0]
//    default:
//        let left = 0, mid = Int(floor(Double(nums.count) / 2.0)), right = nums.count - 1
//        
//        if nums[left] <= nums[mid] {
//            return half(Array(nums[mid...right]))
//        }
//        return half(Array(nums[left...mid]))
//    }
//}

func half(_ nums: [Int]) -> Int? {
    guard nums.isEmpty == false else {
        return nil
    }
    
    var left = 0, right = nums.count - 1
    
    while left < right {
//        let mid = Int(floor(Double(nums.count) / 2.0))
        let mid = left + (right - left) / 2
        
        if nums[mid] < nums[right] {
            // 在mid或更左
            right = mid
        }
        else if nums[mid] > nums[right] {
            left = mid + 1
        }
        else {
            right -= 1
        }
    }
    
    return nums[left]
}

/*:
## 二分查找版：总结

### 区间定义

`left...right` 表示当前仍有可能包含最小值的闭区间。
循环条件是 `left < right`，当两个指针相遇时，`left` 就是最小值下标。

中点使用：

```swift
let mid = left + (right - left) / 2
```

这样中点始终位于当前区间内，也避免了对整个数组长度重复计算。

### 三种情况

#### 1. `nums[mid] < nums[right]`

中点右侧直到 `right` 是递增的，且 `nums[mid]` 小于右边界，
说明最小值不可能在 `mid` 的右侧，保留 `mid`：

```swift
right = mid
```

#### 2. `nums[mid] > nums[right]`

中点大于右边界，说明旋转断点位于 `mid` 的右侧，
因此 `mid` 本身不可能是最小值，需要排除它：

```swift
left = mid + 1
```

这里必须使用 `mid + 1`。如果写成 `left = mid`，
当区间只剩两个元素且 `mid == left` 时，区间不会缩小，可能死循环。

#### 3. `nums[mid] == nums[right]`

重复元素使我们无法判断最小值位于 `mid` 的左侧还是右侧。
但可以安全排除一个与中点相等的右端元素：

```swift
right -= 1
```

这不会丢失唯一的最小值位置，因为即使 `right` 是最小值，
`nums[mid]` 也与它相等，保留 `mid` 仍能得到相同的最小值。

### 正确性依据

每次循环都保持这个不变量：

> 最小值一定仍然位于当前的 `left...right` 区间内。

- 第一种情况保留 `mid` 及其左侧。
- 第二种情况排除 `mid` 及其左侧。
- 第三种情况只排除一个确定不会影响结果的重复右端元素。

区间不断缩小，直到 `left == right`，此时该位置就是最小值。

### 示例

```
nums = [3, 4, 5, 1, 2]

left = 0, right = 4, mid = 2
nums[mid] = 5 > nums[right] = 2
left = 3

left = 3, right = 4, mid = 3
nums[mid] = 1 < nums[right] = 2
right = 3

left == right == 3，返回 nums[3] = 1
```

### 复杂度

- 平均时间复杂度：`O(log n)`
- 最坏时间复杂度：`O(n)`
- 空间复杂度：`O(1)`

最坏情况出现在大量重复元素时，例如 `[1,1,1,1,1]`，
每次只能执行 `right -= 1`，无法排除一半区间。

### 与前面解法的对比

- `doublePSol`：双端线性扫描，时间复杂度 `O(n)`。
- `half`：二分查找，平均情况下更快，且不复制数组。
- 两个实现都能处理重复元素；二分版本利用了更多的有序信息。
*/

//: [下一题](@next)
