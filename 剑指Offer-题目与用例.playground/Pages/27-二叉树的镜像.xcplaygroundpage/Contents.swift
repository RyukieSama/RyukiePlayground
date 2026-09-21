//: [上一题](@previous)

/*:
# 27-二叉树的镜像

## 题目

请完成一个函数，输入一个二叉树，该函数输出它的镜像。

例如输入：

4
/   \
2     7
/ \   / \
1   3 6   9
镜像输出：

4
/   \
7     2
/ \   / \
9   6 3   1

## 用例 1

**输入：** root = [4,2,7,1,3,6,9]
**输出：** [4,7,2,9,6,3,1]

## 约束

0 <= 节点个数 <= 1000

注意：本题与主站 226 题相同：https://leetcode-cn.com/problems/invert-binary-tree/

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/invert-binary-tree/)
*/

func mirror(tree: TreeNode?) -> TreeNode? {
    guard let tree = tree else { return nil }
    return TreeNode(tree.val, mirror(tree: tree.right), mirror(tree: tree.left))
}

/*:
## 二叉树镜像解析

### 镜像的定义

镜像操作需要保持每个节点的值不变，但交换它的左右子树：

```text
原节点的左子树 → 镜像节点的右子树
原节点的右子树 → 镜像节点的左子树
```

因此代码中必须写成：

```swift
TreeNode(
    tree.val,
    mirror(tree: tree.right),
    mirror(tree: tree.left)
)
```

不能把原来的左子树继续放在左边，否则得到的仍然是原树结构。

### 递归过程

以节点 `4` 为根为例：

```text
原树：       4                 镜像：       4
            / \                           / \
           2   7                         7   2
```

处理节点 `4` 时：

1. 递归处理原来的右子树 `7`，将它放到新树左侧。
2. 递归处理原来的左子树 `2`，将它放到新树右侧。
3. 对每个子节点重复相同过程。

### 终止条件

```swift
guard let tree = tree else {
    return nil
}
```

遇到空子树时返回 `nil`，保证叶子节点的左右子树也能正确构造。

### 当前实现的特点

当前 `mirror` 会创建一棵新的镜像树，不会修改原树。如果要求原地修改，可以交换原节点的 `left` 和 `right` 后继续递归。

### 复杂度

- 时间复杂度：`O(n)`，每个节点访问一次。
- 新建镜像树的空间复杂度：`O(n)`。
- 递归调用栈额外占用：`O(h)`，其中 `h` 是树的高度。
*/

//: [下一题](@next)
