//: [上一题](@previous)

/*:
# LeetCode-1209-删除字符串中的所有相邻重复项 II

## 题目

给定字符串 `s` 和整数 `k`。一次删除操作会选择 `k` 个相邻且相同的字母并将它们删除，使被删除部分的左右两侧重新连接。

反复执行删除操作，直到无法继续。返回最终的字符串，答案保证唯一。

## 用例 1

**输入：** `s = "abcd"`，`k = 2`

**输出：** `"abcd"`

## 用例 2

**输入：** `s = "deeedbbcccbdaa"`，`k = 3`

**输出：** `"aa"`

## 用例 3

**输入：** `s = "pbbcggttciiippooaais"`，`k = 2`

**输出：** `"ps"`

## 约束

- `1 <= s.count <= 10⁵`
- `2 <= k <= 10⁴`
- `s` 仅由小写英文字母组成

## 来源

[LeetCode 原题](https://leetcode.cn/problems/remove-all-adjacent-duplicates-in-string-ii/)
*/
func cut20261007(_ str: String, k: Int) -> String {
    guard k >= 2, str.count >= k else {
        return str
    }
    var stack: [Character] = []
    stack.reserveCapacity(str.count)
    
    func needCut(_ chr: Character) -> Int? {
        guard let last = stack.last, chr == last else {
            return nil
        }
        /**
         检查是否连续重复够了
         */
        var deta = k - 1, idx = stack.count - 1
        var removeCount: Int = 0
        while deta > 0, idx >= 0 {
            if stack[idx] == chr {
                removeCount += 1
                idx -= 1
                deta -= 1
            }
            else {
                return nil
            }
        }
        
        return removeCount
    }
    
    for chr in str {
        if stack.count >= k - 1, let removeCount = needCut(chr), removeCount > 0 {
            for _ in 0..<removeCount {
                stack.removeLast()
            }
        }
        else {
            stack.append(chr)
        }
    }
    
    return String(stack)
}


func cut(_ str: String, k: Int) -> String {
    var stack: [(character: Character, count: Int)] = []
    stack.reserveCapacity(str.count)

    for character in str {
        if let last = stack.last,
           last.character == character {
            // 当前字符与栈顶字符相同，增加连续次数。
            stack[stack.count - 1].count += 1

            // 连续数量达到 k，删除整组字符。
            if stack[stack.count - 1].count == k {
                stack.removeLast()
            }
        } else {
            // 与栈顶不同，创建一组新的连续字符。
            stack.append((character, 1))
        }
    }

    // 根据栈中剩余字符及次数重建结果。
    var result = ""
    result.reserveCapacity(str.count)

    for item in stack {
        for _ in 0..<item.count {
            result.append(item.character)
        }
    }

    return result
}

/*:
## 题目解析

这道题是 1047 的扩展。1047 中两个相同字符相邻就会删除，相当于 `k = 2`。本题要求同一字符连续出现 `k` 次时才能删除，所以栈中除了字符，还需要记录连续出现的次数。

### 计数栈

栈中的每个元素代表一组连续相同的字符：

```swift
(character: Character, count: Int)
```

- `character` 是这组字符；
- `count` 是该字符当前连续出现的次数。

遍历字符串时：

- 当前字符与栈顶字符相同，将栈顶的 `count` 加 `1`；
- 两者不同，向栈中加入计数为 `1` 的新分组；
- 栈顶分组的 `count` 达到 `k` 时，删除整组，即执行 `removeLast()`。

由于计数一达到 `k` 就会删除整组，所以栈中保留分组的 `count` 始终小于 `k`。

### 为什么能处理级联删除

以 `s = "deeedbbcccbdaa"`、`k = 3` 为例：

```text
deeedbbcccbdaa
删除 eee -> ddbbcccbdaa
删除 ccc -> ddbbbdaa
删除 bbb -> dddaa
删除 ddd -> aa
```

一组字符被弹出后，它前面尚未被删除的分组会重新成为栈顶。后续遇到相同字符时，就会继续增加该分组的计数，因此不需要重新扫描，也能自然完成级联删除。

例如 `ccc` 被删除后，前面的 `bb` 重新成为栈顶。接着读取后面的 `b` 时，计数变成 `3`，于是 `bbb` 也被删除。

### 重建结果

遍历完成后，栈中剩下的是未被删除的字符分组。按照每个分组的 `count`，将 `character` 重复追加到 `result` 即可。

例如栈中剩余：

```text
(a, 2), (b, 1)
```

重建后的结果是 `"aab"`。

### `reserveCapacity` 的作用

`stack.reserveCapacity(str.count)` 和 `result.reserveCapacity(str.count)` 提前为栈和结果预留存储空间，减少追加元素时的扩容和内存搬移。

这只是性能优化，不会增加当前的元素数量，省略后也不影响算法正确性。

### 复杂度

- 时间复杂度：`O(n)`，每个字符只需要处理一次，重建结果也最多处理 `n` 个字符；
- 额外空间复杂度：`O(n)`，最坏情况下所有字符都会保留在栈中。
*/


//: [下一题](@next)
