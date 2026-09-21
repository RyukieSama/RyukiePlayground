//: [上一题](@previous)

/*:
# 30-包含min函数的栈

## 题目

定义栈的数据结构，请在该类型中实现一个能够得到栈的最小元素的 min 函数在该栈中，调用 min、push 及 pop 的时间复杂度都是 O(1)。

## 用例

**输入：**

```
["MinStack", "push", "push", "push", "min", "pop", "top", "min"]
[[], [-2], [0], [-3], [], [], [], []]
```

**输出：** `[null, null, null, null, -3, null, 0, -2]`

## 提示

各函数的调用总次数不超过 20000 次

注意：本题与主站 155 题相同：https://leetcode-cn.com/problems/min-stack/

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/min-stack/)
*/
class MinStack {
    // 注意是 栈 后进先出
    private var datas: [Int] = []
    private var records: [Int] = []
    
    func min() -> Int? {
        return records.last
    }
    
    func push(_ val: Int) {
        datas.append(val)
        if let rTop = records.last {
            if val < rTop {
                records.append(val)
            }
            else {
                records.append(rTop) // 可以保存每一次操作的步骤
            }
        }
        else {
            records.append(val)
        }
    }
    
    func pop() -> Int? {
        records.popLast()
        return datas.popLast()
    }
    
    func top() -> Int? {
        datas.last
    }
}


/*:
## MinStack 双栈解析

### 为什么需要辅助栈

如果只有 `datas`，每次调用 `min()` 都需要遍历整个栈，时间复杂度是 `O(n)`，不满足题目要求。

因此使用两个栈：

- `datas`：保存实际入栈的数据。
- `records`：保存每一层对应的最小值。

`records.last` 始终就是当前栈的最小值，所以 `min()` 可以在 `O(1)` 时间内完成。

### `push` 操作

新值入栈时，比较它和之前的最小值：

```swift
let currentMin = Swift.min(val, records.last ?? val)
records.append(currentMin)
```

当前实现把这个过程展开成了 `if` 判断，逻辑相同。

例如：

```text
push(-2)：datas = [-2]          records = [-2]
push(0)： datas = [-2, 0]       records = [-2, -2]
push(-3)：datas = [-2, 0, -3]   records = [-2, -2, -3]
```

### `pop` 操作

两个栈必须同步弹出：

```swift
records.popLast()
datas.popLast()
```

这样数据栈退回上一层状态时，最小值栈也会恢复到上一层的最小值。

### 为什么要保存重复的最小值

例如：

```text
push(2)
push(2)
pop()
```

如果 `records` 只保存一次 `2`，弹出一个元素后就会错误地丢失最小值。当前实现每次 `push` 都记录一次，因此能够正确处理重复最小值。

### 复杂度

- `push`：`O(1)`。
- `pop`：`O(1)`。
- `top`：`O(1)`。
- `min`：`O(1)`。
- 辅助空间：`O(n)`。
*/

//: [下一题](@next)
