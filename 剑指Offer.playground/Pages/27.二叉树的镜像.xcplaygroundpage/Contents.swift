//: [Previous](@previous)

/*:
 请完成一个函数，输入一个二叉树，该函数输出它的镜像。
 
 例如输入：
 
      4
    /   \
   2     7
  / \   / \
 1   3 6   9
 镜像输出：
 
      4
    /   \
   7     2
  / \   / \
 9   6 3   1
 
  
 
 示例 1：
 
 输入：root = [4,2,7,1,3,6,9]
 输出：[4,7,2,9,6,3,1]
  
 
 限制：
 
 0 <= 节点个数 <= 1000
 
 注意：本题与主站 226 题相同：https://leetcode-cn.com/problems/invert-binary-tree/
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/er-cha-shu-de-jing-xiang-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/**
 2023-02-06
 */
func mirrorTree2326(_ root: TreeNode?) -> TreeNode? {
    guard let rootVal = root?.val else { return nil }
    var tree = TreeNode(rootVal)
    
    if root?.left != nil {
        tree.right = mirrorTree2326(root?.left)
    }
    
    if root?.right != nil {
        tree.left = mirrorTree2326(root?.right)
    }
    
    return tree
}

/**
 方法一
 递归（自下而上）
 时间复杂度O(n)
 空间复杂度O(n)
 */
func mirrorTree1(_ root: TreeNode?) -> TreeNode? {
    if root == nil {
        return nil
    }
    let left = root?.left
    let right = root?.right
    root?.left = mirrorTree1(right)
    root?.right = mirrorTree1(left)
    return root
}

/**
 方法二
 Stack（自上而下）
 
 分左右两边处理
 一层层找到需要处理的节点
 找到一个加入Stack
 处理一个节点移出Stack
 直到Stack为空
 */
func mirrorTree2(_ root: TreeNode?) -> TreeNode? {
    var stack: [TreeNode?] = [root]
    
    while stack.last != nil {
        let node = stack.removeLast()
        let right = node?.right
        let left = node?.left
        
        if let rn = right {
            stack.append(rn)
        }
        if let ln = left {
            stack.append(ln)
        }
        
        node?.left = right
        node?.right = left
    }
    
    return root
}

//: [Next](@next)
