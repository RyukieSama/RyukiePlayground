//: [Previous](@previous)

import Foundation

/*:
 
 输入两个链表，找出它们的第一个公共节点。

 如下面的两个链表：

![1](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/12/14/160_statement.png)

 在节点 c1 开始相交。

 示例 1：

![2](https://assets.leetcode.com/uploads/2018/12/13/160_example_1.png)

 输入：intersectVal = 8, listA = [4,1,8,4,5], listB = [5,0,1,8,4,5], skipA = 2, skipB = 3
 输出：Reference of the node with value = 8
 输入解释：相交节点的值为 8 （注意，如果两个列表相交则不能为 0）。从各自的表头开始算起，链表 A 为 [4,1,8,4,5]，链表 B 为 [5,0,1,8,4,5]。在 A 中，相交节点前有 2 个节点；在 B 中，相交节点前有 3 个节点。
  

 示例 2：

![3](https://assets.leetcode.com/uploads/2018/12/13/160_example_2.png)

 输入：intersectVal = 2, listA = [0,9,1,2,4], listB = [3,2,4], skipA = 3, skipB = 1
 输出：Reference of the node with value = 2
 输入解释：相交节点的值为 2 （注意，如果两个列表相交则不能为 0）。从各自的表头开始算起，链表 A 为 [0,9,1,2,4]，链表 B 为 [3,2,4]。在 A 中，相交节点前有 3 个节点；在 B 中，相交节点前有 1 个节点。
  

 示例 3：

![4](https://assets.leetcode.com/uploads/2018/12/13/160_example_3.png)

 输入：intersectVal = 0, listA = [2,6,4], listB = [1,5], skipA = 3, skipB = 2
 输出：null
 输入解释：从各自的表头开始算起，链表 A 为 [2,6,4]，链表 B 为 [1,5]。由于这两个链表不相交，所以 intersectVal 必须为 0，而 skipA 和 skipB 可以是任意值。
 解释：这两个链表不相交，因此返回 null。
  

 注意：

 如果两个链表没有交点，返回 null.
 
 在返回结果后，两个链表仍须保持原有的结构。
 
 可假定整个链表结构中没有循环。
 
 程序尽量满足 O(n) 时间复杂度，且仅用 O(1) 内存。
 
 本题与主站 160 题相同：https://leetcode-cn.com/problems/intersection-of-two-linked-lists/

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/liang-ge-lian-biao-de-di-yi-ge-gong-gong-jie-dian-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */

import UIKit

let n0 = ListNode(0)
let n11 = ListNode(1)
let n12 = ListNode(1)
let n4 = ListNode(4)
let n42 = ListNode(4)
let n51 = ListNode(5)
let n52 = ListNode(5)
let n8 = ListNode(8)

// [4,1,8,4,5]
n4.next = n11
n11.next = n8
n8.next = n42
n42.next = n52

// [5,0,1,8,4,5]
n51.next = n0
n0.next = n12
n12.next = n8

/**
 2023-03-04
 命中注定的相遇
 */
func sameNode(a: ListNode?, b: ListNode?) -> ListNode? {
    var p1 = a, p2 = b
    
    while p1 != p2 {
        p1 = p1?.next != nil ? p1?.next : b
        p2 = p2?.next != nil ? p2?.next : a
    }
    
    return p1
}


/**
 2023-02-19
 
 两个 View 找最近公共父视图
 */
func sameSuperView(aView: UIView, bView: UIView) -> UIView? {
    var nodeA: UIView? = aView, nodeB: UIView? = bView
    // 浪漫双指针
    while nodeA != nodeB {
        nodeA = nodeA != nil ? nodeA?.superview : bView
        nodeB = nodeB != nil ? nodeB?.superview : aView
    }
    return nodeA
}



func getIntersectionNode(headA: ListNode, headB: ListNode) -> ListNode? {
    var temp: [ListNode] = []
    var headA: ListNode? = headA
    var headB: ListNode? = headB
    
    while let a = headA {
        temp.append(a)
        headA = a.next
    }
    
    while let b = headB {
        if temp.contains(where: { $0 == b }) {
            return b
        }
        headB = b.next
    }
    
    return nil
}



let res = getIntersectionNode(headA: n4, headB: n51)
print(res?.val)

//: [Next](@next)
