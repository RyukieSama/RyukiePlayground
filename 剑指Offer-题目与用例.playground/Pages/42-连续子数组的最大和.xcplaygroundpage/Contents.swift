//: [上一题](@previous)

/*:
# 42-连续子数组的最大和

## 题目

输入一个整型数组，数组中的一个或连续多个整数组成一个子数组。求所有子数组的和的最大值。

要求时间复杂度为O(n)。

## 用例 1

**输入：** nums = [-2,1,-3,4,-1,2,1,-5,4]
**输出：** 6
解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。

## 提示

1 <= arr.length <= 10^5
-100 <= arr[i] <= 100
注意：本题与主站 53 题相同：https://leetcode-cn.com/problems/maximum-subarray/

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/maximum-subarray/)
*/

func maxSumOfSubArray2(_ nums: [Int]) -> Int {
    guard let first = nums.first else { return 0 }
    var currentSum = first, result = first
    
    for n in nums.dropLast() {
        currentSum = max(n, currentSum + n)
        result = max(currentSum, result)
    }
    
    return result
}


func maxSumOfSubArray(_ nums: [Int]) -> Int {
    guard let first = nums.first else {
        return 0
    }
    
    var current = first
    var best = first
    
    for num in nums.dropFirst() {
        current = max(num, current + num)
        best = max(best, current)
    }
    
    return best
}

/*:
## 题目解析

这道题要求找到和最大的连续子数组，并且时间复杂度必须为 `O(n)`。当前解法使用动态规划，也叫 **Kadane 算法**。

### 状态定义

`current` 表示以当前元素结尾的连续子数组的最大和。

遍历到新元素 `num` 时，有两种选择：

1. 丢弃之前的子数组，从 `num` 重新开始。
2. 把 `num` 接到之前的连续子数组后面，得到 `current + num`。

因此状态转移为：

```swift
current = max(num, current + num)
```

`best` 保存遍历过程中出现过的最大 `current`：

```swift
best = max(best, current)
```

### 为什么可以丢弃负数前缀

如果之前的连续和小于 `0`，它再与后面的数字相加只会让结果变小。因此当当前元素单独作为起点更大时，就应该舍弃之前的前缀。

例如：

```text
之前的和 = -2
当前元素 = 4

接在后面：-2 + 4 = 2
重新开始：4
```

所以应该从 `4` 重新开始。

### `dropFirst()` 的作用

代码先使用第一个元素初始化状态：

```swift
var current = first
var best = first
```

因此后续只需要遍历剩余元素：

```swift
for num in nums.dropFirst() {
    ...
}
```

`dropFirst()` 会返回去掉第一个元素后的集合，避免第一个元素被重复处理。也可以使用 `1..<nums.count` 的下标循环实现同样逻辑。

### 负数数组注意事项

不能把 `best` 初始化为 `0`，否则数组全为负数时会返回错误结果。例如：

```text
[-3, -1, -2]
```

正确答案是 `-1`，所以当前代码使用第一个元素初始化 `current` 和 `best` 是正确的。

### 复杂度

- 时间复杂度：`O(n)`，数组只遍历一次。
- 额外空间复杂度：`O(1)`。
*/
//: [下一题](@next)
