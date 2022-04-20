//: [Previous](@previous)

import Foundation

/*:
 给定一个二叉搜索树, 找到该树中两个指定节点的最近公共祖先。
 
 百度百科中最近公共祖先的定义为：“对于有根树 T 的两个结点 p、q，最近公共祖先表示为一个结点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”
 
 例如，给定如下二叉搜索树:  root = [6,2,8,0,4,7,9,null,null,3,5]
 
 示例 1:
 
 输入: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
 
 输出: 6
 
 解释: 节点 2 和节点 8 的最近公共祖先是 6。
 
 示例 2:
 
 输入: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4
 
 输出: 2
 
 解释: 节点 2 和节点 4 的最近公共祖先是 2, 因为根据定义最近公共祖先节点可以为节点本身。
  
 说明:
 
 所有节点的值都是唯一的。
 
 p、q 为不同节点且均存在于给定的二叉搜索树中。
 
 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/er-cha-sou-suo-shu-de-zui-jin-gong-gong-zu-xian-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/*:
 官方没有Swift用例
 */
func lowestCommonAncestor(root: TreeNode, pNode: TreeNode, qNode: TreeNode) -> TreeNode {
    let minNode = pNode.val > qNode.val ? qNode : pNode
    let maxNode = pNode.val < qNode.val ? qNode : pNode
    guard
        !(minNode.val < root.val && maxNode.val > root.val),
        let oNode = maxNode.val > root.val ? root.right : root.left
    else {
        // 利用二叉搜索树的特性排除一些情况，分别在两侧的话公共先祖就是跟节点
        return root
    }
    
    return lowestCommonAncestor(root: oNode, pNode: pNode, qNode: qNode)
}

let node6 = TreeNode(6)

let node2 = TreeNode(2)
let node8 = TreeNode(8)

let node0 = TreeNode(0)
let node4 = TreeNode(4)
let node7 = TreeNode(7)
let node9 = TreeNode(9)

let node3 = TreeNode(3)
let node5 = TreeNode(5)

node6.left = node2
node6.right = node8

node2.left = node0
node2.right = node4

node8.left = node7
node8.right = node9

node4.left = node3
node4.right = node5

//let org = lowestCommonAncestor(root: node6, pNode: node3, qNode: node5)
//let org = lowestCommonAncestor(root: node6, pNode: node3, qNode: node5)
let org = lowestCommonAncestor(root: node6, pNode: node4, qNode: node9)
print(org.val)

//: [Next](@next)
