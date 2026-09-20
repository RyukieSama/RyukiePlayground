//: [上一题](@previous)

/*:
# 17-打印从1到最大的n位数

## 题目

输入数字 n，按顺序打印出从 1 到最大的 n 位十进制数。比如输入 3，则打印出 1、2、3 一直到最大的 3 位数 999。

## 用例 1

**输入：** n = 1
**输出：** [1,2,3,4,5,6,7,8,9]

## 说明

用返回一个整数列表来代替打印
n 为正整数

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/da-yin-cong-1dao-zui-da-de-nwei-shu-lcof)
*/


func printNum(n: Int) -> [String] {
    guard n > 0 else { return [] }
    
    // 用字符数组保存每一位，避免大数超出 Int 的表示范围
    var digits = Array(repeating: "0", count: n)
    var result: [String] = []
    
    func dfs(_ index: Int) {
        guard index < n else {
            let number = digits.joined().drop { $0 == "0" }
            if number.isEmpty == false {
                result.append(String(number))
            }
            return
        }
        
        for digit in 0...9 {
            digits[index] = String(digit)
            dfs(index + 1)
        }
    }
    
    dfs(0)
    return result
}

/*:
## DFS 解题解析

### 为什么不能直接使用整数

当 `n` 较小时，可以从 `1` 遍历到 `10^n - 1`。但当 `n` 较大时，最大的 n 位数可能超出 `Int` 的表示范围。

因此使用字符数组保存每一位，并返回 `[String]`，避免大数溢出。

### DFS 的状态

```swift
dfs(index)
```

表示正在填写第 `index` 位。每一位都可以选择 `0...9`：

```swift
for digit in 0...9 {
    digits[index] = String(digit)
    dfs(index + 1)
}
```

当 `index == n` 时，说明所有位都已经填写完成，可以得到一个完整的 n 位数字。

### 递归调用过程

以 `n = 2` 为例：

```text
dfs(0)
├── 选择第一位 0
│   ├── 选择第二位 0 → "00"
│   ├── 选择第二位 1 → "01"
│   └── ...
├── 选择第一位 1
│   ├── 选择第二位 0 → "10"
│   ├── 选择第二位 1 → "11"
│   └── ...
└── ...
```

`index` 表示当前要填写的位置：

- `dfs(0)`：填写第一位。
- `dfs(1)`：填写第二位。
- `dfs(2)`：所有位都填写完成，生成结果。

当某一位选择了一个数字后，递归进入下一位；下一位的所有选择完成后，函数返回上一层，上一层继续尝试下一个数字。这就是深度优先搜索的“先走到底，再回来换选择”。

例如选择路径：

```text
第一位选择 1 → 第二位选择 3 → 生成 "13"
```

生成 `"13"` 后返回到第二位，继续生成 `"14"`、`"15"`；第二位全部尝试完后，再返回第一位尝试 `2`。

这里不需要额外撤销选择，因为下一次循环会直接覆盖当前位：

```swift
digits[index] = String(digit)
```

### 前导零处理

DFS 会先生成固定长度的组合：

```text
00、01、02、...、99
```

其中 `00` 不应输出，`01` 应输出为 `1`，因此生成完整数字后需要去掉前导零。去掉后为空时，说明原数字全是零，需要跳过。

### 为什么不需要撤销选择

每次递归都会重新覆盖当前位：

```swift
digits[index] = String(digit)
```

所以不需要像网格路径问题那样额外恢复状态。

### 复杂度

- 时间复杂度：`O(10^n)`，因为需要生成所有数字。
- 递归栈空间：`O(n)`。
- 如果计算返回结果所占空间，结果数组需要 `O(10^n)` 空间。
*/

//: [下一题](@next)
