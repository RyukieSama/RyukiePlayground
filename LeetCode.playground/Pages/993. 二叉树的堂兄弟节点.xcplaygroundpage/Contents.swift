//: [Previous](@previous)

import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}


/*:
 在二叉树中，根节点位于深度 0 处，每个深度为 k 的节点的子节点位于深度 k+1 处。

 如果二叉树的两个节点深度相同，但 父节点不同 ，则它们是一对堂兄弟节点。

 我们给出了具有唯一值的二叉树的根节点 root ，以及树中两个不同节点的值 x 和 y 。

 只有与值 x 和 y 对应的节点是堂兄弟节点时，才返回 true 。否则，返回 false。

  

 示例 1：


 输入：root = [1,2,3,4], x = 4, y = 3
 输出：false
 示例 2：


 输入：root = [1,2,3,null,4,null,5], x = 5, y = 4
 输出：true
 示例 3：



 输入：root = [1,2,3,null,4], x = 2, y = 3
 输出：false
  

 提示：

 二叉树的节点数介于 2 到 100 之间。
 每个节点的值都是唯一的、范围为 1 到 100 的整数。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/cousins-in-binary-tree
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

class Solution {
    func isCousins(_ root: TreeNode?, _ x: Int, _ y: Int) -> Bool {
        func dfs(_ root: TreeNode?, _ depth: Int, _ num: Int, _ parent: Int) -> (Int, Int)? {
            guard let root = root else { return nil }
            if num == root.val { return (depth, parent) }
            return dfs(root.left, depth + 1, num, root.val) ?? dfs(root.right, depth + 1, num, root.val)
        }
        let x = dfs(root, 0, x, 0)!, y = dfs(root, 0, y, 0)!
        return x.0 == y.0 && x.1 != y.1
    }
}

//: [Next](@next)
