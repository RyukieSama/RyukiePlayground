//: [上一题](@previous)

/*:
# 38-字符串的排列

## 题目

输入一个字符串，打印出该字符串中字符的所有排列。

你可以以任意顺序返回这个字符串数组，但里面不能有重复元素。

## 用例

```
输入：s = "abc"
输出：["abc","acb","bac","bca","cab","cba"]
```

## 约束

`1 <= s 的长度 <= 8`

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/zi-fu-chuan-de-pai-lie-lcof)
*/

// 无法彻底理解，算了
func allRoder(_ str: String) -> [String] {
    let chars = Array(str).sorted()
    var used = Array(repeating: false, count: chars.count)
    var path: [Character] = []
    var result: [String] = []
    
    func dfs() {
        if path.count == chars.count {
            result.append(String(path))
            return
        }
        
        for i in chars.indices {
            if used[i] {
                continue
            }
            
            // 同一层跳过相同字符，避免生成重复排列
            if i > 0 && chars[i] == chars[i - 1] && !used[i - 1] {
                continue
            }
            
            used[i] = true
            path.append(chars[i])
            
            dfs()
            
            path.removeLast()
            used[i] = false
        }
    }
    
    dfs()
    return result
}

/*:
## 题目解析

这道题要求生成字符串的所有排列，并且结果中不能出现重复字符串。核心考察的是**回溯法**和**同层去重**。

### 回溯过程

排列过程可以看成一棵决策树：

1. 从还没有使用的字符中选择一个字符。
2. 把字符加入当前路径 `path`。
3. 递归处理剩余字符。
4. 递归结束后撤销选择，继续尝试其他字符。

当 `path.count == chars.count` 时，说明已经得到一个完整排列，将它加入结果数组。

### 为什么需要去重

如果输入是 `"aab"`，两个 `a` 的值相同。不做处理时会重复生成相同结果，最终只能保留：

```text
aab
aba
baa
```

代码先排序字符，使相同字符相邻，然后使用下面的条件进行剪枝：

```swift
if i > 0 && chars[i] == chars[i - 1] && !used[i - 1] {
    continue
}
```

它表示当前字符和前一个字符相同，并且前一个相同字符在当前递归层还没有被使用。此时选择当前字符会产生重复分支，所以跳过。

`!used[i - 1]` 很重要：它只跳过同一层的重复选择，不会阻止相同字符出现在排列的不同位置。

### 为什么需要回退

递归返回后执行：

```swift
path.removeLast()
used[i] = false
```

这会撤销当前选择，让循环可以尝试下一个字符。如果不回退，当前分支的字符会残留到其他分支中。

### 当前解法评价

当前 `allRoder` 的实现是正确的：

- `Array(str).sorted()` 将字符串转换为可按下标访问的字符数组，并为去重做准备。
- `used` 防止同一个下标对应的字符被重复使用。
- `path` 保存当前排列。
- `dfs()` 负责深度优先搜索。
- 同层剪枝保证结果没有重复字符串。

### 复杂度

- 最多生成 `n!` 个排列。
- 每个排列转换为字符串需要 `O(n)` 时间，因此时间复杂度约为 `O(n × n!)`。
- `used`、`path` 和递归栈需要 `O(n)` 额外空间。

题目限制字符串长度不超过 `8`，所以回溯法可以满足要求。
*/
//: [下一题](@next)
