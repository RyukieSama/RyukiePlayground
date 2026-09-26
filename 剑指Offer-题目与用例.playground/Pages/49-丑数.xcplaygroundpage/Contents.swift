//: [上一题](@previous)

/*:
# 49-丑数

## 题目

我们把只包含质因子 2、3 和 5 的数称作丑数（Ugly Number）。求按从小到大的顺序的第 n 个丑数。

## 用例

**输入：** n = 10

**输出：** 12

解释: 1, 2, 3, 4, 5, 6, 8, 9, 10, 12 是前 10 个丑数。

## 说明

1 是丑数。

n 不超过1690。

注意：本题与主站 264 题相同：https://leetcode-cn.com/problems/ugly-number-ii/

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/ugly-number-ii/)
*/
//
//func ugly(_ n: Int) -> Int {
//    var num: Int = 1
//
//    for idx in 2...n {
//        let n1 = num * 2,
//            n2 = num * 3,
//            n3 = num * 5
//        let min = min(n1, n2, n3)
//        num = min
//    }
//    
//    return num
//}

func ugly(_ n: Int) -> Int {
    guard n > 0 else {
        return 0
    }
    
    var numbers = Array(repeating: 1, count: n)
    var p2 = 0
    var p3 = 0
    var p5 = 0
    
    for i in 1..<n {
        let next2 = numbers[p2] * 2
        let next3 = numbers[p3] * 3
        let next5 = numbers[p5] * 5
        
        numbers[i] = min(next2, next3, next5)
        
        // 因此生成当前最小值后，需要把所有小于等于当前值的候选指针都向后移动，保证下一轮不会再次生成重复数字。
        while numbers[p2] * 2 <= numbers[i] {
            p2 += 1
        }
        
        while numbers[p3] * 3 <= numbers[i] {
            p3 += 1
        }
        
        while numbers[p5] * 5 <= numbers[i] {
            p5 += 1
        }
    }
    
    return numbers[n - 1]
}


/*:
## 题目解析

丑数只包含质因子 `2`、`3` 和 `5`。当前实现使用动态规划数组和三个指针，按从小到大的顺序生成丑数。

### 为什么不能只使用上一个数字

如果每次只让上一个数字乘以 `2`、`3`、`5`，会得到：

`1 → 2 → 4 → 8 → 16`

这样会漏掉 `3、5、6、9、10、12` 等丑数。下一个丑数必须由所有已经生成的丑数共同产生。

### 三个指针

- `p2`：指向下一个要乘以 `2` 的丑数；
- `p3`：指向下一个要乘以 `3` 的丑数；
- `p5`：指向下一个要乘以 `5` 的丑数。

每轮取三个候选值中的最小值：

`numbers[p2] × 2`、`numbers[p3] × 3`、`numbers[p5] × 5`。

### 为什么要使用 `while` 移动指针

不同组合可能得到相同结果：

`2 × 3 = 6`，`3 × 2 = 6`。

如果只移动一个指针，`6` 会被重复加入。因此生成当前最小值后，需要把所有小于等于当前值的候选指针都向后移动，保证下一轮不会再次生成重复数字。

### 边界情况

- `n == 1` 时，数组中只有初始丑数 `1`，直接返回 `1`。
- `n <= 0` 不符合题目约束，当前代码返回 `0`。

### 复杂度

- 时间复杂度：`O(n)`，三个指针整体只会向后移动。
- 额外空间复杂度：`O(n)`，用于保存丑数序列。
*/
//: [下一题](@next)
