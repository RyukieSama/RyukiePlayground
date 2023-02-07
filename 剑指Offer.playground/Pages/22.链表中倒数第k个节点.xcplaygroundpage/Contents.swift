//: [Previous](@previous)

import Foundation

/*:
 
 输入一个链表，输出该链表中倒数第k个节点。为了符合大多数人的习惯，本题从1开始计数，即链表的尾节点是倒数第1个节点。

 例如，一个链表有 6 个节点，从头节点开始，它们的值依次是 1、2、3、4、5、6。这个链表的倒数第 3 个节点是值为 4 的节点。

 示例：

```C++
 给定一个链表: 1->2->3->4->5, 和 k = 2.

 返回链表 4->5.
 通过次数193,790提交次数246,166
```
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/lian-biao-zhong-dao-shu-di-kge-jie-dian-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */

/**
 2023-02-07
 */
func getKthFromEnd2327(_ head: ListNode?, _ k: Int) -> ListNode? {
    var left: ListNode? = head, right: ListNode? = head
    var length = 1
    while let _ = right?.next {
        if length < k {
            right = right?.next
            length += 1
        }
        else {
            left = left?.next
            right = right?.next
        }
    }
    return left
}


/**
 2023-02-06
 游标
 */
func getKthFromEnd2326(_ head: ListNode?, _ k: Int) -> ListNode? {
    var left = head, right = head
    var space = 0
    // left right 间保持 k - 1 的距离
    while let _ = right {
        if k - 1 > space {// 间距不够，right 右移
            right = right?.next
            space += 1
        }
        else {
            if right?.next == nil {// 没有下一个了，到尾部了
                return left
            }
            else {
                right = right?.next
                left = left?.next
            }
        }
    }
    return left
}
/**
 方案一：
 栈
 */
func getKthFromEnd(_ head: ListNode?, _ k: Int) -> ListNode? {
    var node = head
    
    var temp: [ListNode] = []
    
    while let currentNode = node {
        temp.insert(currentNode, at: 0)
        if temp.count > k {
            temp.removeLast()
        }
        node = currentNode.next
    }
    
    return temp.last
}

/**
 方案二：
 差速双指针
 */
func getKthFromEnd2(_ head: ListNode?, _ k: Int) -> ListNode? {
    var right: ListNode? = head, left: ListNode? = head
    
    // 移动到 第 k 个节点
    for _ in 0..<k-1 {
        right = right?.next
    }
    
    while let _ = right?.next {
        right = right?.next
        left = left?.next
    }
    
    return left
}



//: [Next](@next)
