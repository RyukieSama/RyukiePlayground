//: [上一题](@previous)

/*:
# Offer-II-072-求平方根

## 题目

给定一个非负整数 x ，计算并返回 x 的平方根，即实现 int sqrt(int x) 函数。

正数的平方根有两个，只输出其中的正数平方根。

如果平方根不是整数，输出只保留整数的部分，小数部分将被舍去。

## 用例 1

**输入：** x = 4
**输出：** 2
## 用例 2

**输入：** x = 8
**输出：** 2
解释: 8 的平方根是 2.82842...，由于小数部分将被舍去，所以返回 2

## 提示

0 <= x <= 231 - 1

注意：本题与主站 69 题相同： https://leetcode-cn.com/problems/sqrtx/

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/sqrtx/)
*/

func sol(_ x: Int) -> Int {
    // 0 和 1 的平方根就是自身
    guard x >= 2 else {
        return x
    }
//    var left = 0, right = x / 2
    var left = 1, right = x / 2
    var result = 1
    while left <= right {
        let middle = left + (right - left) / 2
        
        // 等价于 middle * middle <= x，
        // 使用除法可以避免乘法溢出。
        if middle <= x / middle {
            result = middle
            
            // middle 可能还是偏小，继续寻找更大的答案。
            left = middle + 1
        } else {
            // middle 的平方大于 x，需要缩小范围。
            right = middle - 1
        }
    }
    
    return result
}

/*:
## 题目解析

题目要求舍去平方根的小数部分。因此，问题可以转换为：在所有满足 `n × n <= x` 的整数中，找到最大的 `n`。

例如 `x = 8` 时，`2 × 2 <= 8`，但 `3 × 3 > 8`，所以答案是 `2`。

### 边界情况

`0` 和 `1` 的整数平方根都是它们自身，可以直接返回。这也保证了后面二分查找时 `middle` 不会为 `0`，避免执行 `x / middle` 时发生除零错误。

### 二分查找范围

对于 `x >= 2`，其整数平方根不会大于 `x / 2`，因此搜索范围可以设为 `[1, x / 2]`。

`result` 用来保存当前已经找到的、满足条件的最大值。

### 避免乘法溢出

直接计算 `middle × middle` 可能发生整数溢出。由于 `middle` 始终大于 `0`，判断：

```swift
middle * middle <= x
```

可以改写成等价且更安全的除法判断：

```swift
middle <= x / middle
```

### 更新搜索区间

如果 `middle <= x / middle`，说明 `middle` 是合法候选值。先用 `result = middle` 记录它，再令 `left = middle + 1`，继续在右半部寻找更大的合法整数。

如果 `middle > x / middle`，说明 `middle` 的平方大于 `x`，令 `right = middle - 1`，在左半部继续查找。

### 示例推演

以 `x = 8` 为例：

| `left` | `right` | `middle` | 判断 | 操作 |
| ---: | ---: | ---: | --- | --- |
| 1 | 4 | 2 | `2 <= 8 / 2` | 记录 `2`，向右查找 |
| 3 | 4 | 3 | `3 > 8 / 3` | 向左查找 |

此时 `left = 3`、`right = 2`，搜索结束，返回 `result = 2`。

### 复杂度

- 时间复杂度：`O(log x)`，每次都将搜索范围缩小一半；
- 空间复杂度：`O(1)`，只使用了固定数量的变量。
*/

//: [下一题](@next)
