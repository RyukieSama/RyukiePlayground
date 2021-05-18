//: [Previous](@previous)

import Foundation

/*:
 请考虑一棵二叉树上所有的叶子，这些叶子的值按从左到右的顺序排列形成一个 叶值序列 。
 
 
 
 举个例子，如上图所示，给定一棵叶值序列为 (6, 7, 4, 9, 8) 的树。
 
 如果有两棵二叉树的叶值序列是相同，那么我们就认为它们是 叶相似 的。
 
 如果给定的两个根结点分别为 root1 和 root2 的树是叶相似的，则返回 true；否则返回 false 。
 
  
 
 示例 1：
 
 
 
 输入：root1 = [3,5,1,6,2,9,8,null,null,7,4], root2 = [3,5,1,6,7,4,2,null,null,null,null,null,null,9,8]
 输出：true
 示例 2：
 
 输入：root1 = [1], root2 = [1]
 输出：true
 示例 3：
 
 输入：root1 = [1], root2 = [2]
 输出：false
 示例 4：
 
 输入：root1 = [1,2], root2 = [2,2]
 输出：true
 示例 5：
 
 
 
 输入：root1 = [1,2,3], root2 = [1,3,2]
 输出：false
  
 
 提示：
 
 给定的两棵树可能会有 1 到 200 个结点。
 给定的两棵树上的值介于 0 到 200 之间。
 
 
 链接：https://leetcode-cn.com/problems/leaf-similar-trees
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

//: [Next](@next)

// MARK: - 错了
//func leafSimilar(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
//    return leafs(tree: root1) == leafs(tree: root2)
//}
//
//func buildTree(_ leafs: [Int?]) -> TreeNode? {
//    print(leafs)
//    if let first = leafs.first as? Int {
//        let root = TreeNode.init(first)
//        root.left = buildTree(Array(leafs[1..<leafs.count]))
//        root.right = buildTree(Array(leafs[2..<leafs.count]))
//        return root
//    }
//    return nil
//}
//
//func leafs(tree: TreeNode?) -> String {
//    var leafString = ""
//    var left: TreeNode? = tree?.left
//    var right: TreeNode? = tree?.right
//    while left != nil || right != nil {
//        left = tree?.left
//        right = tree?.right
//
//        if left == nil, right == nil, let rootValue = tree?.val {
//            leafString.append("\(rootValue)-")
//        }
//    }
//
//    print(leafString)
//    return leafString
//}

// MARK: - Answer
func leafArr(_ root: TreeNode?) -> [Int] { // 拿到1个节点的两个叶子  = 拿到一个二叉树的所有叶子
    guard let root = root else {return []}
    if (root.left == nil && root.right == nil) {  // 如果当前树左右叶子都为空 返回本身
        return [root.val]
    }
    return leafArr(root.left) + leafArr(root.right) //将所有叶子拼接成一个目标节点数组
}

func leafSimilar(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
    return leafArr(root1) == leafArr(root2)
}

let root1 = [3,5,1,6,2,9,8,nil,nil,7,4], root2 = [3,5,1,6,7,4,2,nil,nil,nil,nil,nil,nil,9,8]

//let tree1 = buildTree(root1)
//let tree2 = buildTree(root2)
//
//leafSimilar(tree1, tree2)

//leafSimilar(root1, root2)
