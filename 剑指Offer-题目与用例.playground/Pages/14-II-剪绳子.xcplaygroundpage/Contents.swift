//: [上一题](@previous)

/*:
# 14-II-剪绳子

## 题目

给你一根长度为 n 的绳子，请把绳子剪成整数长度的 m 段（m、n都是整数，n>1并且m>1），每段绳子的长度记为 k[0],k[1]...k[m - 1] 。请问 k[0]*k[1]*...*k[m - 1] 可能的最大乘积是多少？例如，当绳子的长度是8时，我们把它剪成长度分别为2、3、3的三段，此时得到的最大乘积是18。

答案需要取模 1e9+7（1000000007），如计算初始结果为：1000000008，请返回 1。

## 用例 1

```Swift
输入: 2
输出: 1
解释: 2 = 1 + 1, 1 × 1 = 1
```

## 用例 2

```Swift
输入: 10
输出: 36
解释: 10 = 3 + 3 + 4, 3 × 3 × 4 = 36
```

## 提示

2 <= n <= 1000

注意：本题与[主站 343 题](https://leetcode-cn.com/problems/integer-break/)相同

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/integer-break/)
*/
let mod = 1000000007

func cut1(n: Int) -> Int {
    var res = 1
    
    if n <= 3 { // 必须剪开
        res = n - 1
    }
    else {
        let v = n % 3, x = n / 3
        
        if v == 0 {
            // 可以全部切成 3 求 3 的 x 次方
            res = mi(n: 3, count: x)
        }
        else if v == 1 {
            // 剩 1 那就留一个 4
            res = mi(n: 3, count: x - 1) * 4
        }
        else if v == 2 {
            // 剩 2 就不切了
            res = mi(n: 3, count: x) * 2
        }
    }
    
    return res % mod
}

func mi(n: Int, count: Int) -> Int {
    var res = 1
    for _ in 0..<count {
        res = res * n % mod
    }
    return res
}

// 不是这个平方的意思
//func qMi(n: Int, count: Int) -> Int {
//    var res = 1
//    // 通过平方来加快幂运算
//    let two = count / 2
//    
//    let d = n * n
//    for _ in 0..<two {
//        res = res * d
//    }
//    
//    if count % 2 == 1 {
//        res *= n
//    }
//    
//    return res
//}


// 错误的快速幂
//func qMi(n: Int, count: Int) -> Int {
//    var res = 1
//    var count = count
//    
//    while count > 0 {
//        if count % 2 == 1 {
//            res = res * n % mod
//        }
//        else {
//            res = res * res % mod
//        }
//        count /= 2
//    }
//    
//    return res
//}

func qMi(n: Int, count: Int) -> Int {
    var result = 1
    var base = n % mod
    var exponent = count
    
    while exponent > 0 {
        if exponent % 2 == 1 {
            result = result * base % mod
        }
        
        base = base * base % mod
        exponent /= 2
    }
    
    return result
}
/*:
## 14-II 解题解析

### 核心思路：贪心

在绳子总长度固定时，乘积最大时应尽可能拆出长度为 `3` 的部分。设：

```swift
let v = n % 3
let x = n / 3
```

根据余数分三种情况：

- `v == 0`：全部拆成 `3`，结果是 `3^x`。
- `v == 1`：不能保留一个 `1`，应把 `3 + 1` 改成 `2 + 2`，结果是 `3^(x - 1) × 4`。
- `v == 2`：保留一个 `2`，结果是 `3^x × 2`。

例如 `n = 10`：

```text
10 = 3 + 3 + 4
结果 = 3 × 3 × 4 = 36
```

### 边界条件

题目要求至少剪成两段，因此：

```text
n = 2 → 1 + 1 → 1
n = 3 → 1 + 2 → 2
```

所以 `n <= 3` 时返回 `n - 1`，不能直接把 `n` 当作一段返回。

### 取模处理

14-II 的结果需要对 `1_000_000_007` 取模。`mi` 中每次乘法后立即取模：

```swift
res = res * n % mod
```

这样可以避免中间结果不断增大。`0..<count` 表示恰好计算 `n^count`，当 `count == 0` 时循环不执行，结果保持为 `1`。

### 复杂度

- 时间复杂度：`O(n)`，当前 `mi` 使用循环计算幂。
- 空间复杂度：`O(1)`。

如果使用二进制快速幂，时间复杂度还可以优化为 `O(log n)`。
*/

/*:
## 快速幂 `qMi` 解析

`qMi(n:count:)` 用来计算：

```text
n^count % mod
```

### 三个变量的含义

- `result`：已经确定需要乘入最终答案的部分。
- `base`：当前正在处理的底数，例如 `n`、`n²`、`n⁴`、`n⁸`。
- `exponent`：还没有处理的指数。

### 为什么可以平方底数

指数可以按二进制拆分。例如：

```text
13 = 8 + 4 + 1
3^13 = 3^8 × 3^4 × 3^1
```

因此每一轮都将底数平方：

```text
3 → 3² → 3⁴ → 3⁸
```

同时将指数除以 `2`：

```text
13 → 6 → 3 → 1 → 0
```

### 奇数指数的处理

如果当前指数是奇数，说明当前底数需要计入结果：

```swift
if exponent % 2 == 1 {
    result = result * base % mod
}
```

无论当前指数奇偶，处理完后都要继续平方底数，并让指数减半：

```swift
base = base * base % mod
exponent /= 2
```

不能把平方底数写成平方 `result`，也不能用 `else` 跳过平方步骤。

### 为什么每次都取模

结果只需要保留对 `mod` 的余数，所以每次乘法后立即取模：

```swift
result = result * base % mod
base = base * base % mod
```

这样可以避免中间结果过大而溢出。

### 复杂度

每次循环都会将指数减半，因此：

- 时间复杂度：`O(log count)`
- 空间复杂度：`O(1)`
*/

//: [下一题](@next)
