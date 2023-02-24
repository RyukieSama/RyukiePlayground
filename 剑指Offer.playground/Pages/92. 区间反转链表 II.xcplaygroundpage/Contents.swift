//: [Previous](@previous)

import Foundation

/*:
 [92. 反转链表 II](https://leetcode.cn/problems/reverse-linked-list-ii/)
 
 
 进阶： 你可以使用一趟扫描完成反转吗？
 */

let node1 = ListNode(3)
let node2 = ListNode(5)

node1.next = node2

func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
    guard left < right else {
        return head
    }
    var cnode = head, idx = 1
    /**
     看成三个整体
     pre + mid + after
     */
    
    var midHead: ListNode?, midPreNode: ListNode?
    while let p = cnode {
        if idx == left {
            midHead = cnode
            break
        }
        else {
            midPreNode = cnode
            cnode = cnode?.next
            idx += 1
        }
    }
    
    // 切断
    midPreNode?.next = nil
    
    guard var midHead = midHead else {
        return head
    }
    
    var midEnd: ListNode?, after: ListNode?
    while let p = cnode {
        if idx == right {
            midEnd = cnode
            cnode = cnode?.next
            idx += 1
            after = cnode
            break
        }
        else {
            cnode = cnode?.next
            idx += 1
        }
    }
    
    // 切断
    midEnd?.next = nil
    
    let reNode = reNode(midHead, after: after)
    
    if let _ = midPreNode {
        midPreNode?.next = reNode
        return head
    }
    else {
        return reNode
    }
}

// 反转链表
func reNode(_ head: ListNode?, after: ListNode?) -> ListNode? {
    var pre = head, curNode = head?.next
    pre?.next = after
    
    while let node = curNode {
        let temp = node.next
        curNode?.next = pre
        pre = curNode
        if temp == nil {
            return curNode
        }
        else {
            curNode = temp
        }
    }
    
    return pre
}

reverseBetween(node1, 1, 2)

//: [Next](@next)
