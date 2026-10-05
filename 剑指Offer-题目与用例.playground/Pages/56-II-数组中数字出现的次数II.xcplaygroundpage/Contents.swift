//: [上一题](@previous)

/*:
# 56-II-数组中数字出现的次数II

## 题目

在一个数组 nums 中除一个数字只出现一次之外，其他数字都出现了三次。请找出那个只出现一次的数字。

## 用例 1

**输入：** nums = [3,4,3,3]

**输出：** 4

## 用例 2

**输入：** nums = [9,1,7,9,7,9,7]

**输出：** 1

## 约束

1 <= nums.length <= 10000

1 <= nums[i] < 2^31

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/shu-zu-zhong-shu-zi-chu-xian-de-ci-shu-ii-lcof)
*/

func find20261005(_ nums: [Int]) -> Int {
    /**
     一位位遍历
     每一位的 1 的个数对 3 取模，就是结果数字这一位的值
     */
    // 根据约束，确定 30 位
    var result = 0
    
    for dig in 0...30 {
        let flag = 1 << dig
        var oneCount = 0
        
        for val in nums {
            if val & flag != 0 {
                // 这位是 1
                oneCount += 1
            }
        }
        
        if oneCount % 3 != 0 {
            // 说明这是 1
            result |= flag
        }
        
    }
    
    return result
}

func find(_ nums: [Int]) -> Int {
    /**
     二进制位，每一位的 1 的个数和对 3 取余数。
     最后就可以留下结果
     */
    var result = 0
    
    for dig in 0...30 {
        var flag = 1 << dig// 用来检查该位的 1
        var count = 0
        
        for n in nums {
            if n & flag != 0 {
                count += 1
            }
        }
        
        if count % 3 > 0 { // 结果的这一位是 1
            result = result | flag
        }
    }
    
    return result
}

/*:
## 题目解析

题目保证除了一个数字只出现一次外，其余数字都出现三次。可以把每个数字拆成二进制的每一位，分别统计每一位上 `1` 的总数。

### 为什么对 3 取模

出现三次的数字，在任意一个二进制位上的贡献都是 `3` 的倍数。将该位的总数对 `3` 取模后，三次出现的数字贡献都会被消除，只剩下只出现一次的数字贡献：

```text
count % 3 == 0：目标数字这一位是 0
count % 3 != 0：目标数字这一位是 1
```

### `flag` 的作用

```swift
let flag = 1 << dig
```

`flag` 只在第 `dig` 位上是 `1`，其余位都是 `0`。使用：

```swift
(n & flag) != 0
```

即可判断数字 `n` 的当前位是否为 `1`。

### 为什么遍历 `0...30`

题目规定：

```text
1 <= nums[i] < 2^31
```

因此最高可能使用第 `30` 位，遍历 `0...30` 就能覆盖所有有效位。

### 如何构造结果

如果某一位统计后余数不为 `0`，说明答案在这一位是 `1`：

```swift
result |= flag
```

遍历完成后，所有属于答案的二进制位都会被设置，`result` 就是只出现一次的数字。

### 示例

对于 `[3, 4, 3, 3]`：

```text
3 = 0011
4 = 0100
3 = 0011
3 = 0011
```

逐位统计并对 `3` 取模后，只剩下 `0100`，即 `4`。

### 复杂度

- 时间复杂度：`O(31n)`，可简写为 `O(n)`。
- 额外空间复杂度：`O(1)`。
*/

//: [下一题](@next)
