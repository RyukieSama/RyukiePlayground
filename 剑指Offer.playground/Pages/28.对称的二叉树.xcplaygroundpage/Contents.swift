//: [Previous](@previous)

/*:
 请实现一个函数，用来判断一棵二叉树是不是对称的。如果一棵二叉树和它的镜像一样，那么它是对称的。

 例如，二叉树 [1,2,2,3,4,4,3] 是对称的。

     1
    / \
   2   2
  / \ / \
 3  4 4  3
 但是下面这个 [1,2,2,null,3,null,3] 则不是镜像对称的:

     1
    / \
   2   2
    \   \
    3    3

  

 示例 1：

 输入：root = [1,2,2,3,4,4,3]
 输出：true
 示例 2：

 输入：root = [1,2,2,null,3,null,3]
 输出：false
  

 限制：

 0 <= 节点个数 <= 1000

 注意：本题与主站 101 题相同：https://leetcode-cn.com/problems/symmetric-tree/

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/dui-cheng-de-er-cha-shu-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

/**
 2023-02-06
 */
func isSymmetric2326(_ root: TreeNode?) -> Bool {
    return isLike(root?.left, root?.right)
}

func isLike(_ a: TreeNode?, _ b: TreeNode?) -> Bool {
    if a == nil && b == nil { return true }
    guard let aTree = a, let bTree = b, aTree.val == bTree.val else { return false }
    return isLike(aTree.left, bTree.right) && isLike(aTree.right, bTree.left)
}

func isSymmetric(_ root: TreeNode?) -> Bool {
    func compare(tree1: TreeNode?, tree2: TreeNode?) -> Bool {
        if tree1 == nil && tree2 == nil {
            return true
        }
        else if tree1 == nil || tree2 == nil {
            return false
        }
        else if tree1?.val != tree2?.val {
            return false
        }
        return compare(tree1: tree1?.left, tree2: tree2?.right) && compare(tree1: tree1?.right, tree2: tree2?.left)
    }
    
    return compare(tree1: root?.left, tree2: root?.right)
}

//: [Next](@next)
