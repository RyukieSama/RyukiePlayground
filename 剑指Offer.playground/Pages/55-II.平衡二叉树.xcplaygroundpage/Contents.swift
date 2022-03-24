//: [Previous](@previous)

import Foundation

/*:
 输入一棵二叉树的根节点，判断该树是不是平衡二叉树。如果某二叉树中任意节点的左右子树的深度相差不超过1，那么它就是一棵平衡二叉树。
  
 示例 1:

 给定二叉树 [3,9,20,null,null,15,7]

 ```
     3
    / \
   9  20
     /  \
    15   7
 ```
 
 返回 true 。

 示例 2:

 给定二叉树 [1,2,2,3,3,null,null,4,4]

 ```
        1
       / \
      2   2
     / \
    3   3
   / \
  4   4
 ```
 
 返回 false 。

 限制：

 0 <= 树的结点个数 <= 10000

 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/ping-heng-er-cha-shu-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

func isBalanced(_ root: TreeNode?) -> Bool {
    let deepL = maxDepth(root?.left)
    let deepR = maxDepth(root?.right)
//    print("左：\(deepL)右：\(deepR)")
    if (deepL == 0 && deepR == 0) {
        return true
    }
    if (abs(deepL - deepR) > 1) {
        return false
    }
    return (isBalanced(root?.left) && isBalanced(root?.right))
}

func maxDepth(_ root: TreeNode?) -> Int {
    var deep = 0
    guard let root = root else { return deep }
    var queue: [TreeNode] = [root]
    var currentLevelCount = 1
    var nextLevelCount = 0
    
    while queue.isEmpty == false {
        let current = queue.removeFirst()
        currentLevelCount -= 1
        
        if let left = current.left {
            queue.append(left)
            nextLevelCount += 1
        }
        
        if let right = current.right {
            queue.append(right)
            nextLevelCount += 1
        }
        
        if currentLevelCount == 0 {
            deep += 1
            currentLevelCount = nextLevelCount
            nextLevelCount = 0
        }
    }
    
    return deep
}

let root1 = TreeNode(1,
                    TreeNode(2,
                             TreeNode(3,
                                      TreeNode(4),
                                      TreeNode(4)),
                             TreeNode(3)),
                    TreeNode(2))

let root2 = TreeNode(3,
                    TreeNode(9),
                    TreeNode(20,
                             TreeNode(15),
                             TreeNode(7)))

// [1,2,2,3,null,null,3,4,null,null,4]
let root3 = TreeNode(1,
                     TreeNode(2,
                              TreeNode(3,
                                       TreeNode(4),
                                       nil),
                              nil),
                     TreeNode(2,
                              nil,
                              TreeNode(3,
                                       nil,
                                       TreeNode(4))))

isBalanced(root1)
isBalanced(root2)
isBalanced(root3)

//maxDepth(root3.left?.left)
//maxDepth(root3.left?.right)

//: [Next](@next)
