//: [上一题](@previous)

/*:
# 06-从尾到头打印链表

## 题目

输入一个链表的头节点，从尾到头反过来返回每个节点的值（用数组返回）。

## 用例 1

**输入：** head = [1,3,2]
**输出：** [2,3,1]
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


// ⚠️ 注意：题目允许空链表时，参数应考虑使用 ListNode?。
// 当前参数是非可选的 ListNode，因此无法传入 nil。
func reNodes_20260914(_ node: ListNode) -> [Int] {
    var res: [Int] = [], node: ListNode? = node
    
    while let val = node?.val {
        // ⚠️ 注意：在数组头部插入元素会移动已有的全部元素。
        // 第一次移动 0 个，第二次移动 1 个，……，总移动次数为 O(n²)。
//        res.insert(val, at: 0)
        res.append(val)
        node = node?.next
    }
    
    return res.reversed()
}

reNodes_20260914(l1)

/*:
## 当前实现的问题

### 1. 不支持空链表

题目中的链表头节点可能为空，但当前函数签名是：

```swift
func reNodes_20260914(_ node: ListNode) -> [Int]
```

因此不能直接传入 `nil`。如果要覆盖空链表用例，参数应设计为可选的 `ListNode?`。

### 2. 头部插入导致时间复杂度为 O(n²)

`res.insert(val, at: 0)` 每次都需要将已有元素整体向后移动。
链表长度为 `n` 时，累计移动次数为：

```
0 + 1 + 2 + ... + (n - 1) = O(n²)
```

所以当前实现的复杂度是：

- 时间复杂度：`O(n²)`
- 空间复杂度：`O(n)`

可以先使用 `append` 按正序收集节点值，遍历结束后统一 `reverse()`，
将时间复杂度降为 `O(n)`。

### 3. 变量名重复

`node` 既是函数参数名，又在局部被重新声明为可选变量。
虽然 Swift 允许这种写法，但容易混淆，建议为局部变量使用不同名称。
*/

//: [下一题](@next)
