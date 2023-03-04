//: [Previous](@previous)

import Foundation

/*:
 从上到下打印出二叉树的每个节点，同一层的节点按照从左到右的顺序打印。

 例如:
 
 给定二叉树: [3,9,20,null,null,15,7],

 ```
     3
    / \
   9  20
     /  \
    15   7
 ```
 
返回：

[3,9,20,15,7]
 
提示：

节点总数 <= 1000

来源：[力扣（LeetCode）](https://leetcode-cn.com/problems/cong-shang-dao-xia-da-yin-er-cha-shu-lcof)

 */

/**
 2023-03-03
 */
func levelOrder230303(_ root: TreeNode?) -> [Int] {
    var res: [Int] = []
    var queue: [TreeNode] = []
    if let root = root {
        queue.append(root)
    }
    
    while let node = queue.first {
        queue.removeFirst()
        res.append(node.val)
        
        if let left = node.left {
            queue.append(left)
        }
        
        if let right = node.right {
            queue.append(right)
        }
    }
    
    return res
}

/**
 2023-02-08
 */
func levelOrder2308(_ root: TreeNode?) -> [Int] {
    var res: [Int] = []
    guard let root = root else { return res }
    var queue: [TreeNode] = [root]
    
    while let top = queue.first {
        res.append(top.val)
        queue.removeFirst()
        
        if let left = top.left {
            queue.append(left)
        }
        
        if let right = top.right {
            queue.append(right)
        }
    }
    
    return res
}



/**
 2023-02-07
 */
func levelOrder2327(_ root: TreeNode?) -> [Int] {
    var res: [Int] = []
    guard let root = root else { return res }
    
    var queue: [TreeNode] = [root]
    
    while let first = queue.first {
        res.append(first.val)
        queue.removeFirst()
        if let fl = first.left {
            queue.append(fl)
        }
        
        if let fr = first.right {
            queue.append(fr)
        }
    }
    
    return res
}


func levelOrder(_ root: TreeNode?) -> [Int] {
    guard let r = root else { return [] }
    var result: [Int] = []
    var queue: [TreeNode] = [r]
    
    while queue.isEmpty == false {
        let first = queue[0]
        result.append(first.val)
        
        if let left = first.left {
            queue.append(left)
        }
        
        if let right = first.right {
            queue.append(right)
        }
        
        queue.removeFirst()
    }
        
    return result
}

//: [Next](@next)
