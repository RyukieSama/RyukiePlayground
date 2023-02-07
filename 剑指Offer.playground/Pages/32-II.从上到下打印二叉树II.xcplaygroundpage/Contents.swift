//: [Previous](@previous)

import Foundation

/*:
 从上到下按层打印二叉树，同一层的节点按从左到右的顺序打印，每一层打印到一行。

 例如:
 
 给定二叉树: [3,9,20,null,null,15,7],

     3
    / \
   9  20
     /  \
    15   7
 返回其层次遍历结果：

 [
   [3],
   [9,20],
   [15,7]
 ]
  

 提示：

 节点总数 <= 1000
 注意：本题与主站 102 题相同：https://leetcode-cn.com/problems/binary-tree-level-order-traversal/



 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/cong-shang-dao-xia-da-yin-er-cha-shu-ii-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/**
 2023-02-07
 
 不难，要细心
 */
func levelOrder2327(_ root: TreeNode?) -> [[Int]] {
    var res: [[Int]] = []
    guard let root = root else { return res }
    var queue: [TreeNode] = [root]
    var tempArr: [Int] = []
    // 当前层剩余个数
    var leftCount = 1
    // 下一行个数
    var nextCount = 0
    
    while let top = queue.first {
        tempArr.append(top.val)
        leftCount -= 1
        
        if let left = top.left {
            queue.append(left)
            nextCount += 1
        }
        
        if let right = top.right {
            queue.append(right)
            nextCount += 1
        }
        
        if leftCount == 0 {
            leftCount = nextCount
            nextCount = 0
            if tempArr.isEmpty == false {
                res.append(tempArr)
                tempArr = []
            }
        }
        
        queue.removeFirst()
    }
    
    if tempArr.isEmpty == false {
        res.append(tempArr)
    }
    
    return res
}


func levelOrder(_ root: TreeNode?) -> [[Int]] {
    var queue: [TreeNode] = []
    // 当前行需要打印的
    var toBePrint = 0
    // 下一行需要打印的
    var nextLevelCount = 0
    var result: [[Int]] = []
    var temp: [Int] = []
    
    if let r = root {
        queue.append(r)
        toBePrint += 1
    }

    while queue.isEmpty == false {
        if let first = queue.first {
            temp.append(first.val)
            queue.removeFirst()
            toBePrint -= 1
            
            if let left = first.left {
                queue.append(left)
                nextLevelCount += 1
            }
            
            if let right = first.right {
                queue.append(right)
                nextLevelCount += 1
            }
            
            if toBePrint == 0 {
                result.append(temp)
                temp = []
                
                toBePrint = nextLevelCount
                nextLevelCount = 0
            }
        }
    }
    
    if temp.isEmpty == false {
        result.append(temp)
    }
    
    return result
}

//: [Next](@next)
