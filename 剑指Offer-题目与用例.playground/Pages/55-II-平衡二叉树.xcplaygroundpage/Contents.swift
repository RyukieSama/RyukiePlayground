//: [上一题](@previous)

/*:
# 55-II-平衡二叉树

## 题目

输入一棵二叉树的根节点，判断该树是不是平衡二叉树。如果某二叉树中任意节点的左右子树的深度相差不超过1，那么它就是一棵平衡二叉树。

## 用例 1

**输入：** `root = [3,9,20,null,null,15,7]`

**输出：** `true`

## 用例 2

**输入：** `root = [1,2,2,3,3,null,null,4,4]`

**输出：** `false`

## 约束

0 <= 树的结点个数 <= 10000

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/ping-heng-er-cha-shu-lcof)
*/

/**
 一次递归同时判断平衡和计算高度
 
 逻辑是：
 - 空节点高度为 0；
 - 子树不平衡时返回 -1；
 - 左子树返回 -1，立即结束；
 - 右子树返回 -1，立即结束；
 - 左右子树高度差超过 1，返回 -1；
 - 否则返回当前节点高度。
 
 例如：
 当前节点高度 = max(左子树高度, 右子树高度) + 1
 使用 -1 作为特殊标记，是因为正常树高不会是负数。

 复杂度：
 - 时间复杂度：O(n)，每个节点只访问一次；
 - 空间复杂度：O(h)，h 是树高。
 */
func isBalance2(_ tree: TreeNode?) -> Bool {
    return checkHeight(tree) != -1
}

func checkHeight(_ tree: TreeNode?) -> Int {
    guard let tree = tree else {
        return 0
    }
    
    let leftHeight = checkHeight(tree.left)
    if leftHeight == -1 {
        return -1
    }
    
    let rightHeight = checkHeight(tree.right)
    if rightHeight == -1 {
        return -1
    }
    
    if abs(leftHeight - rightHeight) > 1 {
        return -1
    }
    
    return max(leftHeight, rightHeight) + 1
}

/**
 - 正确性：当前版本正确；
 - 空树处理：已修复；
 - 性能：仍可优化，当前是 O(n²)；
 - 推荐方案：高度函数返回正常高度或 -1。
 */

func isBalance(_ tree: TreeNode?) -> Bool {
    guard let tree = tree else { return true }
    let left = deep(tree.left), right = deep(tree.right)
//    return abs(left - right) <= 1 // 注意任意子节点
    return abs(left - right) <= 1 && isBalance(tree.left) && isBalance(tree.right)
}

func deep(_ tree: TreeNode?) -> Int {
    guard let tree = tree else { return 0 }
    let leftD = deep(tree.left)
    let rightD = deep(tree.right)
    return max(leftD, rightD) + 1
}

//: [下一题](@next)
