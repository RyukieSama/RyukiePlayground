//: [Previous](@previous)

import Foundation

/*:
 给定单向链表的头指针和一个要删除的节点的值，定义一个函数删除该节点。
 
 返回删除后的链表的头节点。
 
 注意：此题对比原题有改动
 
 示例 1:
 
 ```
 输入: head = [4,5,1,9], val = 5
 输出: [4,1,9]
 解释: 给定你链表中值为 5 的第二个节点，那么在调用了你的函数之后，该链表应变为 4 -> 1 -> 9.
 ```
 
 示例 2:
 
 ```
 输入: head = [4,5,1,9], val = 1
 输出: [4,5,9]
 解释: 给定你链表中值为 1 的第三个节点，那么在调用了你的函数之后，该链表应变为 4 -> 5 -> 9.
  ```
 
 说明：
 
 题目保证链表中节点的值互不相同
 若使用 C 或 C++ 语言，你不需要 free 或 delete 被删除的节点
 
 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/shan-chu-lian-biao-de-jie-dian-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/**
 2023-02-27
 */
func deleteNode23227(_ head: ListNode?, _ val: Int) -> ListNode? {
    
    return nil
}


/**
 2023-02-05
 */
func deleteNode3(_ head: ListNode?, _ val: Int) -> ListNode? {
    if head?.val == val {
        return head?.next
    }
    var curNode = head
    
    while let cur = curNode {
        if cur.next?.val == val {
            curNode?.next = cur.next?.next
            return head
        }
        curNode = cur.next
    }
    
    return head
}


/**
 双指针
 */
func deleteNode(_ head: ListNode?, _ val: Int) -> ListNode? {
    var lastNode: ListNode?
    var currentNode = head
    
    while let node = currentNode {
        if node.val == val {
            if let last = lastNode {
                last.next = node.next
                return head
            }
            else {
                return node.next
            }
        }
        
        lastNode = node
        currentNode = node.next
    }
    
    return head
}

/**
 单指针
 */
func deleteNode2(_ head: ListNode?, _ val: Int) -> ListNode? {
    if head?.val == val {
        return head?.next
    }
    var currentNode = head
    while let node = currentNode?.next {
        if node.val == val {
            currentNode?.next = node.next
            return head
        }
        else {
            currentNode = currentNode?.next
        }
    }
    return head
}

//: [Next](@next)
