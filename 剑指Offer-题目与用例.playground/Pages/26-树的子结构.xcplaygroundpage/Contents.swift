//: [上一题](@previous)

/*:
# 26-树的子结构

## 题目

输入两棵二叉树A和B，判断B是不是A的子结构。(约定空树不是任意一个树的子结构)

B是A的子结构， 即 A中有出现和B相同的结构和节点值。

例如:

***给定的树 A:***

```
3
/ \
4   5
/ \
1   2
```

***给定的树 B：***

```
4
/
1
```

返回 true，因为 B 与 A 的一个子树拥有相同的结构和节点值。

## 用例 1

* 输入：A = [1,2,3], B = [3,1]
* 输出：false

## 用例 2

* 输入：A = [3,4,5,1,2], B = [4,1]
* 输出：true

## 约束

0 <= 节点个数 <= 10000

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/shu-de-zi-jie-gou-lcof)
*/

func bIsSubTree(aTree: TreeNode?, bTree: TreeNode?) -> Bool {
    guard let aTree = aTree, let bTree = bTree else { return false } // 空树不是任何树的子树
        
    return nodeMatch(a: aTree, b: bTree)
    || bIsSubTree(aTree: aTree.left, bTree: bTree)
    || bIsSubTree(aTree: aTree.right, bTree: bTree)
}

func nodeMatch(a: TreeNode?, b: TreeNode?) -> Bool {
    guard
        let b = b
    else {
        return true // 表示 b 的匹配已完成
//        return false // 这里不能 false
    }
    guard let a = a else { return false }
    
    if a.val == b.val {
//        return nodeMatch(a: a.left, b: b.left) || nodeMatch(a: a.right, b: b.right)
        return nodeMatch(a: a.left, b: b.left) && nodeMatch(a: a.right, b: b.right)
    }
    return false
}

/*:
## 树的子结构解析

这道题需要使用两层递归，分别解决两个问题：

### 1. 外层：寻找候选根节点

`bIsSubTree` 遍历树 A 的所有节点，把每个节点都尝试作为树 B 的根节点：

```swift
return nodeMatch(a: aTree, b: bTree)
    || bIsSubTree(aTree: aTree.left, bTree: bTree)
    || bIsSubTree(aTree: aTree.right, bTree: bTree)
```

这里使用 `||`，因为只要当前节点、左子树或右子树中的任意一个位置能够匹配 B，结果就是 `true`。

### 2. 内层：匹配当前结构和值

`nodeMatch` 从一对候选节点开始，同时比较 A 和 B：

- `b == nil`：B 的结构已经匹配完，返回 `true`。
- `a == nil` 且 `b != nil`：A 没有节点可匹配，返回 `false`。
- 节点值不同：返回 `false`。
- 节点值相同：继续比较左右子树。

左右子树必须同时匹配，因此这里必须使用 `&&`：

```swift
return nodeMatch(a: a.left, b: b.left)
    && nodeMatch(a: a.right, b: b.right)
```

不能使用 `||`，否则只要左子树或右子树有一边匹配，就会错误地返回 `true`。

### 子结构和完整子树的区别

当 B 已经匹配结束时，A 还可以有额外节点。例如：

```text
A:        4
         / \
        1   2

B:        4
         /
        1
```

当匹配到 `B` 的空子树时返回 `true`，表示 B 的要求已经完成，A 多出的节点不影响结果。

但在外层函数中，如果传入的 B 本身为空，题目规定空树不是任意树的子结构，因此需要返回 `false`。

### 复杂度

设 A 有 `m` 个节点，B 有 `n` 个节点：

- 时间复杂度：最坏为 `O(m × n)`。
- 空间复杂度：`O(hA + hB)`，来自两层递归调用栈。
*/

//: [下一题](@next)
