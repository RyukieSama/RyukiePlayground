//: [上一题](@previous)

/*:
# 18-删除链表的节点

## 题目

给定单向链表的头指针和一个要删除的节点的值，定义一个函数删除该节点。

返回删除后的链表的头节点。

注意：此题对比原题有改动

## 用例 1

```
输入: head = [4,5,1,9], val = 5
输出: [4,1,9]
解释: 给定你链表中值为 5 的第二个节点，那么在调用了你的函数之后，该链表应变为 4 -> 1 -> 9.
```

## 用例 2

```
输入: head = [4,5,1,9], val = 1
输出: [4,5,9]
解释: 给定你链表中值为 1 的第三个节点，那么在调用了你的函数之后，该链表应变为 4 -> 5 -> 9.
```

## 说明

题目保证链表中节点的值互不相同
若使用 C 或 C++ 语言，你不需要 free 或 delete 被删除的节点

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/shan-chu-lian-biao-de-jie-dian-lcof)
*/

//func del(node: ListNode, from head: ListNode) -> ListNode? {
//    var res: ListNode? = nil
//    var last: ListNode? = nil, current: ListNode? = head
//    
//    func cut() {
//        guard let cur = current else { return }
//        if cur.val == node.val {
//            if let last = last {
//                last.next = cur.next
//            }
//            else {
//                res = cur.next
//            }
//        }
//        else {
//            last = current
//            current = current?.next
//            cut()
//        }
//    }
//    
//    cut()
//    
//    return res
//}

func del(node: ListNode, from head: ListNode) -> ListNode? {
    if head.val == node.val { return head.next }
    var current: ListNode? = head
    
    while let cur = current, let nex = cur.next {
//        if cur.val == node.val { // 错误
        if nex.val == node.val {
            cur.next = nex.next
            break
        }
        else {
            current = cur.next
        }
    }
    
    return head
}

/*:
## 删除链表节点解析

### 核心思路

单向链表只能从前往后访问。删除一个节点时，不能直接拿到它的前驱节点，因此遍历时同时保存：

- `cur`：当前节点，也就是待删除节点的前一个节点。
- `nex`：当前节点的下一个节点，也就是要检查的目标节点。

当发现：

```swift
nex.val == node.val
```

就让当前节点跳过 `nex`：

```swift
cur.next = nex.next
```

这样链表就完成了删除。

### 为什么要检查 `nex`

代码需要修改的是前一个节点 `cur` 的 `next` 指针，因此应该检查它后面的节点 `nex` 是否为目标节点：

```text
cur -> nex -> nex.next
```

删除 `nex` 后变成：

```text
cur -> nex.next
```

如果检查 `cur.val`，就会把“正在操作的节点”和“要删除的节点”混淆。

### 头节点的特殊处理

头节点没有前驱节点，不能通过 `cur.next` 删除，因此需要单独判断：

```swift
if head.val == node.val {
    return head.next
}
```

返回原头节点的下一个节点作为新的头节点。

### 三种情况

- 删除头节点：返回 `head.next`。
- 删除中间节点：前驱节点跳过目标节点。
- 删除尾节点：前驱节点的 `next` 被设置为 `nil`。

题目保证节点值互不相同，因此找到目标节点后可以直接删除并结束遍历。

### 复杂度

- 时间复杂度：`O(n)`，最坏需要遍历整个链表。
- 空间复杂度：`O(1)`，只使用有限的指针变量。
*/

//: [下一题](@next)
