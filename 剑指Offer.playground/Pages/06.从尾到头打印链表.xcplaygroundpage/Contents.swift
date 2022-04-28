//: [Previous](@previous)

/*:
 输入一个链表的头节点，从尾到头反过来返回每个节点的值（用数组返回）。
 
 
 示例 1：
 
 输入：head = [1,3,2]
 输出：[2,3,1]
 */

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

let l1 = ListNode(1)
let l2 = ListNode(3)
let l3 = ListNode(2)

l1.next = l2

l2.next = l3

l3.next = nil

func reversePrintA(_ head: ListNode?) -> [Int] {
    var res: [Int] = [], node = head
    
    while let n = node {
        res.insert(n.val, at: 0)
        node = node?.next
    }
    
    return res
}

// 递归
func reversePrintAA(_ head: ListNode?) -> [Int] {
    guard let node = head else {
        return []
    }
    return reversePrintAA(head?.next) + [node.val]
}


func reversePrint(_ head: ListNode?) -> [Int] {
    guard let head = head else { return [] }
    var result: [Int] = []
    var currentNode: ListNode? = head
    
    while currentNode != nil {
        if let nd = currentNode {
            result.insert(nd.val, at: 0)
            currentNode = nd.next
        }
    }
    
    return result
}

reversePrint(l1)
reversePrintA(l1)
reversePrintAA(l1)

//: [Next](@next)
