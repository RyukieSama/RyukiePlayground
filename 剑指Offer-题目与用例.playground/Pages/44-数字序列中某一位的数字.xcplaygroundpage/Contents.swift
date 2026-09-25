//: [上一题](@previous)

/*:
# 44-数字序列中某一位的数字

## 题目

数字以0123456789101112131415…的格式序列化到一个字符序列中。

在这个序列中，第5位（从下标0开始计数）是5，第13位是1，第19位是4，等等。

请写一个函数，求任意第n位对应的数字。

## 用例 1

**输入：** n = 3
**输出：** 3
## 用例 2

**输入：** n = 11
**输出：** 0

## 约束

0 <= n < 2^31
注意：本题与主站 400 题相同：https://leetcode-cn.com/problems/nth-digit/

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/nth-digit/)
*/

func numOf(order: Int) -> Int {
    /**
     1位 0～9   10个数 10 长度 = 10
     2位 10～99  90个数 90 * 2 长度 = 180
     3位 100～999  900个数 900 * 3 长度 = 2700
     
     n位数有 9 * 10 * length 个长度
     
     
     递减找到区间，再确定区间内的偏移
     */
    var order = order, dig = 1, digLength = 1, startNum = 0, digTotalLength = 10
    
//    while order > digTotalLength {
    while order >= digTotalLength {
        order -= digTotalLength
        dig *= 10
        digLength += 1
        startNum = dig
        digTotalLength = 9 * dig * digLength
    }
    
    // 最后一个完整的数字
    let lastNum = startNum + order / digLength
    let charArr = Array("\(lastNum)")
    return Int(String(charArr[order%digLength])) ?? 0
}

/*:
## 题目解析

这道题需要在连续数字序列中找到第 `order` 位对应的数字。核心步骤是：

1. 先确定目标位属于几位数区间。
2. 再确定它属于区间中的哪个具体数字。
3. 最后确定它是这个数字中的第几位。

### `order / digLength` 的作用

```swift
let lastNum = startNum + order / digLength
```

此时的 `order` 已经是当前位数区间内部的偏移量，`digLength` 是每个数字占用的位数。

例如当前处于两位数区间：

```text
10 11 12 13
```

每个数字占 `2` 位：

| order | order / 2 | 对应数字 |
|---:|---:|---:|
| 0 | 0 | 10 |
| 1 | 0 | 10 |
| 2 | 1 | 11 |
| 3 | 1 | 11 |
| 4 | 2 | 12 |
| 5 | 2 | 12 |

因此这里使用的是整数除法，也就是向下取整。`order / digLength` 表示跳过了多少个完整数字。

### `order % digLength` 的作用

```swift
let charArr = Array("\\(lastNum)")
return Int(String(charArr[order % digLength])) ?? 0
```

`order % digLength` 用来确定目标字符在当前数字中的下标。

例如 `order = 3`、`digLength = 2`：

```swift
order / digLength = 1
order % digLength = 1
```

说明目标位属于第二个两位数。若起始数字是 `10`，当前数字就是：

```text
10 + 1 = 11
```

下标为 `1`，所以取出 `11` 的第二位，也就是字符 `1`。

### 示例：`order = 11`

序列前十位是：

```text
0 1 2 3 4 5 6 7 8 9
```

跳过这一组后：

```swift
order = 11 - 10 = 1
startNum = 10
digLength = 2
```

计算具体数字：

```swift
lastNum = 10 + 1 / 2 = 10
```

计算数字内部下标：

```swift
1 % 2 = 1
```

取出 `10` 的下标 `1`，结果就是 `0`。

### 注意事项

- `order / digLength` 必须使用向下取整，否则 `order = 1` 时会错误跳到下一个数字。
- `order % digLength` 的结果范围是 `0..<digLength`，一定是当前数字的合法下标。
- `Array("\\(lastNum)")` 是为了把字符串转换成可通过整数下标访问的字符数组。

### 复杂度

- 时间复杂度：`O(log n)`，最多遍历数字的位数区间。
- 额外空间复杂度：`O(d)`，`d` 是当前数字的位数，用于保存字符数组。
*/


//: [下一题](@next)
