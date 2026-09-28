//: [上一题](@previous)

/*:
# LeetCode-0092-区间反转链表 II

## 题目

给定单链表的头节点 `head` 和两个整数 `left`、`right`，其中 `left <= right`。反转从位置 `left` 到位置 `right` 的链表节点，返回反转后的链表。

## 用例 1

**输入：** `head = [1,2,3,4,5]`，`left = 2`，`right = 4`

**输出：** `[1,4,3,2,5]`

## 用例 2

**输入：** `head = [5]`，`left = 1`，`right = 1`

**输出：** `[5]`

## 约束

- 链表节点数为 `n`
- `1 <= n <= 500`
- `-500 <= Node.val <= 500`
- `1 <= left <= right <= n`

## 来源

[LeetCode 原题](https://leetcode.cn/problems/reverse-linked-list-ii/)
*/

// 虚拟头节点 + 头插法
func reBetween( _ head: ListNode?, left: Int, right: Int) -> ListNode? {
    guard left < right else {
        return head
    }

    // 虚拟头节点可以统一处理 left == 1 的情况。
    let dummy = ListNode(0)
    dummy.next = head

    // pre 最终指向反转区间前一个节点。
    var pre: ListNode? = dummy

    for _ in 1..<left {
        pre = pre?.next
    }

    // current 始终是反转区间反转后的尾节点。
    guard let current = pre?.next else {
        return head
    }

    // 每次将 current 后面的节点移动到反转区间头部。
    for _ in 0..<(right - left) {
        guard let moving = current.next else {
            break
        }

        current.next = moving.next
        moving.next = pre?.next
        pre?.next = moving
    }

    return dummy.next
}

/*:
## 题目解析

题目中的 `left` 和 `right` 表示节点在链表中的位置，位置从 `1` 开始，与节点保存的 `val` 无关。

当 `left == right` 时，区间中只有一个节点，不需要反转，直接返回原链表。

### 为什么需要虚拟头节点

如果 `left == 1`，反转区间包含原头节点，反转后的链表头会发生变化。

在原链表前面增加一个虚拟头节点 `dummy`，可以保证反转区间前始终有一个节点：

```text
dummy -> 1 -> 2 -> 3 -> 4 -> 5
```

无论 `left` 是否为 `1`，最后都可以通过 `dummy.next` 取得反转后的真正头节点。

### 定位反转区间

`pre` 需要指向位置 `left` 的前一个节点，因此它从 `dummy` 开始移动 `left - 1` 次：

```swift
for _ in 1..<left {
    pre = pre?.next
}
```

`current` 初始指向位置 `left` 的节点。在整个头插过程中，它始终是已反转部分的尾节点。

### 头插法反转区间

每轮取出 `current` 后面的节点 `moving`，并将它插入 `pre` 后面。

指针调整分为三步：

```swift
current.next = moving.next
moving.next = pre?.next
pre?.next = moving
```

它们分别表示：

1. 将 `moving` 从原位置取出；
2. 让 `moving` 指向当前反转区间的头节点；
3. 让 `pre` 指向新的区间头节点 `moving`。

区间 `[left, right]` 中除了第一个节点，还有 `right - left` 个节点需要移到前面，所以头插操作需要执行 `right - left` 次。

### 示例推演

对于：

```text
1 -> 2 -> 3 -> 4 -> 5
left = 2, right = 4
```

`pre` 指向 `1`，`current` 指向 `2`。

第一次取出 `3` 并插入 `pre` 后面：

```text
1 -> 3 -> 2 -> 4 -> 5
```

第二次取出 `4` 并插入 `pre` 后面：

```text
1 -> 4 -> 3 -> 2 -> 5
```

此时已执行 `right - left = 2` 次，完成位置 `2...4` 的反转。

### 复杂度

- 时间复杂度：`O(n)`，只需要顺序定位并反转指定区间；
- 额外空间复杂度：`O(1)`，只使用了固定数量的指针。
*/

func reBetweenXXX(_ head: ListNode, left: Int, right: Int) -> ListNode? {
    /**
     要问题如下。
     1. 把位置当成了节点值
     题目中的 left、right 是从 1 开始的位置，不是节点值。
     当前代码：
     if node.val == left
     应该根据遍历下标判断，而不是比较 val。
     例如：
     head = [10,20,30], left = 1, right = 2
     期望：
     [20,10,30]
     当前代码找不到值为 1 的节点，会返回 nil。
     2. 返回了 leftPre，而不是原链表头
     [Contents.swift (line 86)](/Users/ryukiesama/Products/RyukiePlayground/剑指Offer-题目与用例.playground/Pages/LeetCode-0092-区间反转链表 II.xcplaygroundpage/Contents.swift:86)：
     return leftPre
     如果 left > 2，leftPre 并不是链表头。
     例如：
     [1,2,3,4,5], left = 3, right = 4
     虽然内部可能连接成：
     1 -> 2 -> 4 -> 3 -> 5
     但函数返回节点 2，调用方看到的是：
     2 -> 4 -> 3 -> 5
     节点 1 丢失了。
     3. 收集了从 left 到链表末尾的所有节点
     当前循环：
     while let temp = tempNode {
         arr.append(temp)
         tempNode = temp.next
     }
     没有在 rightP 处停止，所以反转的是整个后半段，然后再尝试重新连接。这会修改区间外节点的指针，容易产生错误甚至环。
     例如：
     [1,2,3], left = 2, right = 2
     本来不应该做任何修改，但当前实现可能把 2 和 3 连接成环：
     2 -> 3 -> 2 ...
     4. 缺少 left == right 的提前返回
     这种情况下链表不需要反转，建议直接：
     guard left < right else {
         return head
     }
     结论：代码能够编译，但算法不正确。建议采用“虚拟头节点 + 头插法”，根据位置移动指针，原地反转 [left, right]，时间复杂度 O(n)、空间复杂度 O(1)。
     */
    var leftP: ListNode? = head
    var leftPre: ListNode? // 翻转区间的上一个
    
    // 找到头
    while let node = leftP {
        if node.val == left {
            break
        }
        else {
            leftPre = leftP
            leftP = node.next
        }
    }
    
    if leftP == nil { return nil }
    
    var rightP = leftP
    var rightNext: ListNode? // 翻转区间尾的下一个
    
    // 找到尾
    while let node = rightP {
        if node.val == right {
            rightNext = node.next
            break
        }
        else {
            rightP = node.next
        }
    }
    
    // 翻转链表
    var tempNode = leftP, arr: [ListNode] = []
    while let temp = tempNode {
        arr.append(temp)
        tempNode = temp.next
    }
    tempNode = nil
    for idx in arr.indices.reversed() {
        let n = arr[idx]
        if let temp = tempNode {
            temp.next = n
        }
        tempNode = n
    }
    
    // 右边接上
    tempNode?.next = rightNext
    
    // 左边接上
    if let leftPre = leftPre {
        leftPre.next = rightP
        return leftPre
    }
    
    return rightP
}


//: [下一题](@next)
