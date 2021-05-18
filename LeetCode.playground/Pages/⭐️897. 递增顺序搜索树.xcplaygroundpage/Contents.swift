//: [Previous](@previous)

import Foundation

/*:
 
 给你一棵二叉搜索树，请你 按中序遍历 将其重新排列为一棵递增顺序搜索树，使树中最左边的节点成为树的根节点，并且每个节点没有左子节点，只有一个右子节点。
 
  
 
 示例 1：
 
 
 输入：root = [5,3,6,2,4,null,8,1,null,null,null,7,9]
 输出：[1,null,2,null,3,null,4,null,5,null,6,null,7,null,8,null,9]
 示例 2：
 
 
 输入：root = [5,1,7]
 输出：[1,null,5,null,7]
  
 
 提示：
 
 树中节点数的取值范围是 [1, 100]
 0 <= Node.val <= 1000
 
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/increasing-order-search-tree
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */

func increasingBSTMy(_ root: TreeNode?) -> TreeNode? {
    var temp: [Int] = []
    
    func inorder(_ root: TreeNode?) {
        guard let rt = root else {
            return
        }
        inorder(rt.left)
        temp.append(rt.val)
        inorder(rt.right)
    }
    
    inorder(root)
    
    var head: TreeNode?
    var lastNode: TreeNode?
    
    var level = 0
    while level < temp.count {
        let node = TreeNode.init(temp[level])
        if let rt = lastNode {
            rt.right = node
        }
        else {
            head = node
        }
        lastNode = node
        
        level += 1
    }
    
    return head
}

func increasingBST(_ root: TreeNode?) -> TreeNode? {
    var temp: [Int] = []
    
    func inorder(_ root: TreeNode?) {
        guard let rt = root else {
            return
        }
        inorder(rt.left)
//        print("\(rt.val)")
        temp.append(rt.val)
        inorder(rt.right)
    }
    
    inorder(root)
    
    let head = TreeNode()
    var lastNode: TreeNode?
    
    var level = 0
    while level < temp.count {
        let node = TreeNode.init(temp[level])
        if let rt = lastNode {
            rt.right = node
        }
        else {
            head.right = node
        }
        lastNode = node
        
        level += 1
    }
    
    return head.right
}

let root = TreeNode(5,
                    TreeNode(3,
                             TreeNode(2,
                                      TreeNode(1, nil, nil),
                                      nil),
                             TreeNode(4, nil, nil)),
                    TreeNode(6,
                             nil,
                             TreeNode(8,
                                      TreeNode(7, nil, nil),
                                      TreeNode(9, nil, nil))))

increasingBST(root)

increasingBSTMy(root)

//: [Next](@next)
