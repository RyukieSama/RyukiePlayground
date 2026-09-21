//: [上一题](@previous)

/*:
# 28-对称的二叉树

## 题目

请实现一个函数，用来判断一棵二叉树是不是对称的。如果一棵二叉树和它的镜像一样，那么它是对称的。

例如，二叉树 [1,2,2,3,4,4,3] 是对称的。

1
/ \
2   2
/ \ / \
3  4 4  3
但是下面这个 [1,2,2,null,3,null,3] 则不是镜像对称的:

1
/ \
2   2
\   \
3    3

## 用例 1

**输入：** root = [1,2,2,3,4,4,3]
**输出：** true
## 用例 2

**输入：** root = [1,2,2,null,3,null,3]
**输出：** false

## 约束

0 <= 节点个数 <= 1000

注意：本题与主站 101 题相同：https://leetcode-cn.com/problems/symmetric-tree/

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/symmetric-tree/)
*/

func isDuicheng(tree: TreeNode?) -> Bool {
//    guard tree?.left?.val == tree?.right?.val else { // 这部分可简化掉
//        return false
//    }
    return isMirror(aTree: tree?.left, bTree: tree?.right)
}

func isMirror(aTree: TreeNode?, bTree: TreeNode?) -> Bool {
    guard
        let aTree = aTree,
        let bTree = bTree
    else {
        return aTree == nil && bTree == nil
    }
    
//    return aTree.val == bTree.val
//    && isMirror(aTree: aTree.left, bTree: bTree.left) // 错误，要交差比对，自己草稿比划一下
//    && isMirror(aTree: aTree.right, bTree: bTree.right)
    return aTree.val == bTree.val
    && isMirror(aTree: aTree.left, bTree: bTree.right)
    && isMirror(aTree: aTree.right, bTree: bTree.left)
}

/*:
## 对称二叉树解析

### 核心思路

一棵树对称，意味着根节点左、右两棵子树互为镜像。因此不能比较相同方向的子节点，而要交叉比较：

```text
A 的左子树 ↔ B 的右子树
A 的右子树 ↔ B 的左子树
```

对应代码：

```swift
isMirror(aTree: aTree.left, bTree: bTree.right)
&& isMirror(aTree: aTree.right, bTree: bTree.left)
```

### 递归判断规则

对于一对需要比较的节点：

1. 两个节点都为空：对称，返回 `true`。
2. 只有一个节点为空：结构不对称，返回 `false`。
3. 两个节点值不同：返回 `false`。
4. 值相同：继续交叉比较它们的左右子树。

```swift
guard let aTree, let bTree else {
    return aTree == nil && bTree == nil
}
```

### 示例

```text
    1
   / \
  2   2
 /     \
3       3
```

比较过程是：

```text
左树的左节点 3 ↔ 右树的右节点 3
左树的右节点 nil ↔ 右树的左节点 nil
```

两组都匹配，因此整棵树对称。

如果使用相同方向比较：

```swift
aTree.left ↔ bTree.left
aTree.right ↔ bTree.right
```

就无法判断镜像关系。

### 外层函数

外层只需要比较根节点的左右子树：

```swift
isMirror(aTree: tree?.left, bTree: tree?.right)
```

根节点本身不需要和自己比较，因为它天然位于对称轴上。

### 复杂度

- 时间复杂度：`O(n)`，每个节点最多访问一次。
- 空间复杂度：`O(h)`，来自递归栈，`h` 为树的高度。
*/

//: [下一题](@next)
