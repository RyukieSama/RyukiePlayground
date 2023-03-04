//: [Previous](@previous)

import Foundation

/*:
 请实现 copyRandomList 函数，复制一个复杂链表。在复杂链表中，每个节点除了有一个 next 指针指向下一个节点，还有一个 random 指针指向链表中的任意节点或者 null。

  

 示例 1：



 输入：head = [[7,null],[13,0],[11,4],[10,2],[1,0]]
 输出：[[7,null],[13,0],[11,4],[10,2],[1,0]]
 示例 2：



 输入：head = [[1,1],[2,1]]
 输出：[[1,1],[2,1]]
 示例 3：



 输入：head = [[3,null],[3,0],[3,null]]
 输出：[[3,null],[3,0],[3,null]]
 示例 4：

 输入：head = []
 输出：[]
 解释：给定的链表为空（空指针），因此返回 null。
  

 提示：

 -10000 <= Node.val <= 10000
 Node.random 为空（null）或指向链表中的节点。
 节点数目不超过 1000 。
  

 注意：本题与主站 138 题相同：https://leetcode-cn.com/problems/copy-list-with-random-pointer/

  

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/fu-za-lian-biao-de-fu-zhi-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/**
 * 原链表
 * A - B - C - D - E
 * 过度链表
 * A - a - B - b - C -c -D - d - E - e
 * 结果链表
 * a - b - c - d - e
 */


func copyRandomList(_ head: ComplexListNode) -> ComplexListNode? {
    var p: ComplexListNode? = head
    
    var flag = false
    // A a B b C c D d
    while let current = p {
        if flag {
            p = current.next
        }
        else {
            let node = ComplexListNode(current.val)
            node.next = current.next
            p?.next = node
            p = node
        }
        flag.toggle()
    }
    
    // 处理 random
    p = head
    var randomP: ComplexListNode?
    while let current = p {
        if flag {
            p?.random = randomP
        }
        else {
            randomP = current.random?.next
        }
        p = current.next
        flag.toggle()
    }
    
    // 删除原来的节点
    let result: ComplexListNode? = head.next
    p = result
    while let current = p {
        if flag {
            p?.next = current.next?.next
        }
        else {
            p = current.next
        }
        flag.toggle()
    }
    
    return result
}

func copyRandomList2(_ head: ComplexListNode) -> ComplexListNode? {
    var p: ComplexListNode? = head
    
    // A a B b C c D d
    while let current = p {
        let node = ComplexListNode(current.val)
        node.next = current.next
        p?.next = node
        p = current.next?.next
    }
    
    // 处理 random
    p = head
    while let current = p {
        let clone = current.next
        clone?.random = current.random?.next
        p = clone?.next
    }
    
    // 删除原来的节点
    let result: ComplexListNode? = head.next
    p = result
    while let current = p {
        p?.next = current.next?.next
        p = p?.next
    }
    
    return result
}

let l1 = ComplexListNode(1)
let l2 = ComplexListNode(2)
let l3 = ComplexListNode(3)
let l4 = ComplexListNode(4)

l1.next = l2
l1.random = l3

l2.next = l3
l2.random = l1

l3.next = l4

var head = copyRandomList2(l1)

var temp: ComplexListNode? = head

while let node = temp {
    print("val=\(node.val) next=\(node.next?.val) random=\(node.random?.val)")
    temp = temp?.next
}

//: [Next](@next)
