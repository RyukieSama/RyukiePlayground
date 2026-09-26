//: [上一题](@previous)

/*:
# 54-二叉搜索树的第k大节点

## 题目

给定一棵二叉搜索树，请找出其中第 k 大的节点的值。

## 用例 1

**输入：** root = [3,1,4,null,2], k = 1

```
3
/ \
1   4
\
2
```

**输出：** 4

## 用例 2

**输入：** root = [5,3,6,2,4,null,null,1], k = 3

```
5
/ \
3   6
/ \
2   4
/
1
```

**输出：** 4

## 约束

1 ≤ k ≤ 二叉搜索树元素个数

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/er-cha-sou-suo-shu-de-di-kda-jie-dian-lcof)
*/

//func find(k: Int, in tree: TreeNode?) -> TreeNode? {
//    guard let tree = tree else { return nil }
//    // 二叉搜索树中序遍历的结果就是有序的 左 中 右
//    var res: [TreeNode] = []
//    ino(tree: tree, res: &res)
//    return k < res.count ? res[k] : nil // // 额 写成 第 K 小的了
//}
//
//func ino(tree: TreeNode, res: inout [TreeNode]) -> [TreeNode] {
//    if let left = tree.left {
//        ino(tree: left, res: &res)
//    }
//    res.append(tree)
//    if let right = tree.right {
//        ino(tree: right, res: &res)
//    }
//    return res
//}

func find(k: Int, in tree: TreeNode?) -> TreeNode? {
    guard let tree = tree else { return nil }
    // 二叉搜索树中序遍历的结果就是有序的 左 中 右，这里需要倒序 右 中 左
    var res: [TreeNode] = []
    reIno(tree: tree, res: &res)
    return (k - 1 < res.count && k - 1 >= 0) ? res[k-1] : nil
}

func reIno(tree: TreeNode, res: inout [TreeNode]) {
    if let right = tree.right {
        reIno(tree: right, res: &res)
    }
    
    res.append(tree)
    
    if let left = tree.left {
        reIno(tree: left, res: &res)
    }
}

/*:
## 题目解析

二叉搜索树满足：

- 左子树中的值都小于当前节点；
- 右子树中的值都大于当前节点。

普通中序遍历的顺序是：

`左子树 → 当前节点 → 右子树`

得到的是从小到大的序列。题目要求第 `k` 大，因此使用逆中序遍历：

`右子树 → 当前节点 → 左子树`

这样访问到的节点顺序就是从大到小。`reIno` 正是按照这个顺序递归，因此 `res[0]` 是最大节点。

### 为什么使用 `k - 1`

题目中的 `k` 从 `1` 开始计数，而数组下标从 `0` 开始：

- 第 1 大节点对应 `res[0]`；
- 第 2 大节点对应 `res[1]`；
- 第 `k` 大节点对应 `res[k - 1]`。

因此需要返回：

`res[k - 1]`

同时要保证 `k > 0` 且 `k <= res.count`，避免非法下标。

### 当前实现

当前实现先将逆中序结果保存到数组，再根据下标取出第 `k` 个节点。逻辑是正确的。若题目要求返回节点值，可以取：

`res[k - 1].val`

### 复杂度

- 时间复杂度：`O(n)`，最坏情况下需要遍历整棵树。
- 额外空间复杂度：`O(n)`，用于保存遍历结果。

也可以在逆中序遍历过程中使用计数器，找到第 `k` 个节点后立即停止，将额外空间降到递归栈的 `O(h)`。
*/
//: [下一题](@next)
