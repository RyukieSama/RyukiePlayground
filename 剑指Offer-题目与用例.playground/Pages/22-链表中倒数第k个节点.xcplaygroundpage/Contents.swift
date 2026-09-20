//: [上一题](@previous)

/*:
# 22-链表中倒数第k个节点

## 题目

输入一个链表，输出该链表中倒数第k个节点。为了符合大多数人的习惯，本题从1开始计数，即链表的尾节点是倒数第1个节点。

例如，一个链表有 6 个节点，从头节点开始，它们的值依次是 1、2、3、4、5、6。这个链表的倒数第 3 个节点是值为 4 的节点。

## 用例

**输入：** `head = [1,2,3,4,5]`，`k = 2`

**输出：** 节点 `4`，即链表 `[4,5]`

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/lian-biao-zhong-dao-shu-di-kge-jie-dian-lcof)
*/

func find(last k: Int,in head: ListNode) -> ListNode? {
    var d: [Int: ListNode] = [:], node: ListNode? = head, idx = 1
    
    while let n = node {
        d[idx] = n
        node = n.next
        idx += 1
    }
    
    return d[idx - k]
}

//func find2(last k: Int,in head: ListNode) -> ListNode? {
//    // 双指针创建一个窗口一起移动 空间优化到 O1
//    var p: ListNode? = head, res: ListNode?, step = 0
//    
//    while let node = p {
////        if let n = node.next {
////            step += 1
////        }
//        
//        if step < k {
//            step += 1
//        }
//        else if step == k, res == nil {
//            res = node
//        }
//        else if let r = res {
//            res = r.next
//        }
//        
//        p = node.next
//    }
//    
//    return res
//}

func find2(last k: Int, in head: ListNode) -> ListNode? {
    guard k > 0 else {
        return nil
    }
    
    var p: ListNode? = head
    var res: ListNode? = head
    var step = 0
    
    while let node = p {
        if step < k {
            step += 1
        }
        else {
            res = res?.next
        }
        
        p = node.next
    }
    
    // k 大于链表长度
    guard step == k else {
        return nil
    }
    
    return res
}

//: [下一题](@next)
