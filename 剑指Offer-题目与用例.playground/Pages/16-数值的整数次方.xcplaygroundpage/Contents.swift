//: [上一题](@previous)

/*:
# 16-数值的整数次方

## 题目

实现 pow(x, n) ，即计算 x 的 n 次幂函数（即，xn）。不得使用库函数，同时不需要考虑大数问题。

## 用例 1

```
输入：x = 2.00000, n = 10
输出：1024.00000
```

## 用例 2

```
输入：x = 2.10000, n = 3
输出：9.26100
```

## 用例 3

```
输入：x = 2.00000, n = -2
输出：0.25000
解释：2^(-2) = 1 / (2^(2)) = 1/4 = 0.25
```

## 提示

-100.0 < x < 100.0
-231 <= n <= 231-1
-104 <= xn <= 104

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/shu-zhi-de-zheng-shu-ci-fang-lcof)
*/


//func mi(n: Int, count: Int) -> Int {
//    var res = 1, base = n, count = count
//    if count < 0 {
//        while count > 0 {
//            if count & 1 == 1 {
//                res = base / res
//            }
//            base = 1 / (base * base)
//            count /= 2
//        }
//    }
//    else if count > 0 {
//        while count > 0 {
//            if count & 1 == 1 {
//                res = base * res
//            }
//            base = base * base
//            count /= 2
//        }
//    }
//    else {
//        return 1
//    }
//    return res
//}

func mi(base: Double, count: Int) -> Double {
    var res: Double = 1, base = base, count = count
    
    if count == 0 {
        return 1
    }
    else if count < 0 {
        base = 1 / base
        count = -count
    }
    
    while count > 0 {
        if count & 1 == 1 {
            res = res * base
        }
        base = base * base
        count /= 2
    }
    
    return res
}

/*:
## 快速幂解析

### 1. 处理指数为零

任何非零数的零次方都是 `1`：

```swift
if count == 0 {
    return 1
}
```

### 2. 处理负指数

负指数满足：

```text
x^(-n) = (1 / x)^n
```

因此先将底数取倒数，再把指数转换为正数：

```swift
base = 1 / base
count = -count
```

例如：

```text
2^(-2) = (1 / 2)^2 = 0.25
```

### 3. 快速幂过程

如果直接循环相乘，时间复杂度是 `O(n)`。快速幂利用指数的二进制表示，每轮将指数减半：

```swift
while count > 0 {
    if (count & 1) == 1 {
        res = res * base
    }
    base = base * base
    count /= 2
}
```

- `(count & 1) == 1`：判断当前指数是否为奇数。
- 指数为奇数时，将当前 `base` 乘入结果。
- `base = base * base`：将 `x`、`x²`、`x⁴`、`x⁸` 依次准备好。
- `count /= 2`：处理下一位二进制指数。

例如计算 `2^13`：

```text
13 = 8 + 4 + 1
2^13 = 2^8 × 2^4 × 2^1
```

快速幂只需要不断平方和减半，而不需要连续相乘 13 次。

### 4. 边界注意事项

- 参数必须使用 `Double`，因为底数和结果可能是小数。
- `base == 0` 且指数为负数时，结果没有数学意义，通常题目不会提供这种输入。
- `count = -count` 在 `Int.min` 时可能溢出；本题指数范围较小，在 64 位 Swift 环境下不会触发，但使用更宽的整数类型会更稳妥。

### 5. 复杂度

- 时间复杂度：`O(log |count|)`。
- 空间复杂度：`O(1)`。
*/


//: [下一题](@next)
