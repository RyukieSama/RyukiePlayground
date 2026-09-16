//: [上一题](@previous)

/*:
 # 09-用两个栈实现队列
 
 ## 题目
 
 用两个栈实现一个队列。请实现 `appendTail` 和 `deleteHead`：前者在队列尾部插入整数，后者删除并返回队列头部的整数。若队列为空，`deleteHead` 返回 `-1`。
 
 ## 用例 1
 
 **输入：** `["CQueue", "appendTail", "deleteHead", "deleteHead"]`，`[[], [3], [], []]`
 
 **输出：** `[null, null, 3, -1]`
 
 ## 约束
 
 - `1 <= value <= 10000`
 - 最多调用 `appendTail`、`deleteHead` 10000 次
 
 ## 来源
 
 [LeetCode 原题](https://leetcode.cn/problems/yong-liang-ge-zhan-shi-xian-dui-lie-lcof/)
 */

class SQueue {
    // 注意题目，这里是两个栈，是后进先出的。要注意使用的时候不能想当然的用数组的特性,队列是先进先出
    var stackA: [Int] = [], stackB: [Int] = []
    
    func appendTail(_ val: Int) {
        stackA.append(val)
    }
    
    func deleteHead() -> Int {
        if stackB.isEmpty {
            // stackB 用作出队列，没有数据就把a中的搬过来
            while let last = stackA.popLast() {
                stackB.append(last)
            }
        }
        return stackB.popLast() ?? -1
    }
}

/*:
## 两个栈实现队列：总结

### 核心矛盾

栈的特点是后进先出（LIFO），队列的特点是先进先出（FIFO）。
单个栈无法直接实现队列，因此使用两个栈进行方向转换：

- `stackA`：入队栈，只负责接收新元素。
- `stackB`：出队栈，栈顶保存当前最早进入队列的元素。

### 为什么倒栈后顺序正确

假设依次入队 `1、2、3`：

```
stackA = [1, 2, 3]
```

将 `stackA` 逐个弹出并压入 `stackB`：

```
stackB = [3, 2, 1]
```

此时 `stackB` 的栈顶是 `1`，正好符合队列的先进先出顺序。

### `deleteHead` 的处理规则

1. 如果 `stackB` 不为空，直接从 `stackB` 弹出。
2. 如果 `stackB` 为空，把 `stackA` 的所有元素倒入 `stackB`。
3. 再从 `stackB` 弹出队头元素。
4. 如果两个栈都为空，返回 `-1`。

关键是：只有当 `stackB` 为空时才能倒栈。
如果 `stackB` 仍有元素，说明它们比 `stackA` 中新加入的元素更早进入队列，
必须优先出队。

### 操作过程示例

```
appendTail(1)  -> stackA = [1],     stackB = []
appendTail(2)  -> stackA = [1, 2],  stackB = []
deleteHead()   -> stackA = [],      stackB = [2]，返回 1
appendTail(3)  -> stackA = [3],     stackB = [2]
deleteHead()   -> stackA = [3],     stackB = []，返回 2
deleteHead()   -> stackA = [],      stackB = []，先搬运 3，返回 3
```

### 常见错误

- 每次 `deleteHead` 都把 `stackA` 倒入 `stackB`，会破坏已有的出队顺序。
- `stackB` 不为空时仍然倒栈，会让新元素跑到旧元素前面。
- 直接对 `stackA` 使用 `removeFirst()`，这不是栈操作，而且数组头部删除可能是 `O(n)`。
- 忘记处理两个栈都为空的情况，导致空队列出队时崩溃或返回错误值。

### 正确性依据

`stackB` 不为空时，里面保存的是当前队列中更早入队的一批元素；
`stackB` 为空时，才需要把 `stackA` 中的元素反转到 `stackB`。
因此，每个元素都按照进入队列的先后顺序从 `stackB` 弹出。

### 复杂度

- `appendTail`：`O(1)`
- 单次 `deleteHead`：最坏 `O(n)`（需要倒栈时）
- 摊销时间复杂度：`O(1)`
- 空间复杂度：`O(n)`

虽然某一次倒栈需要移动多个元素，但每个元素最多从 `stackA` 移动到
`stackB` 一次，再从 `stackB` 弹出一次，所以连续执行 `n` 次操作的总成本是 `O(n)`。

### 封装建议

当前 `stackA` 和 `stackB` 可以被外部直接修改。实际项目中可以将它们声明为
`private`，只通过 `appendTail` 和 `deleteHead` 操作队列。
*/


//: [下一题](@next)
