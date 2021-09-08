//: [Previous](@previous)

import Foundation

/*:
输入一棵二叉搜索树，将该二叉搜索树转换成一个排序的循环双向链表。要求不能创建任何新的节点，只能调整树中节点指针的指向。

为了让您更好地理解问题，以下面的二叉搜索树为例：
 

我们希望将这个二叉搜索树转化为双向循环链表。链表中的每个节点都有一个前驱和后继指针。对于双向循环链表，第一个节点的前驱是最后一个节点，最后一个节点的后继是第一个节点。

下图展示了上面的二叉搜索树转化成的链表。“head” 表示指向链表中有最小元素的节点。
 

特别地，我们希望可以就地完成转换操作。当转化完成以后，树中节点的左指针需要指向前驱，树中节点的右指针需要指向后继。还需要返回链表中的第一个节点的指针。

来源：[力扣（LeetCode）](https://leetcode-cn.com/problems/er-cha-sou-suo-shu-yu-shuang-xiang-lian-biao-lcof)
*/


var head: TreeNode?, last: TreeNode?

func treeToDoublyList(root: TreeNode) -> TreeNode {
    handle(root: root)
    last?.right = head
    head?.left = last
    return root
}

func handle(root: TreeNode) -> TreeNode {
    if let left = root.left {
        if let rightOfLeft = left.right {
            let node = handle(root: rightOfLeft)
            root.left = node
            node.left = left
            node.right = root
        }
        
        if let leftOfLeft = left.left, leftOfLeft.left == nil {
            leftOfLeft.right = left
            head = leftOfLeft
        }
    }
    
    if let right = root.right {
        if let leftOfRight = right.left {
            let node = handle(root: leftOfRight)
            root.right = node
            node.right = right
            node.left = root
        }
        
        if let rightOfRight = right.right, rightOfRight.right == nil {
            rightOfRight.left = right
            last = rightOfRight
        }
    }
    
    return root
}
 
let t1 = TreeNode(1)
let t2 = TreeNode(2)
let t3 = TreeNode(3)
let t4 = TreeNode(4)
let t5 = TreeNode(5)
let t6 = TreeNode(6)
let t7 = TreeNode(7)

t4.left = t2
t4.right = t6

t2.left = t1
t2.right = t3

t6.left = t5
t6.right = t7

let arr = [t1, t2, t3, t4, t5, t6, t7]

func log(root: TreeNode) {
    if let left = root.left {
        print("\(root.val)左：\(left.val)")
    }
    else {
        print("\(root.val)左：nil")
    }
    
    if let right = root.right {
        print("\(root.val)右：\(right.val)")
    }
    else {
        print("\(root.val)右：nil")
    }
}

arr.forEach { log(root: $0) }

print("=== 双向转换 ===")
treeToDoublyList(root: t4)

arr.forEach { log(root: $0) }

//: [Next](@next)
