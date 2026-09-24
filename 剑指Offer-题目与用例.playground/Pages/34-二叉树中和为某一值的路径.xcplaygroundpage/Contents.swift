//: [上一题](@previous)

/*:
# 34-二叉树中和为某一值的路径

## 题目

输入一棵二叉树和一个整数，打印出二叉树中节点值的和为输入整数的所有路径。从树的根节点开始往下一直到叶节点所经过的节点形成一条路径。

## 用例

**输入：** `root = [5,4,8,11,null,13,4,7,2,null,null,5,1]`，`target = 22`

**输出：** `[[5,4,11,2], [5,8,4,5]]`

## 提示

节点总数 <= 10000

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/er-cha-shu-zhong-he-wei-mou-yi-zhi-de-lu-jing-lcof)
*/
// 注意题目要求一直到叶子节点
func route(of sum: Int, in tree: TreeNode?) -> [[Int]] {
    guard let tree = tree else { return [] }
    let val = tree.val
    var res: [[Int]] = []
    var path: [Int] = []
    
    func dfs(_ node: TreeNode?, _ remain: Int) {
        guard let node = node else { return }
        let val = node.val, isLeaf = node.left == nil && node.right == nil, nextReamin = remain - val
        
        path.append(val)
        
        if isLeaf {
            if nextReamin == 0 {
                res.append(path)
            }
        }
        else {
            dfs(node.left, nextReamin)
            dfs(node.right, nextReamin)
        }
        
        path.removeLast()
    }
    
    dfs(tree, sum)
    
    return res
}

/*:
## DFS 与回溯过程解析

### 递归函数的含义

```swift
dfs(node, remain)
```

表示当前走到了 `node`，当前路径还需要凑出 `remain`。

进入一个节点时，先把它加入当前路径，并扣除它的值：

```swift
path.append(val)
let nextRemaining = remain - val
```

### 先深入，再回溯

DFS 会优先沿着一个方向走到底。例如目标和为 `22` 时，可能先走：

```text
5 -> 4 -> 11 -> 7
```

此时路径为：

```text
[5, 4, 11, 7]
```

如果已经到达叶子节点，但剩余和不是 `0`，说明这条路径失败。函数返回上一层，并执行：

```swift
path.removeLast()
```

路径恢复为：

```text
[5, 4, 11]
```

然后继续尝试 11 的另一个子节点：

```text
5 -> 4 -> 11 -> 2
```

这条路径的和为 `22`，因此将 `[5, 4, 11, 2]` 加入结果。

### 回溯的三个步骤

每个节点都遵循同一个模板：

```text
1. 选择当前节点：path.append
2. 递归探索左右子树
3. 撤销选择：path.removeLast
```

`path` 保存的不是一条永久路径，而是当前递归分支正在经过的路径。返回上一层后必须移除当前节点，否则下一个分支会混入上一条路径的节点。

### 为什么必须走到叶子节点

只有满足下面两个条件，路径才有效：

```text
当前节点是叶子节点
路径节点和等于目标值
```

中间节点即使暂时满足目标和，也不能算有效路径，因为题目要求路径必须从根节点一直走到叶子节点。

### 注意负数节点

如果节点值可能为负数，不能因为当前剩余和小于 `0` 就提前结束，因为后面的负数节点可能再次把总和补回来。

### 复杂度

- 遍历每个节点一次，基础搜索复杂度为 `O(n)`。
- 保存路径到结果时会复制当前路径，整体最坏可达到 `O(n × h)`，其中 `h` 是树高。
- 递归栈和当前路径额外空间为 `O(h)`，不包括最终结果数组。
*/

//: [下一题](@next)
