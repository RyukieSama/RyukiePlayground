//: [上一题](@previous)

/*:
# 32-III-从上到下打印二叉树III

## 题目

请实现一个函数按照之字形顺序打印二叉树，即第一行按照从左到右的顺序打印，第二层按照从右到左的顺序打印，第三行再按照从左到右的顺序打印，其他行以此类推。

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
[20,9],
[15,7]
]

## 提示

节点总数 <= 1000

## 用例

**输入：** `root = [3,9,20,null,null,15,7]`

**输出：** `[[3],[20,9],[15,7]]`

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/cong-shang-dao-xia-da-yin-er-cha-shu-iii-lcof)
*/

func printUpDown(_ tree: TreeNode?) -> [[Int]] {
    var result: [[Int]] = []
    guard let tree = tree else { return result }
    var queue: [TreeNode] = [], flag = true, temp: [Int] = [], idx = 0
    var currentLineLeftCount = 0, nextLineCount = 0
    
    queue.append(tree)
    currentLineLeftCount += 1
    
    while idx < queue.count {
        let node = queue[idx]
//        flag ? temp.append(node.val) : temp.insert(node.val, at: 0) // insert 效率不高，放在后面倒
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
            result.append(flag ? temp : temp.reversed())
            temp = []
            flag.toggle()
        }
        
        idx += 1
    }
    
    return result
}

/*:
## 之字形层序遍历解析

### 核心思路

32-III 仍然使用 BFS 按层遍历，但每一层的输出方向交替变化：

```text
第 1 层：从左到右
第 2 层：从右到左
第 3 层：从左到右
```

`flag` 表示当前层是否按照从左到右的顺序输出：

- `flag == true`：直接使用 `temp`。
- `flag == false`：使用 `temp.reversed()`。

### 为什么节点仍然按左、右顺序入队

队列始终按照 BFS 的顺序保存节点：

```swift
左子节点先入队
右子节点后入队
```

这样可以保证下一层节点按照正常的从左到右顺序收集到 `temp`。当该层要求从右到左输出时，只需要在这一层结束时反转 `temp`，不需要改变入队顺序。

### 每层结束时的处理

当：

```swift
currentLineLeftCount == 0
```

说明当前层已经处理完成，此时：

1. 根据 `flag` 将当前层加入结果。
2. 将当前层方向切换给下一层。
3. 使用 `nextLineCount` 初始化下一层的节点数量。
4. 清空 `temp`，准备收集下一层。

当前代码的顺序是先输出，再切换：

```swift
result.append(flag ? temp : temp.reversed())
flag.toggle()
```

这样可以避免把当前层误用成下一层的方向。

### 示例

对于：

```text
    3
   / \
  9  20
     / \
    15  7
```

收集过程为：

```text
temp = [3]       → [3]
temp = [9, 20]   → [20, 9]
temp = [15, 7]   → [15, 7]
```

最终结果：

```text
[[3], [20, 9], [15, 7]]
```

### 复杂度

- 时间复杂度：`O(n)`，每个节点访问一次，每层反转的总元素数量不超过 `n`。
- 空间复杂度：`O(n)`，来自队列、当前层数组和结果数组。
*/

//: [下一题](@next)
