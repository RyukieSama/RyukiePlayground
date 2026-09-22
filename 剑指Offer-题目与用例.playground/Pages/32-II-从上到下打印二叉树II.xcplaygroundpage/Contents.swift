//: [上一题](@previous)

/*:
# 32-II-从上到下打印二叉树II

## 题目

从上到下按层打印二叉树，同一层的节点按从左到右的顺序打印，每一层打印到一行。

例如:

给定二叉树: [3,9,20,null,null,15,7],

3
/ \
9  20
/  \
15   7
返回其层次遍历结果：

[
[3],
[9,20],
[15,7]
]

## 提示

节点总数 <= 1000
注意：本题与主站 102 题相同：https://leetcode-cn.com/problems/binary-tree-level-order-traversal/

## 用例

**输入：** `root = [3,9,20,null,null,15,7]`

**输出：** `[[3],[9,20],[15,7]]`

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/binary-tree-level-order-traversal/)
*/

func printUpDown(_ tree: TreeNode?) -> [[Int]] {
    var result: [[Int]] = []
    var queue: [TreeNode] = []
    guard let tree = tree else { return result }
    var temp: [Int] = []
    /// 当前行剩余个数
    var currentLineLeftCount = 1
    /// 下一行个数
    var nextLineCount = 0
    var idx = 0
    
    queue.append(tree)
    
    while idx < queue.count {
        let node = queue[idx]
        temp.append(node.val)
        currentLineLeftCount -= 1
        
        if let left = node.left {
            queue.append(left)
            nextLineCount += 1
        }
        
        if let right = node.right {
            queue.append(right)
            nextLineCount += 1
        }
        
        if currentLineLeftCount == 0 {
            currentLineLeftCount = nextLineCount
            nextLineCount = 0
            result.append(temp)
            temp = []
        }
        
        idx += 1
    }
    
    
    
    return result
}

/*:
## 分层 BFS 解析

32-II 仍然使用 BFS，但需要把同一层的节点放入同一个数组。当前实现使用三个变量维护层状态：

- `temp`：保存当前层的节点值。
- `currentLineLeftCount`：当前层还剩多少个节点没有处理。
- `nextLineCount`：下一层已经加入队列的节点数量。

每处理一个节点，就将它加入 `temp`，并让当前层剩余数量减一。发现左右子节点时，把它们加入队列，并增加 `nextLineCount`。

当 `currentLineLeftCount == 0` 时，说明当前层已经处理完。此时将 `temp` 加入结果，并把 `nextLineCount` 交给 `currentLineLeftCount`，然后清空 `temp` 和 `nextLineCount`，开始处理下一层。

对于示例树：

```text
    3
   / \
  9  20
     / \
    15  7
```

最终分层结果为：

```text
[3]
[9, 20]
[15, 7]
```

当前使用 `idx` 访问队列，而不是 `removeFirst()`，避免删除数组首元素时移动后面的元素。

复杂度：

- 时间复杂度：`O(n)`，每个节点访问一次。
- 空间复杂度：`O(n)`，来自队列和结果数组。
*/

//: [下一题](@next)
