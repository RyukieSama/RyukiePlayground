//: [Previous](@previous)

import Foundation

/*:
 输入两个递增排序的链表，合并这两个链表并使新链表中的节点仍然是递增排序的。
 
 示例1：
 
 输入：1->2->4, 1->3->4
 输出：1->1->2->3->4->4
 限制：
 
 0 <= 链表长度 <= 1000
 
 注意：本题与主站 21 题相同：https://leetcode-cn.com/problems/merge-two-sorted-lists/
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/he-bing-liang-ge-pai-xu-de-lian-biao-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

let ld1 = ListNode(1)
let ld2 = ListNode(2)
ld1.next = ld2
let ld3 = ListNode(4)
ld2.next = ld3

let ld4 = ListNode(1)
let ld5 = ListNode(3)
ld4.next = ld5
let ld6 = ListNode(4)
ld5.next = ld6

/**
 2023-03-03
 */
func mergeTwoLists230303(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var node: ListNode?
    var l1 = l1, l2 = l2
    var head: ListNode?
    
    while let n1 = l1, let n2 = l2 {
        if n1.val <= n2.val {
            if let _ = node {
                node?.next = n1
            }
            else {
                head = n1
            }
            node = n1
            l1 = l1?.next
        }
        else {
            if let _ = node {
                node?.next = n2
            }
            else {
                head = n2
            }
            node = n2
            l2 = l2?.next
        }
    }
    
    node?.next = l1 ?? l2
    
    return head ?? (l1 ?? l2)
}
mergeTwoLists230303(ld1, ld4)

/**
 2023-02-07
 */
func mergeTwoLists2327(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    // 用来构建的游标
    var res: ListNode?
    var node1 = l1, node2 = l2
    // 链表头需要保存一下，否则遍历没有了
    var head: ListNode?
    
    while let n1 = node1, let n2 = node2 {
        let small = n1.val <= n2.val ? n1 : n2
        if let _ = res {
            res?.next = ListNode(small.val)
            res = res?.next
        }
        else {
            res = ListNode(small.val)
            head = res
        }
        
        if n1.val <= n2.val {
            node1 = node1?.next
        }
        else {
            node2 = node2?.next
        }
    }
    
    res?.next = node1 ?? node2
    
    return head ?? (node1 ?? node2)
}

mergeTwoLists2327(ld1, ld4)

/**
 2023-02-06
 注意边界条件
 */
func mergeTwoLists2326(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var res: ListNode?
    var l1 = l1, l2 = l2
    var head: ListNode?
    
    while let n1 = l1, let n2 = l2 {
//        print("\(n1.val) - \(n2.val)")
//        if n1.val < n2.val {
//            if let _ = res {
//                res?.next = ListNode(n1.val)
//                res = res?.next
//            }
//            else {
//                head = ListNode(n1.val)
//                res = head
//            }
//            l1 = l1?.next
//        }
//        else {
//            if let _ = res {
//                res?.next = ListNode(n2.val)
//                res = res?.next
//            }
//            else {
//                head = ListNode(n2.val)
//                res = head
//            }
//            l2 = l2?.next
//        }
        
        // 精简代码
        var smallNode = n1.val < n2.val ? n1 : n2
        if let _ = res {
            res?.next = ListNode(smallNode.val)
            res = res?.next
        }
        else {
            head = ListNode(smallNode.val)
            res = head
        }
        
        if n1.val < n2.val {
            l1 = l1?.next
        }
        else {
            l2 = l2?.next
        }
        
    }
    
    res?.next = l1 ?? l2

    return head ?? (l1 ?? l2)
}

mergeTwoLists2326(ld1, ld4)

func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var line1 = l1
    var line2 = l2
    var firstNode: ListNode?
    var lastNode: ListNode?
    
    while let temp1 = line1, let temp2 = line2 {
        let isL1VSmaller = temp1.val < temp2.val
        let node = ListNode(isL1VSmaller ? temp1.val : temp2.val)
        if firstNode == nil {
            firstNode = node
        }
        else {
            lastNode?.next = node
        }
        lastNode = node
        isL1VSmaller ? (line1 = temp1.next) : (line2 = temp2.next)
    }
    
    if line1 == nil {
        lastNode?.next = line2
    }
    else {
        lastNode?.next = line1
    }
    
    return firstNode != nil ? firstNode : (l1 != nil ? l1 : l2)
}

mergeTwoLists(ld1, ld4)

//: [Next](@next)
