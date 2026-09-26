//: [上一题](@previous)

/*:
# 51-数组中的逆序对

## 题目

在数组中的两个数字，如果前面一个数字大于后面的数字，则这两个数字组成一个逆序对。输入一个数组，求出这个数组中的逆序对的总数。

## 用例 1

**输入：** [7,5,6,4]

**输出：** 5

## 约束

0 <= 数组长度 <= 50000

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/shu-zu-zhong-de-ni-xu-dui-lcof)
*/

// 这道题应该使用归并排序统计逆序对，时间复杂度为 O(n log n)。
func coupeIn2(_ nums: [Int]) -> Int {
    guard nums.count >= 2 else {
        return 0
    }
    // 看不懂
    var values = nums
    var temp = Array(repeating: 0, count: nums.count)
    
    func mergeSort(_ left: Int, _ right: Int) -> Int {
        guard left < right else {
            return 0
        }
        
        let mid = left + (right - left) / 2
        var count = mergeSort(left, mid)
        count += mergeSort(mid + 1, right)
        
        var i = left
        var j = mid + 1
        var k = left
        
        while i <= mid && j <= right {
            if values[i] <= values[j] {
                temp[k] = values[i]
                i += 1
            }
            else {
                temp[k] = values[j]
                count += mid - i + 1
                j += 1
            }
            k += 1
        }
        
        while i <= mid {
            temp[k] = values[i]
            i += 1
            k += 1
        }
        
        while j <= right {
            temp[k] = values[j]
            j += 1
            k += 1
        }
        
        for index in left...right {
            values[index] = temp[index]
        }
        
        return count
    }
    
    return mergeSort(0, values.count - 1)
}

// 时间负责度太高
func coupeIn(_ nums: [Int]) -> Int {
    guard nums.count >= 2 else {
        return 0
    }
    var res = 0
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            if nums[i] > nums[j] {
                res += 1
            }
        }
    }
    return res
}

/*:
## 题目解析

如果数组中前面的数字大于后面的数字，这两个数字就构成一个逆序对。例如：

```text
[7, 5, 6, 4]
```

逆序对是 `(7,5)`、`(7,6)`、`(7,4)`、`(5,4)`、`(6,4)`，总数为 `5`。

### 当前暴力解法的问题

逆序对的判断条件应该是：

```swift
nums[i] > nums[j]
```

当前代码使用了 `<`，统计成了正序对。

即使把条件改成 `>`，双重循环的时间复杂度仍然是 `O(n²)`。题目允许数组长度达到 `50000`，这种方法会超时。

### 归并排序统计逆序对

归并排序会把数组分成左右两个有序部分，再合并它们。假设左半部分和右半部分都已经有序：

- 如果左边元素 `values[i] <= values[j]`，它不是当前右边元素产生的逆序对。
- 如果 `values[i] > values[j]`，由于左半部分已经有序，那么从 `i` 到 `mid` 的所有元素都大于 `values[j]`。

因此一次可以增加：

```swift
mid - i + 1
```

这就是归并过程中高效统计逆序对的关键。

### 合并过程

合并两个有序区间时：

1. 比较左右区间当前元素。
2. 取较小元素放入临时数组。
3. 如果右侧元素更小，统计它与左侧剩余元素形成的全部逆序对。
4. 合并完成后，将临时数组复制回原数组。

归并排序不仅完成排序，还在排序过程中完成了逆序对统计。

### 复杂度

- 时间复杂度：`O(n log n)`。
- 额外空间复杂度：`O(n)`，用于临时数组和递归过程。

数组为空、只有一个元素或所有元素有序时，逆序对数量都是 `0`。
*/

//: [下一题](@next)
