//: [上一题](@previous)

/*:
# 43-1～n整数中1出现的次数

## 题目

输入一个整数 n ，求1～n这n个整数的十进制表示中1出现的次数。

例如，输入12，1～12这些整数中包含1 的数字有1、10、11和12，1一共出现了5次。

## 用例 1

**输入：** n = 12
**输出：** 5
## 用例 2

**输入：** n = 13
**输出：** 6

## 约束

1 <= n < 2^31
注意：本题与主站 233 题相同：https://leetcode-cn.com/problems/number-of-digit-one/

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/number-of-digit-one/)
*/

func countOfOne2(_ n: Int) -> Int {
    var res = 0, dig = 1
    
    while dig <= n {
        // 左侧数字
        let left = n / dig / 10
        // 右侧数字
        let right = n % dig
        // 当前位的数字
        let currentV = n / dig % 10
        
        switch currentV {
        case 1:
            /**
             123 1 5
             left: 123 right: 5
             0~122 0~9 + 123 0~5
             
             */
            res += (left * dig) + (right + 1)
        case 0:
            /**
             123 0 5
             0-122 0-9
             */
            res += left * dig
        default:
            /**
             123 5 5
             0-122 0-9 + 123 0-9
             */
            res += left * dig + dig
        }
        
        dig *= 10
    }
    
    return res
}

// 暴力，不可取
func countOfOne(_ n: Int) -> Int {
    guard n >= 1 else {
        return 0
    }
    var res = 0
    
    for n in 1...n {
        var idx = 0
        let chars = Array("\(n)")
        while idx < chars.count {
            if chars[idx] == "1" {
                res += 1
            }
            idx += 1
        }
    }
    
    return res
}


/*:
## 题目解析

这道题要求统计 `1...n` 中所有数字里，数字 `1` 出现的总次数。逐个遍历每个数字的暴力方法虽然容易理解，但时间复杂度为 `O(n log n)`，当 `n` 很大时会超时。

`countOfOne2` 使用按数位统计的方法，只需要从个位、十位、百位逐位计算。

### 三个变量的含义

以当前位权 `dig` 为 `1`、`10`、`100`……为例：

```swift
let left = n / dig / 10
let right = n % dig
let currentV = n / dig % 10
```

- `left`：当前位左边的数字。
- `currentV`：当前位的数字。
- `right`：当前位右边的数字。
- `dig`：当前位的权值，例如个位是 `1`，十位是 `10`。

### 当前位为 0

```swift
res += left * dig
```

当前位还没有达到 `1`，只能统计前面已经完整出现的周期。

### 当前位为 1

```swift
res += left * dig + right + 1
```

除了前面完整的 `left * dig` 次，还要加上当前这一组中右侧从 `0` 到 `right` 的情况，因此额外增加 `right + 1` 次。

### 当前位大于 1

```swift
res += left * dig + dig
```

当前位已经超过 `1`，所以比当前位等于 `1` 的情况多完整的一轮，共增加 `dig` 次。

### 示例：`n = 13`

统计个位时，`left = 1`、`currentV = 3`、`right = 0`，个位出现 `1` 的次数为 `1 × 1 + 1 = 2`，对应数字 `1` 和 `11`。

统计十位时，`left = 0`、`currentV = 1`、`right = 3`，十位出现 `1` 的次数为 `0 × 10 + 3 + 1 = 4`，对应数字 `10、11、12、13`。

最终结果为 `2 + 4 = 6`。

### 循环和边界

每处理完一位，就将 `dig` 乘以 `10`，依次处理个位、十位、百位，直到 `dig > n`。`n == 0` 时结果为 `0`，也可以显式增加 `guard n > 0`。

### 复杂度

- 时间复杂度：`O(log n)`，只遍历数字的各个位。
- 额外空间复杂度：`O(1)`。
*/
//: [下一题](@next)
