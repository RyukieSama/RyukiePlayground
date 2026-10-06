//: [上一题](@previous)

/*:
# Offer-II-022-链表中环的入口节点

## 题目

给定一个链表，返回链表开始入环的第一个节点。如果链表无环，则返回 `nil`。

使用整数 `pos` 表示链表尾连接到链表中的位置（索引从 0 开始）；`pos = -1` 表示链表无环。`pos` 只用于描述用例，不会作为参数传入。不得修改给定链表。

## 用例 1

**输入：** `head = [3,2,0,-4]`，`pos = 1`

**输出：** 返回索引为 `1` 的链表节点

## 用例 2

**输入：** `head = [1,2]`，`pos = 0`

**输出：** 返回索引为 `0` 的链表节点

## 用例 3

**输入：** `head = [1]`，`pos = -1`

**输出：** `nil`

## 约束

- 链表节点数在 `[0, 10⁴]` 范围内
- `-10⁵ <= Node.val <= 10⁵`
- `pos` 为 `-1` 或链表中的有效索引

## 来源

[LeetCode 原题](https://leetcode.cn/problems/c32eOV/)
*/

func find20261006(_ head: ListNode?) -> ListNode? {
    // 先找是否存在环
    var fast: ListNode? = head, slow: ListNode? = head
    
    while fast != nil, fast?.next != nil {
        fast = fast?.next?.next
        slow = slow?.next
        
        if slow == fast {
            // 从头节点和环内相遇点同时出发，每次各走一步，相遇处就是环入口
            var node = head
            while node != slow {
                node = node?.next
                slow = slow?.next
            }
            return node
        }
    }
    
    // 能出 while 循环，那就一定没环
    return nil
}


func find2(_ head: ListNode?) -> ListNode? {
    var fast = head, slow = head
    
    while fast != nil, fast?.next != nil {
        // 进环后，快的一定会追上慢的
        fast = fast?.next?.next
        slow = slow?.next
        
        if slow == fast { // 在环里追上了，找入口
            var res = head
            while res != slow {
                res = res?.next
                slow = slow?.next
            }
            return res
        }
    }
    
    return nil
}

func find(_ head: ListNode?) -> ListNode? {
    var slow = head
    var fast = head

    // 第一阶段：判断是否存在环
    while fast != nil, fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next

        if slow == fast {
            // 第二阶段：寻找环的入口
            var finder = head

            while finder != slow {
                finder = finder?.next
                slow = slow?.next
            }

            return finder
        }
    }

    // fast 能走到 nil，说明链表没有环
    return nil
}

/*:
## 题目解析

`pos` 只是测试平台用来描述“链表尾节点连回哪个节点”的辅助信息，不会作为参数传入函数。函数实际只能通过 `head` 和节点的 `next` 指针判断链表是否有环。

例如 `head = [3,2,0,-4]`、`pos = 1` 表示尾节点 `-4` 的 `next` 指向索引 `1` 的节点 `2`：

```text
3 -> 2 -> 0 -> -4
     ↑             |
     └-------------┘
```

从链表头开始行走时，第一个进入环的节点是 `2`，因此应返回该节点对象，而不是它的值或索引。

### 第一阶段：判断是否有环

同时从链表头启动两个指针：

- `slow` 每次走一步；
- `fast` 每次走两步。

如果链表没有环，`fast` 或 `fast.next` 最终会变成 `nil`。

如果链表存在环，两个指针进入环后，`fast` 会逐渐追上 `slow`，两者最终会在环内相遇。

上述用例中的移动过程为：

| 移动次数 | `slow` | `fast` |
| ---: | ---: | ---: |
| 开始 | 3 | 3 |
| 1 | 2 | 0 |
| 2 | 0 | 2 |
| 3 | -4 | -4 |

两个指针在 `-4` 相遇，说明链表存在环。

### 第二阶段：寻找环的入口

第一次相遇后，将新指针 `finder` 放在链表头，`slow` 留在相遇点。两个指针改为每次各走一步，它们再次相遇的位置就是环的入口。

上述用例中，`finder` 从 `3` 开始，`slow` 从 `-4` 开始。两者各走一步后都到达节点 `2`，因此 `2` 是环的入口。

### 为什么第二次会在入口相遇

设：

- 从链表头到环入口的距离为 `a`；
- 从环入口到第一次相遇点的距离为 `b`；
- 环的长度为 `L`。

第一次相遇时，慢指针走过 `a + b`，快指针的速度是慢指针的两倍。快指针比慢指针多走的距离一定是环长的整数倍：

```text
2(a + b) - (a + b) = kL
a + b = kL
a = (k - 1)L + (L - b)
```

`L - b` 是从第一次相遇点继续走到环入口的距离。因此，从链表头和相遇点同时每次走一步，经过 `a` 步后一定会在环入口相遇。

### 为什么不能比较节点值

两个不同节点可能保存相同的值，所以必须判断两个指针是否指向同一个节点，不能只比较 `val`。项目中 `ListNode` 的 `==` 按节点身份比较，因此可以直接使用 `slow == fast`。

### 复杂度

- 时间复杂度：`O(n)`；
- 额外空间复杂度：`O(1)`，只使用了固定数量的指针。
*/

//: [下一题](@next)
