//: [Previous](@previous)

import Foundation

/*:
 给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。

 百度百科中最近公共祖先的定义为：“对于有根树 T 的两个结点 p、q，最近公共祖先表示为一个结点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”

 例如，给定如下二叉树:  root = [3,5,1,6,2,0,8,null,null,7,4]

 示例 1:

 输入: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
 
 输出: 3
 
 解释: 节点 5 和节点 1 的最近公共祖先是节点 3。
 
 示例 2:

 输入: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
 
 输出: 5
 
 解释: 节点 5 和节点 4 的最近公共祖先是节点 5。因为根据定义最近公共祖先节点可以为节点本身。

 说明:

 所有节点的值都是唯一的。
 
 p、q 为不同节点且均存在于给定的二叉树中。

 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/er-cha-shu-de-zui-jin-gong-gong-zu-xian-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


/*:
 转化为找他们父节点的公共祖先，直到相等
 */
func lowestCommonAncestor(root: TreeNode?, pNode: TreeNode, qNode: TreeNode) -> TreeNode? {
    guard let root = root, root.val != pNode.val, root.val != qNode.val else {
        return root
    }
    
    let left = lowestCommonAncestor(root: root.left, pNode: pNode, qNode: qNode)
    let right = lowestCommonAncestor(root: root.right, pNode: pNode, qNode: qNode)
        
    if left == nil { return right }
    if right == nil { return left }
    return root
}

let node3 = TreeNode(3)
let node5 = TreeNode(5)
let node1 = TreeNode(1)
let node6 = TreeNode(6)
let node2 = TreeNode(2)
let node0 = TreeNode(0)
let node8 = TreeNode(3)
let node7 = TreeNode(7)
let node4 = TreeNode(4)

node3.left = node5
node3.right = node1

node5.left = node6
node5.right = node2
node1.left = node0
node1.right = node8

node2.left = node7
node2.right = node4

let res = lowestCommonAncestor(root: node3, pNode: node5, qNode: node4)
print(res?.val)

//: [Next](@next)
