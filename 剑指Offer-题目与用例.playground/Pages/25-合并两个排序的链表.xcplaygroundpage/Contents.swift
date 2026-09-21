//: [上一题](@previous)

/*:
# 25-合并两个排序的链表

## 题目

输入两个递增排序的链表，合并这两个链表并使新链表中的节点仍然是递增排序的。

## 用例 1

**输入：** 1->2->4, 1->3->4
**输出：** 1->1->2->3->4->4
## 约束

0 <= 链表长度 <= 1000

注意：本题与主站 21 题相同：https://leetcode-cn.com/problems/merge-two-sorted-lists/

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/merge-two-sorted-lists/)
*/

func combainListNode(a: ListNode?, b: ListNode?) -> ListNode? {
    var node: ListNode?
    var aNode = a, bNode = b
    var head: ListNode? // 得有个头，否则又要反转找head了
    
    while let an = aNode, let bn = bNode {
        if an.val < bn.val {
            if node == nil {
                node = an
                head = node
            }
            else {
                node?.next = aNode
            }
            node = an
            aNode = aNode?.next
        }
        else {
            if node == nil {
                node = bn
                head = node
            }
            else {
                node?.next = bNode
            }
            node = bn
            bNode = bNode?.next
        }
    }
    
    node?.next = aNode ?? bNode
    
    return head ?? a ?? b
    
}

func hebing(a: ListNode?, b: ListNode?) -> ListNode? {
    var aNode = a, bNode = b
    var move: ListNode?
    var head: ListNode?
    
    while let nodeA = aNode, let nodeB = bNode {
        var selected: ListNode?
        
        if nodeA.val <= nodeB.val {
            selected = nodeA
            
            if move == nil {
                move = nodeA
                head = nodeA
            }
            else {
                move?.next = nodeA
            }
            
            aNode = aNode?.next
        }
        else {
            selected = nodeB
            
            if move == nil {
                move = nodeB
                head = nodeB
            }
            else {
                move?.next = nodeB
            }
            
            bNode = bNode?.next
        }
        
        move = selected
    }
    
    move?.next = aNode ?? bNode
    
    return head ?? aNode ?? bNode
}

/*:
## 合并两个有序链表解析

### 指针含义

- `aNode`：链表 `a` 当前还没有合并的节点。
- `bNode`：链表 `b` 当前还没有合并的节点。
- `head`：合并结果的头节点，只在第一次选择节点时确定。
- `node`：合并结果当前的尾节点。

每一轮比较 `an.val` 和 `bn.val`，选择较小的节点加入结果链表。

### 为什么 `node` 必须指向刚选中的节点

例如本轮选择了 `an`：

```swift
node?.next = an
node = an
aNode = an.next
```

其中：

- `an` 是刚加入结果链表的节点。
- `aNode` 移动到下一个待处理节点。
- `node` 必须停留在 `an`，这样下一轮才能继续从它后面连接节点。

不能写成：

```swift
node = aNode
```

因为此时 `aNode` 已经是原链表的下一个节点，会跳过刚刚选中的节点。

### 合并过程示例

```text
a: 1 -> 2 -> 4
b: 1 -> 3 -> 4
```

依次选择：

```text
1(a) -> 1(b) -> 2(a) -> 3(b) -> 4(a)
```

当其中一个链表遍历结束后，另一个链表剩余部分已经保持有序，可以直接连接：

```swift
node?.next = aNode ?? bNode
```

### 边界情况

- `a == nil`：直接返回 `b`。
- `b == nil`：直接返回 `a`。
- 两个链表都为空：返回 `nil`。
- 节点值相等时当前代码优先选择 `b`，不影响最终有序性。

### 复杂度

- 时间复杂度：`O(m + n)`，每个节点最多处理一次。
- 额外空间复杂度：`O(1)`，直接复用原链表节点，不创建新节点。
*/


//: [下一题](@next)
