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

/**
 2023-03-04
 */
func isBalanced230304(_ root: TreeNode?) -> Bool {
    guard let root = root else {
        return true
    }
    
    func deep(_ tree: TreeNode?) -> Int {
        guard let tree = tree else {
            return 0
        }
        return 1 + max(deep(tree.left), deep(tree.right))
    }
    
    return abs(deep(root.left) - deep(root.right)) <= 1 && isBalanced230304(root.left) && isBalanced230304(root.right)
}

/**
 2023-02-12
 */
func isBalanced23212(_ root: TreeNode?) -> Bool {
    guard let root = root else {
        return true
    }
    
    var deepMatch = false
    if abs(treeDeep(root.left) - treeDeep(root.right)) <= 1 {
        deepMatch = true
    }
    else {
        return false
    }
    
    return deepMatch && isBalanced23212(root.left) && isBalanced23212(root.right)
}

func treeDeep(_ root: TreeNode?) -> Int {
    guard let root = root else {
        return 0
    }
    var queue: [TreeNode] = [root]
    var deep = 0
    var currentLineLeftCount = 1
    var nextLineCount = 0
    
    while let node = queue.first {
        queue.removeFirst()
        currentLineLeftCount -= 1
        
        if let left = node.left {
            queue.append(left)
            nextLineCount += 1
        }
        
        if let right = node.right {
            queue.append(right)
            nextLineCount += 1
        }
        
        if currentLineLeftCount == 0 {
            currentLineLeftCount = nextLineCount
            nextLineCount = 0
            deep += 1
        }
        
    }
    
    return deep
}
isBalanced23212(root1)
isBalanced23212(root2)
isBalanced23212(root3)


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

isBalanced(root1)
isBalanced(root2)
isBalanced(root3)

//maxDepth(root3.left?.left)
//maxDepth(root3.left?.right)

//: [Next](@next)
