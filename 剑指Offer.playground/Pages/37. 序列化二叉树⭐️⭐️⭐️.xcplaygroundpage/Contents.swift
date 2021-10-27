//: [Previous](@previous)


/*:
请实现两个函数，分别用来序列化和反序列化二叉树。

你需要设计一个算法来实现二叉树的序列化与反序列化。这里不限定你的序列 / 反序列化算法执行逻辑，你只需要保证一个二叉树可以被序列化为一个字符串并且将这个字符串反序列化为原始的树结构。

提示：输入输出格式与 LeetCode 目前使用的方式一致，详情请参阅 [LeetCode 序列化二叉树的格式](https://support.leetcode-cn.com/hc/kb/article/1194353/) 。 你并非必须采取这种方式，你也可以采用其他的方法解决这个问题。

```
输入：root = [1,2,3,null,null,4,5]
输出：[1,2,3,null,null,4,5]
```
 
链接：https://leetcode-cn.com/problems/xu-lie-hua-er-cha-shu-lcof
 
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/

import Foundation

func serialize(root: TreeNode) -> String {
    var result = ""
    var queue: [TreeNode?] = [root]
    
    while queue.isEmpty == false {
        if let first = queue.first, let node = first {
            result.append((result.isEmpty ? "\(node.val)" : ",\(node.val)"))
            
            queue.append(node.left)
            queue.append(node.right)
        }
        else {
            result.append(",null")
        }
        
        queue.removeFirst()
    }
    
    return result
}

func deserialize(data: String) -> TreeNode? {
    let array: [String] = data.components(separatedBy: ",")
    var nodes: [TreeNode?] = []
    array.forEach { item in
        if let v = Int(item) {
            nodes.append(TreeNode(v))
        }
        else {
            nodes.append(nil)
        }
    }
    
    if nodes.isEmpty == true { return nil }
    
    var queue: [TreeNode] = []
    var index = 0
    
    if let f = nodes.first, let n = f {
        queue.append(n)
    }
    
    while queue.isEmpty == false {
        if let node = queue.first, index + 1 < nodes.count, index + 2 < nodes.count {
            node.left = nodes[index + 1]
            node.right = nodes[index + 2]
            
            if let l = node.left {
                queue.append(l)
            }
            
            if let r = node.right {
                queue.append(r)
            }
            
            index += 2
        }
        
        queue.removeFirst()
    }
    
    return nodes.first ?? nil
}

// root = [1,2,3,null,null,4,5]

let root1 = TreeNode(1)
let root2 = TreeNode(2)
let root3 = TreeNode(3)
let root4 = TreeNode(4)
let root5 = TreeNode(5)

root1.left = root2
root1.right = root3

root3.left = root4
root3.right = root5

// 编码
let s1 = serialize(root: root1)

// 解码
let node = deserialize(data: s1)

// 再编码验证
if let n = node {
    serialize(root: n)
}

//: [Next](@next)
