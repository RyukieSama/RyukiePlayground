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

/*:
## 双指针解析

### 当前解法的变量含义

- `p`：从头到尾遍历链表的指针。
- `res`：最终要返回的节点，也就是比 `p` 滞后 `k` 个位置的指针。
- `step`：`p` 已经走过的节点数量，最多先累计到 `k`。

### 为什么 `res` 要从头节点开始

当 `p` 还没有走满 `k` 步时，`res` 不移动：

```swift
if step < k {
    step += 1
}
```

当 `p` 走到第 `k + 1` 个节点后，`res` 才开始向后移动：

```swift
else {
    res = res?.next
}
```

这样可以保证 `p` 和 `res` 之间始终相差 `k` 个节点。

例如：

```text
链表：1 -> 2 -> 3 -> 4 -> 5
k = 2
```

遍历过程：

```text
处理 1：step = 1，res = 1
处理 2：step = 2，res = 1
处理 3：res = 2
处理 4：res = 3
处理 5：res = 4
```

最终 `res` 指向倒数第 2 个节点 `4`。

### 越界处理

遍历结束后，如果：

```swift
step < k
```

说明 `k` 大于链表长度，应返回 `nil`，不能返回头节点。

### 复杂度

- 时间复杂度：`O(n)`，只遍历链表一次。
- 空间复杂度：`O(1)`，只使用几个指针和计数变量。
*/

//: [下一题](@next)
