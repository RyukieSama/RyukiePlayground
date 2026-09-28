//: [上一题](@previous)

/*:
# 68-I-二叉搜索树的最近公共祖先

## 题目

给定一个二叉搜索树, 找到该树中两个指定节点的最近公共祖先。

百度百科中最近公共祖先的定义为：“对于有根树 T 的两个结点 p、q，最近公共祖先表示为一个结点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”

例如，给定如下二叉搜索树:  root = [6,2,8,0,4,7,9,null,null,3,5]

## 用例 1

**输入：** root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8

**输出：** 6

解释: 节点 2 和节点 8 的最近公共祖先是 6。

## 用例 2

**输入：** root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4

**输出：** 2

解释: 节点 2 和节点 4 的最近公共祖先是 2, 因为根据定义最近公共祖先节点可以为节点本身。

## 说明

所有节点的值都是唯一的。

p、q 为不同节点且均存在于给定的二叉搜索树中。

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/er-cha-sou-suo-shu-de-zui-jin-gong-gong-zu-xian-lcof)
*/

func find(_ root: TreeNode, a: TreeNode, b: TreeNode) -> TreeNode {
    let rootInMid = (a.val < root.val && b.val > root.val)
    || (b.val < root.val && a.val > root.val)
    // 位于两边就是根节点。二叉搜索树的特征
    guard rootInMid == false else {
        return root
    }
    if a.val > root.val, b.val > root.val, let right = root.right {
        return find(right, a: a, b: b)
    }
    if a.val < root.val, b.val < root.val, let left = root.left {
        return find(left, a: a, b: b)
    }
    return root
}

/*:
## 题目解析

这道题的关键是利用二叉搜索树的有序性：

- 左子树中所有节点的值都小于根节点；
- 右子树中所有节点的值都大于根节点。

从当前节点 `root` 开始，根据 `a` 和 `b` 的值可以分为三种情况。

### 两个节点分别位于两侧

如果 `a.val < root.val < b.val`，或者 `b.val < root.val < a.val`，说明 `a` 和 `b` 从当前节点开始分别进入左、右子树。

当前节点是它们路径分开的位置，因此就是最近公共祖先。

### 两个节点位于同一侧

- 如果 `a.val` 和 `b.val` 都大于 `root.val`，最近公共祖先只可能在右子树中；
- 如果 `a.val` 和 `b.val` 都小于 `root.val`，最近公共祖先只可能在左子树中。

因此可以继续在对应的子树中递归查找。

### 当前节点等于其中一个目标节点

如果 `root` 就是 `a` 或 `b`，上面的“同时大于”和“同时小于”条件都不成立，代码最后会返回 `root`。

题目允许一个节点是它自己的祖先，所以这种情况下当前节点就是最近公共祖先。

### 复杂度

- 时间复杂度：`O(h)`，只会沿树中的一条路径查找，`h` 为树高；
- 空间复杂度：`O(h)`，递归调用栈最多保留 `h` 层。
*/


//: [下一题](@next)
