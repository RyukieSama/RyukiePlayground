//: [上一题](@previous)

/*:
# 12-矩阵中的路径

## 题目

给定一个 m x n 二维字符网格 board 和一个字符串单词 word 。如果 word 存在于网格中，返回 true ；否则，返回 false 。

单词必须按照字母顺序，通过相邻的单元格内的字母构成，其中“相邻”单元格是那些水平相邻或垂直相邻的单元格。同一个单元格内的字母不允许被重复使用。

例如，在下面的 3×4 的矩阵中包含单词 "ABCCED"（单词中的字母已标出）。

|A|B|C|E|
|S|F|C|S|
|A|D|E|E|

## 用例 1

**输入：** board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
**输出：** true
## 用例 2

**输入：** board = [["a","b"],["c","d"]], word = "abcd"
**输出：** false

## 提示

1 <= board.length <= 200
1 <= board[i].length <= 200
board 和 word 仅由大小写英文字母组成

注意：本题与主站 79 题相同：https://leetcode-cn.com/problems/word-search/

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/word-search/)
*/

let board: [[Character]] = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"

func findWords(board: [[Character]], words: String) -> Bool {
    guard
        words.isEmpty == false,
        let fl = board.first,
        fl.isEmpty == false
    else {
        return false
    }
    let width = fl.count, height = board.count, words = Array(words)
    var mark: [[Bool]] = Array(repeating: Array(repeating: false, count: width), count: height)
    var offset = 0
    
    for y in 0..<height {
        for x in 0..<width {
            if fromThisPointCanFinish(x: x, y: y) {
                return true
            }
        }
    }
    
    func fromThisPointCanFinish(x: Int, y: Int) -> Bool {
        guard offset < words.count else {
            return true
        }
        
        if x >= 0,
           y >= 0,
           x < width,
           y < height,
           board[y][x] == words[offset],
           mark[y][x] == false {
            mark[y][x] = true
            offset += 1
            
            let nextCan = fromThisPointCanFinish(x: x - 1, y: y) ||
            fromThisPointCanFinish(x: x + 1, y: y) ||
            fromThisPointCanFinish(x: x, y: y - 1) ||
            fromThisPointCanFinish(x: x, y: y + 1)
            
            if nextCan {
                return true
            }
            else {
                mark[y][x] = false
                offset -= 1
                return false
            }
        }
        
        return false
    }
    
    return false
}

findWords(board: board, words: word)

/*:
## DFS + 回溯解析

这道题需要判断：是否能够从矩阵中的某个位置出发，按照单词字符的顺序走出完整路径。

### 1. 遍历所有起点

单词不一定从左上角开始，因此外层两个 `for` 循环会把每个单元格都作为可能的起点。

### 2. DFS 的含义

`fromThisPointCanFinish(x:y:)` 表示当前位于 `(x, y)`，继续寻找 `words[offset]` 以及后面的字符。
当前字符匹配成功后，再向上、下、左、右四个方向递归搜索。

### 3. 回溯的作用

某个方向可能暂时匹配成功，但后续字符无法继续匹配。这时需要撤销当前选择：

```swift
mark[y][x] = false
offset -= 1
```

撤销后，上一层递归才能继续尝试其他方向；否则已经走过的格子会错误地影响其他路径。

### 4. `mark` 的作用

`mark[y][x] == true` 表示当前路径已经使用过这个单元格，防止同一个格子被重复使用。回溯时必须恢复为 `false`。

### 5. 终止条件

```swift
guard offset < words.count else {
    return true
}
```

当 `offset` 达到单词长度，说明所有字符都匹配成功。当前位置越界、字符不匹配或格子已使用时，函数返回 `false`。

### 6. 当前实现的注意点

- `offset` 是递归函数外部的共享状态，当前通过 `offset += 1` 和 `offset -= 1` 保持平衡，因此逻辑可以成立；更常见的写法是将 `index` 作为递归参数传递。
- 匹配到最后一个字符后，当前实现还会继续调用一次递归，再由 `guard` 返回 `true`，结果正确但可以进一步优化为直接返回。
- 本题假设矩阵是规则矩阵，因此使用第一行的长度作为统一宽度是安全的。

### 7. 复杂度

设矩阵大小为 `m × n`，单词长度为 `L`：

- 时间复杂度：最坏为 `O(m × n × 4^L)`
- 空间复杂度：`O(m × n + L)`

其中 `O(m × n)` 来自 `mark`，`O(L)` 来自递归调用栈。
*/

//: [下一题](@next)
