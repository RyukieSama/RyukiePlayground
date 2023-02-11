//: [Previous](@previous)

import Foundation

/*:
输入一棵二叉树的根节点，求该树的深度。从根节点到叶节点依次经过的节点（含根、叶节点）形成树的一条路径，最长路径的长度为树的深度。

例如：

给定二叉树 [3,9,20,null,null,15,7]，

```
     3
    / \
   9  20
     /  \
    15   7
```

返回它的最大深度 3 。

提示：

节点总数 <= 10000

来源：力扣（LeetCode）

链接：https://leetcode-cn.com/problems/er-cha-shu-de-shen-du-lcof

著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
let tree = TreeNode(3,
                    TreeNode(9),
                    TreeNode(20,
                             TreeNode(15),
                             TreeNode(7)))


/**
 2023-02-11
 一：递归
 */
func maxDepth23211(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    /**
     递归：
     等于左、右树中最大深度 + 1
     */
    if root.left == nil, root.right == nil {
        return 1
    }
    return 1 + max(maxDepth23211(root.left), maxDepth23211(root.right))
}

/**
 2023-02-11
 二：非递归
 */
func maxDepth232112(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    var deep = 0
    /**
     思考：
     类似于以前那种花式遍历二叉树，用辅助队列
     一行一行那种输出模式的
     等价于那一题最后的数组元素有几个
     */
    var queue: [TreeNode] = [root]
    var currentLevelLeftCount = 1
    var nextLevelCount = 0
    
    while let node = queue.first {
        queue.removeFirst()
        currentLevelLeftCount -= 1
        
        if let left = node.left {
            queue.append(left)
            nextLevelCount += 1
        }
        
        if let right = node.right {
            queue.append(right)
            nextLevelCount += 1
        }
        
        if currentLevelLeftCount == 0 { // 该换行了
            deep += 1
            currentLevelLeftCount = nextLevelCount
            nextLevelCount = 0
        }
    }
    
    return deep
}
maxDepth232112(tree)


func maxDepth(_ root: TreeNode?) -> Int {
    guard let tree = root else { return 0 }
    if tree.left == nil, tree.right == nil { return 1 }
    return max(maxDepth(tree.left), maxDepth(tree.right)) + 1
}

/// 非递归
func maxDepth1(_ root: TreeNode?) -> Int {
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

maxDepth(tree)
maxDepth1(tree)

//: [Next](@next)
