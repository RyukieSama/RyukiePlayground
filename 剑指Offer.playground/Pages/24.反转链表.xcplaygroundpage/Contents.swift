//: [Previous](@previous)

import Foundation

/*:
 定义一个函数，输入一个链表的头节点，反转该链表并输出反转后链表的头节点。

 示例:

```C++
 输入: 1->2->3->4->5->NULL
 输出: 5->4->3->2->1->NULL
```

 限制：

```C++
 0 <= 节点个数 <= 5000
```
 
 注意：本题与主站 206 题相同：https://leetcode-cn.com/problems/reverse-linked-list/

* 来源：力扣（LeetCode）
* 链接：https://leetcode-cn.com/problems/fan-zhuan-lian-biao-lcof
* 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

let l1 = ListNode(1)
let l2 = ListNode(2)
let l3 = ListNode(3)

l1.next = l2

l2.next = l3

l3.next = nil

/**
 2023-02-06
 
 */
func reverseList2326(_ head: ListNode?) -> ListNode? {
    var res: ListNode?
    var temp = head
    while let cNode = temp {
        let node = ListNode(cNode.val)
        node.next = res
        res = node
        temp = cNode.next
    }
    return res
}
reverseList2326(l1)

func reverseList(_ head: ListNode?) -> ListNode? {
    var node: ListNode?
    var temp: ListNode? = head
    
    while let current = temp {
        let n = ListNode(current.val)
        n.next = node
        node = n
        temp = current.next
    }
    
    return node
}

reverseList(l1)

//: [Next](@next)
