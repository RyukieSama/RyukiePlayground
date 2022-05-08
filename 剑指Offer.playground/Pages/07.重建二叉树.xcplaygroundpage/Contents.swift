//: [Previous](@previous)

/*:
 输入某二叉树的前序遍历和中序遍历的结果，请重建该二叉树。假设输入的前序遍历和中序遍历的结果中都不含重复的数字。
 
 例如，给出
 
 前序遍历 preorder = [3,9,20,15,7]
 
 中序遍历 inorder = [9,3,15,20,7]
 
 返回如下的二叉树：
 
 ```
 3
 / \
 9  20
     /  \
     15   7
 ```
 
 限制：
 
 0 <= 节点个数 <= 5000
 
 链接：https://leetcode-cn.com/problems/zhong-jian-er-cha-shu-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

let preorder = [3,9,20,15,7]

let inorder = [9,3,15,20,7]

func buildTreeA(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
    guard preorder.isEmpty == false, inorder.isEmpty == false else {
        return nil
    }
    
    let root = TreeNode(preorder[0], nil, nil)
    
    /**
     对中序的进行遍历，寻找根结点在其中的位置
     从而划分左右中序遍历结果
     */
    for (idx, node) in inorder.enumerated() {
        if node == preorder[0] { // 找到根结点
            root.left = buildTreeA(
                Array(preorder[1..<idx+1]),// 根结点在中序中的下标可以算出其 左子树的元素数量
                Array(inorder[0..<idx]))
            root.right = buildTreeA(
                Array(preorder[idx+1..<preorder.endIndex]),// 根结点在中序中的下标可以算出其 右子树的元素数量
                Array(inorder[idx+1..<inorder.endIndex]))
        }
    }
    
    return root
}

func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
    if preorder.count == 0 || inorder.count == 0 {
        return nil
    }
    
    //构建二叉树根结点
    let root: TreeNode? = TreeNode.init(preorder[0])
    
    //对中序序列进行遍历
    for (index, num) in inorder.enumerated() {
        // 如果找到根节点
        if num == preorder[0] {
            root?.left = buildTree(
                Array(preorder[1..<index+1]),
                Array(inorder[0..<index])
            )
            root?.right = buildTree(
                Array(preorder[index+1..<preorder.endIndex]),
                Array(inorder[index+1..<inorder.endIndex])
            )
        }
    }
    
    return root
}

buildTree(preorder, inorder)
buildTreeA(preorder, inorder)

//: [Next](@next)
