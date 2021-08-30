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
