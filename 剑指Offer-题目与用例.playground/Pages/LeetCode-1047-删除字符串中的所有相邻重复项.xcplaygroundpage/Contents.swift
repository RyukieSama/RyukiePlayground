//: [上一题](@previous)

/*:
# LeetCode-1047-删除字符串中的所有相邻重复项

## 题目

给定一个仅由小写字母组成的字符串 `s`。一次重复项删除操作会选择两个相邻且相同的字母并将它们删除。

反复执行删除操作，直到无法继续。返回最终的字符串，答案保证唯一。

## 用例 1

**输入：** `s = "abbaca"`

**输出：** `"ca"`

解释：先删除 `"bb"` 得到 `"aaca"`，再删除 `"aa"` 得到 `"ca"`。

## 约束

- `1 <= s.count <= 10⁵`
- `s` 仅由小写英文字母组成

## 来源

[LeetCode 原题](https://leetcode.cn/problems/remove-all-adjacent-duplicates-in-string/)
*/

func cut(_ str: String) -> String {
    var stack: [Character] = []
    stack.reserveCapacity(str.count)

    for character in str {
        if let last = stack.last, last == character {
            stack.removeLast()
        } else {
            stack.append(character)
        }
    }

    return String(stack)
}

/*:
## 题目解析

删除一对相邻重复字符后，原本不相邻的字符可能会变成新的相邻重复项。例如：

```text
abba
删除 bb -> aa
删除 aa -> ""
```

因此，每次删除后都需要继续检查新的相邻关系。栈可以自然地保留前面尚未被删除的字符，适合处理这种级联删除。

### 栈中保存什么

遍历字符串时，栈中保存的是当前已经处理过、且尚未被删除的字符。

对于每个新字符 `character`：

- 如果它与栈顶 `stack.last` 相同，说明两者组成相邻重复项，弹出栈顶；
- 如果不同，说明当前无法删除，将新字符压入栈中。

弹出栈顶后，之前的字符会重新成为栈顶，因此后续字符可以继续与它比较，不需要从头重新扫描。

### 示例推演

以 `str = "abbaca"` 为例：

| 读取字符 | 操作 | 栈中内容 |
| --- | --- | --- |
| `a` | 栈为空，压入 | `a` |
| `b` | 与栈顶不同，压入 | `ab` |
| `b` | 与栈顶相同，弹出 | `a` |
| `a` | 与栈顶相同，弹出 | 空 |
| `c` | 栈为空，压入 | `c` |
| `a` | 与栈顶不同，压入 | `ca` |

遍历完成后，栈中剩余的字符就是最终结果 `"ca"`。

### `reserveCapacity` 的作用

最坏情况下，字符串中没有任何可删除的相邻重复项，所有字符都会进入栈中。

```swift
stack.reserveCapacity(str.count)
```

这句代码会根据字符串长度提前为数组预留存储空间，减少 `append` 过程中的扩容和元素搬移。

它只会改变数组的容量，不会添加元素，所以此时 `stack.count` 仍然是 `0`。省略这句代码也不会影响结果，它只是性能优化。

### 复杂度

- 时间复杂度：`O(n)`，每个字符最多入栈一次、出栈一次；
- 额外空间复杂度：`O(n)`，最坏情况下所有字符都会保留在栈中。
*/

func cutXXX(_ str: String) -> String {
    /**
     - 已经不会因 endFlag 一直为 true 而死循环。
     - 示例 "abbaca" 可以通过。
     - "abba"、"abccba" 等尾部产生新重复项的情况仍然错误。
     - 编译检查通过，但算法还未正确。
     */
    guard str.count > 1 else {
        return str
    }
    var charArray = Array(str)
    var left = 0, right = 1
    var endFlag = false
    while charArray.count > 1, right < charArray.count, left >= 0 {
        let a = charArray[left], b = charArray[right]
        if a == b {
            charArray.remove(at: left)
            charArray.remove(at: left)
            // 继续原地对比 标记一下此次有进行删除
            endFlag = true
        }
        else {
            if right + 1 >= charArray.count {
                // 到头了，要重来一遍确保没问题
                if endFlag { // 此次进行过删除
                    endFlag = false
                    left = 0
                    right = 1
                }
                else {
                    // 此次检查没有删除
                    break
                }
            }
            else {
                left += 1
                right += 1
            }
        }
    }
    
    return String(charArray)
}
//: [下一题](@next)
