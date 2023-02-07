//: [Previous](@previous)

import Foundation

/*:
 输入两棵二叉树A和B，判断B是不是A的子结构。(约定空树不是任意一个树的子结构)

 B是A的子结构， 即 A中有出现和B相同的结构和节点值。

 例如:
 
 ***给定的树 A:***

```
      3
     / \
    4   5
   / \
  1   2
```
 
 ***给定的树 B：***

```
    4
   /
  1
```
 
返回 true，因为 B 与 A 的一个子树拥有相同的结构和节点值。

 ***示例 1：***

* 输入：A = [1,2,3], B = [3,1]
* 输出：false

***示例 2：***

* 输入：A = [3,4,5,1,2], B = [4,1]
* 输出：true

***限制：***

0 <= 节点个数 <= 10000

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/shu-de-zi-jie-gou-lcof
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/**
 2023-02-07
 */
func isSubStructure2327(_ A: TreeNode?, _ B: TreeNode?) -> Bool {
    guard let treeA = A, let treeB = B else {
        return false
    }
    var res = false
    if res {
//        res = match2327(treeA.left, treeB.left) && match2327(treeA.right, treeB.right)
        res = match2327(treeA, treeB)
    }
    
    if res == false {
        /**
         看 A 的左是否包含B ｜｜ A 的右是否包含 B
         */
        res = isSubStructure2327(treeA.left, treeB) || isSubStructure2327(treeA.right, treeB)
    }
    return res
}

/**
 根节点相等  && （a 的左子 包含 B左子树  ||  a 的右子树包含B右子树）
 */
func match2327(_ A: TreeNode?, _ B: TreeNode?) -> Bool {
    if B == nil {
        return true
    }
    guard let treeA = A, let treeB = B, treeA.val == treeB.val else {
        return false
    }
    return match2327(treeA.left, treeB.left) && match2327(treeA.right, treeB.right)
}

/**
 2023-02-06
 */
func isSubStructure2326(_ A: TreeNode?, _ B: TreeNode?) -> Bool {
    var result = false
    guard let aTree = A, let bTree = B else { return result }
    /**
     先把 B 完整遍历次，得到遍历结果
     */
    if aTree.val == bTree.val {// 找到合适的根节点，再比较子树
        result = hasTree(aTree, bTree)
    }
    
    if !result {// 如果已经包含了，就不用再对比了
        result = isSubStructure2326(aTree.left, bTree) || isSubStructure2326(aTree.right, bTree)
    }
    
    return result
}

func hasTree(_ A: TreeNode?, _ B: TreeNode?) -> Bool {
    if B == nil { return true }// 相同根节点情况下对比左右树，如果相同 B == nil 了那么就是和 B 对比完了，也就是前面都相同
    guard let aTree = A, let bTree = B, aTree.val == bTree.val else { return false }
    return hasTree(aTree.left, bTree.left) && hasTree(aTree.right, bTree.right)
}

// ====
func isSubStructure(_ A: TreeNode?, _ B: TreeNode?) -> Bool {
    guard let treeA = A, let treeB = B else { return false }
    return (isContain(A, treeB) || isSubStructure(treeA.left, treeB) || isSubStructure(treeA.right, treeB))
}

func isContain(_ A: TreeNode?, _ B: TreeNode?) -> Bool {
    if B == nil {
        return true // B遍历完了 不论A还有没有 A已经包含了A了
    }
    if A == nil {
        return false // A遍历完了 B还有 肯定不包含
    }
    
    guard let treeA = A, let treeB = B, treeA.val == treeB.val else { return false }
    
    return isContain(treeA.left, treeB.left) && isContain(treeA.right, treeB.right)
}
//: [Next](@next)
