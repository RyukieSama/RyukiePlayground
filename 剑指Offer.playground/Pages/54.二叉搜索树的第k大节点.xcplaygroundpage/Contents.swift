//: [Previous](@previous)

import Foundation

/*:
 给定一棵二叉搜索树，请找出其中第 k 大的节点的值。
 
 示例 1:
 
 输入: root = [3,1,4,null,2], k = 1
 
 ```
 3
 / \
 1   4
 \
    2
 ```
 
 输出: 4
 
 示例 2:
 
 输入: root = [5,3,6,2,4,null,null,1], k = 3
 
 ```
 5
 / \
 3   6
 / \
 2   4
 /
 1
 ```
 
 输出: 4
  
 限制：
 
 1 ≤ k ≤ 二叉搜索树元素个数
 
 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/er-cha-sou-suo-shu-de-di-kda-jie-dian-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
let node = TreeNode(5,
                    TreeNode(3,
                             TreeNode(2,
                                      TreeNode(1),
                                      nil),
                             TreeNode(4,
                                      nil,
                                      nil)),
                    TreeNode(6,
                             nil,
                             nil))

/**
 2023-02-11
 */
func kthLargest23211(_ root: TreeNode?, _ k: Int) -> Int {
    /**
     根据二叉搜索树的特性 左 > 根 > 右
     中序遍历： 左 中 右
     */
    var arr: [Int] = []
    
    func midOrder(_ node: TreeNode?) {
        guard let val = node?.val else { return }
        midOrder(node?.left)
        arr.append(val)
        midOrder(node?.right)
    }
    midOrder(root)

    guard arr.count - k < arr.count, arr.count - k >= 0 else {
        return 0
    }
    return arr[arr.count - k]
}

kthLargest23211(node, 3)




func kthLargest(_ root: TreeNode?, _ k: Int) -> Int {
    var inorderArr: [Int] = []
    
    func inorder(_ node: TreeNode?) {
        guard let n = node else {
            return
        }
        
        inorder(n.right)
        inorderArr.append(n.val)
        inorder(n.left)
    }
    
    inorder(root)
    
    return inorderArr[k - 1]
}



kthLargest(node, 3)

//: [Next](@next)
