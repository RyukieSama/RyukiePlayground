//: [上一题](@previous)

/*:
# 32-I-从上到下打印二叉树

## 题目

从上到下打印出二叉树的每个节点，同一层的节点按照从左到右的顺序打印。

例如:

给定二叉树: [3,9,20,null,null,15,7],

```
3
/ \
9  20
/  \
15   7
```

返回：

[3,9,20,15,7]

## 提示

节点总数 <= 1000

## 用例

**输入：** `root = [3,9,20,null,null,15,7]`

**输出：** `[3,9,20,15,7]`

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/cong-shang-dao-xia-da-yin-er-cha-shu-lcof)
*/


func printUpDown(_ tree: TreeNode?) -> [Int] {
    var res: [Int] = []
    guard let tree = tree else { return res }
    
    // BFS 
    // 先考虑把树拉成一个直线就好办了
    var queue: [TreeNode] = [tree]
    
    while let node = queue.first {
        queue.removeFirst()
        res.append(node.val)
        
        if let left = node.left {
            queue.append(left)
        }
        
        if let right = node.right {
            queue.append(right)
        }
    }
    
    return res
}

/*:
## BFS 层序遍历解析

### 核心思路

题目要求按照“从上到下、同层从左到右”的顺序访问节点，因此使用广度优先搜索（BFS）。

BFS 使用队列，遵循先进先出：

```text
取出队首节点
记录节点值
左子节点入队
右子节点入队
```

因为左节点先于右节点入队，所以同一层会保持从左到右的顺序。

### 遍历示例

对于：

```text
    3
   / \
  9  20
     / \
    15  7
```

队列变化如下：

```text
[3]
[9, 20]
[20, 15]
[15, 7]
[7]
[]
```

最终结果为：

```text
[3, 9, 20, 15, 7]
```

### 队列实现注意事项

当前代码使用：

```swift
queue.removeFirst()
```

它可以得到正确结果，但 Swift 数组删除第一个元素时，后面的元素可能需要整体前移，效率较低。

更推荐使用索引模拟队首：

```swift
var index = 0

while index < queue.count {
    let node = queue[index]
    index += 1
    // 处理 node
}
```

这样不会移动数组中的已有元素。

### 复杂度

- 时间复杂度：`O(n)`，每个节点访问一次。
- 使用索引队列时，额外空间复杂度：`O(n)`。
- 如果使用 `removeFirst()`，结果仍然正确，但大量节点时可能产生额外的移动开销。
*/

//: [下一题](@next)
