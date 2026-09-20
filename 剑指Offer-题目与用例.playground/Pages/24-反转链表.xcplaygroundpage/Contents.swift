//: [上一题](@previous)

/*:
# 24-反转链表

## 题目

定义一个函数，输入一个链表的头节点，反转该链表并输出反转后链表的头节点。

## 用例

```C++
输入: 1->2->3->4->5->NULL
输出: 5->4->3->2->1->NULL
```

## 约束

```C++
0 <= 节点个数 <= 5000
```

注意：本题与主站 206 题相同：https://leetcode-cn.com/problems/reverse-linked-list/

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/reverse-linked-list/)
*/

func reverseListNode(_ head: ListNode?) -> ListNode? {
    var left = head, right = head?.next
    
    while let r = right {
        if let newRight = r.next {
            right = newRight
            r.next = left
            left = r
        }
        else {
            r.next = left
            return r
        }
    }
    
    return right ?? head
}

// 简化循环
func reverseListNode2(_ head: ListNode?) -> ListNode? {
    var left: ListNode?
    var right = head
    
    while let node = right {
        let next = node.next
        node.next = left
        left = node
        right = next
    }
    
    return left
}

/*:
## 反转链表解析

### 指针含义

- `left`：已经完成反转的链表部分的头节点。
- `right`：还没有处理的链表部分的当前节点。

处理当前节点时，必须先保存它原来的后继节点：

```swift
let next = node.next
node.next = left
left = node
right = next
```

如果先修改 `node.next`，就会丢失后面的链表。

### 反转过程

以：

```text
1 -> 2 -> 3 -> nil
```

为例：

```text
开始：left = nil，right = 1
处理 1：1 -> nil，left = 1，right = 2
处理 2：2 -> 1，left = 2，right = 3
处理 3：3 -> 2，left = 3，right = nil
```

最后 `left` 就是新的头节点。

### 两个版本的区别

`reverseListNode` 在遇到尾节点时单独返回；`reverseListNode2` 使用统一循环处理所有节点，结构更简单，也更容易验证。

### 边界情况

- 空链表：`head == nil`，循环不执行，返回 `nil`。
- 单节点链表：节点的 `next` 保持为 `nil`，返回该节点。
- 多节点链表：原尾节点成为新头节点。

### 复杂度

- 时间复杂度：`O(n)`，每个节点只处理一次。
- 空间复杂度：`O(1)`，只使用有限的指针变量。
*/

//: [下一题](@next)
