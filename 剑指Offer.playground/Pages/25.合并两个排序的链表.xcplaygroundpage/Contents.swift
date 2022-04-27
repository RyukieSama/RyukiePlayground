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

mergeTwoLists(ld1, ld4)

//: [Next](@next)
