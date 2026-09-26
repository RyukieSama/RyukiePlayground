//: [上一题](@previous)

/*:
# 55-I-二叉树的深度

## 题目

输入一棵二叉树的根节点，求该树的深度。从根节点到叶节点依次经过的节点（含根、叶节点）形成树的一条路径，最长路径的长度为树的深度。

例如：

给定二叉树 [3,9,20,null,null,15,7]，

```
3
/ \
9  20
/  \
15   7
```

返回它的最大深度 3 。

## 提示

节点总数 <= 10000

## 用例

**输入：** `root = [3,9,20,null,null,15,7]`

**输出：** `3`

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/er-cha-shu-de-shen-du-lcof)
*/

//func deep(of tree: TreeNode?, val: inout Int) -> Int {
//    guard
//        let tree = tree
//    else {
//        return val
//    }
//    
//    val += 1
//    
//    if tree.left == nil, tree.right == nil {
//        return val
//    }
//    /**
//     left == nil  right == nil 就到叶子了，比较每个叶子的深度
//     */
//    val = max(deep(of: tree.left, val: &val), deep(of: tree.right, val: &val))
//    return val
//}

func deep(of tree: TreeNode?) -> Int {
    guard let tree = tree else {
        return 0
    }
    
    let leftDepth = deep(of: tree.left)
    let rightDepth = deep(of: tree.right)
    
    return max(leftDepth, rightDepth) + 1
}

/*:
## 题目解析

二叉树的深度是从根节点到最远叶节点经过的节点数量。

### 递归定义

对于任意节点：

`当前节点深度 = max(左子树深度, 右子树深度) + 1`

其中 `+1` 表示把当前节点本身计算进去。空节点深度为 `0`，因此叶子节点的深度自然是 `1`。

### 为什么不能共享深度变量

之前的写法使用 `inout val` 同时计算左右子树。遍历完左子树后，`val` 已经被修改，再进入右子树时会错误继承左子树的深度，使两棵子树互相影响。同一个 `inout` 变量同时传给两个表达式，也可能触发 Swift 的重叠访问限制。

当前写法分别获取：

`leftDepth = deep(tree.left)`

`rightDepth = deep(tree.right)`

然后返回两者较大值加一。每个递归调用都有独立的返回值，因此左右子树不会相互污染。

### 复杂度

- 时间复杂度：`O(n)`，每个节点只访问一次。
- 额外空间复杂度：`O(h)`，`h` 是树高，主要来自递归栈。
*/
//: [下一题](@next)
