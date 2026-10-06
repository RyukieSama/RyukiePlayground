//: [上一题](@previous)

/*:
# 68-II-二叉树的最近公共祖先

## 题目

给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。

百度百科中最近公共祖先的定义为：“对于有根树 T 的两个结点 p、q，最近公共祖先表示为一个结点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”

例如，给定如下二叉树:  root = [3,5,1,6,2,0,8,null,null,7,4]

## 用例 1

**输入：** root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1

**输出：** 3

解释: 节点 5 和节点 1 的最近公共祖先是节点 3。

## 用例 2

**输入：** root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4

**输出：** 5

解释: 节点 5 和节点 4 的最近公共祖先是节点 5。因为根据定义最近公共祖先节点可以为节点本身。

## 说明

所有节点的值都是唯一的。

p、q 为不同节点且均存在于给定的二叉树中。

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/er-cha-shu-de-zui-jin-gong-gong-zu-xian-lcof)
*/
import Foundation

func find202601006(_ root: TreeNode, a: TreeNode, b: TreeNode) -> TreeNode? {
    if root == a || root == b { return root }
    
    var leftResult: TreeNode?, rightResult: TreeNode?
    
    if let left = root.left {
        leftResult = find202601006(left, a: a, b: b)
    }
    
    if let right = root.right {
        rightResult = find202601006(right, a: a, b: b)
    }
    
    if let _ = leftResult, let _ = rightResult {
        return root // 说明分别在两边
    }
    
    return leftResult ?? rightResult
}


func find(_ root: TreeNode, a: TreeNode, b: TreeNode) -> TreeNode? {
    // 当前节点就是目标节点之一时，向上返回当前节点。
    if root == a || root == b {
        return root
    }

    let leftResult = root.left.flatMap {
        find($0, a: a, b: b)
    }

    let rightResult = root.right.flatMap {
        find($0, a: a, b: b)
    }

    // 左右子树分别找到目标节点，当前节点就是路径交汇点。
    if leftResult != nil, rightResult != nil {
        return root
    }

    // 只有一侧找到结果时，继续向上层传递。
    return leftResult ?? rightResult
}

/*:
## 题目解析

这是一棵普通二叉树，不能像 68-I 一样根据节点值判断搜索方向，因此需要分别在左、右子树中查找目标节点。

### 递归返回值的含义

`find` 的返回值表示当前子树的查找结果：

- 返回 `nil`：当前子树中没有找到目标节点；
- 返回 `a` 或 `b`：当前子树中找到了其中一个目标节点；
- 返回其他节点：该节点已经是 `a` 和 `b` 的最近公共祖先。

### 当前节点是目标节点

如果 `root` 等于 `a` 或 `b`，直接返回 `root`。

题目允许一个节点是它自己的祖先。因此，如果另一个目标节点位于当前节点的子树中，当前节点就是最近公共祖先。

### 分别查找左右子树

`root.left` 和 `root.right` 都是可选值。`flatMap` 表示：子节点存在时才递归调用 `find`，子节点不存在时直接得到 `nil`。

```swift
let leftResult = root.left.flatMap {
    find($0, a: a, b: b)
}
```

它等价于：

```swift
let leftResult: TreeNode?
if let leftNode = root.left {
    leftResult = find(leftNode, a: a, b: b)
} else {
    leftResult = nil
}
```

### 根据左右子树的结果作出判断

- 左右子树都返回非空结果：`a` 和 `b` 分别位于两侧，当前节点是它们路径的交汇点，因此返回 `root`；
- 只有一侧返回非空结果：目标节点或已找到的最近公共祖先位于该侧，继续向上传递；
- 两侧都返回 `nil`：当前子树不包含任何目标节点，返回 `nil`。

`leftResult ?? rightResult` 会优先返回非空的一侧；如果两侧都为空，结果也是 `nil`。

### 复杂度

- 时间复杂度：`O(n)`，最坏情况下需要访问所有节点；
- 空间复杂度：`O(h)`，递归调用栈的深度取决于树高 `h`。
*/

//: [下一题](@next)
