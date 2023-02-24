//: [Previous](@previous)

import Foundation

/*:
[剑指 Offer II 022. 链表中环的入口节点](https://leetcode.cn/problems/c32eOV/)
 */

/**
 2023-02-24
 */
func detectCycle(_ head: ListNode?) -> ListNode? {
    
    var fast = head, slow = head
    
    /**
     fast 一次两步
     slow 一次一步
     */
    while true {
        if fast == nil || fast?.next == nil { return nil }
        fast = fast?.next?.next
        slow = slow?.next
        
        if fast == slow {
            break
        }
    }
    
    var res = head
    /**
     回头再来 res 一次一步，再次相遇时就时入口
     */
    while true {
        if res != slow {
            res = res?.next
            slow = slow?.next
        }
        else {
            break
        }
    }
    
    return res
}

//: [Next](@next)
