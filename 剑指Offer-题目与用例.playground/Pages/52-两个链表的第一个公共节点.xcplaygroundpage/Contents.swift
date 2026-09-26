//: [上一题](@previous)

/*:
# 52-两个链表的第一个公共节点

## 题目

输入两个链表，找出它们的第一个公共节点。

如下面的两个链表：

![1](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/12/14/160_statement.png)

在节点 c1 开始相交。

## 用例 1

![2](https://assets.leetcode.com/uploads/2018/12/13/160_example_1.png)

**输入：** intersectVal = 8, listA = [4,1,8,4,5], listB = [5,0,1,8,4,5], skipA = 2, skipB = 3
**输出：** Reference of the node with value = 8
输入解释：相交节点的值为 8 （注意，如果两个列表相交则不能为 0）。从各自的表头开始算起，链表 A 为 [4,1,8,4,5]，链表 B 为 [5,0,1,8,4,5]。在 A 中，相交节点前有 2 个节点；在 B 中，相交节点前有 3 个节点。

## 用例 2

![3](https://assets.leetcode.com/uploads/2018/12/13/160_example_2.png)

**输入：** intersectVal = 2, listA = [0,9,1,2,4], listB = [3,2,4], skipA = 3, skipB = 1
**输出：** Reference of the node with value = 2
输入解释：相交节点的值为 2 （注意，如果两个列表相交则不能为 0）。从各自的表头开始算起，链表 A 为 [0,9,1,2,4]，链表 B 为 [3,2,4]。在 A 中，相交节点前有 3 个节点；在 B 中，相交节点前有 1 个节点。

## 用例 3

![4](https://assets.leetcode.com/uploads/2018/12/13/160_example_3.png)

**输入：** intersectVal = 0, listA = [2,6,4], listB = [1,5], skipA = 3, skipB = 2
**输出：** null
输入解释：从各自的表头开始算起，链表 A 为 [2,6,4]，链表 B 为 [1,5]。由于这两个链表不相交，所以 intersectVal 必须为 0，而 skipA 和 skipB 可以是任意值。
解释：这两个链表不相交，因此返回 null。

注意：

如果两个链表没有交点，返回 null.

在返回结果后，两个链表仍须保持原有的结构。

可假定整个链表结构中没有循环。

程序尽量满足 O(n) 时间复杂度，且仅用 O(1) 内存。

本题与主站 160 题相同：https://leetcode-cn.com/problems/intersection-of-two-linked-lists/

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/intersection-of-two-linked-lists/)
*/
// O(m+n) O(1)
func listNodeCross(_ a: ListNode?, _ b: ListNode?) -> ListNode? {
    guard let a = a, let b = b else {
        return nil
    }
    var pa = a, pb = b
    while pa != pb {
        pa = pa.next ?? b
        pb = pb.next ?? a
    }
    return pa
}

/*:
## 题目解析

这道题要求找到两个单向链表的第一个公共节点。这里的“公共”指两个指针指向同一个节点对象，而不是节点值相同。

### 双指针切换方法

代码使用两个指针：

- `pa` 从链表 A 的头节点开始；
- `pb` 从链表 B 的头节点开始。

当指针走到一个链表的末尾时，让它切换到另一个链表的头节点：

```swift
pa = pa.next ?? b
pb = pb.next ?? a
```

假设两个链表的独有部分长度分别为 `a` 和 `b`，公共部分长度为 `c`：

- `pa` 的路径长度是 `a + c + b + c`；
- `pb` 的路径长度是 `b + c + a + c`。

两者走过的总长度相同，因此会在第一个公共节点相遇。如果两个链表不相交，它们最终会同时变成 `nil`，循环结束并返回 `nil`。

### 为什么比较节点对象

不能只比较：

```swift
pa?.val == pb?.val
```

因为两个不同节点可能拥有相同的值。必须判断两个指针是否指向同一个节点，也就是使用：

```swift
pa != pb
```

项目中的 `ListNode` 已经按照对象身份实现了 `Equatable`，因此当前比较方式是正确的。

### 复杂度

如果两个链表长度分别为 `m` 和 `n`：

- 时间复杂度：`O(m + n)`，也可以记作总节点数 `N` 的 `O(N)`。
- 额外空间复杂度：`O(1)`。

这是本题推荐的最优解，不需要创建集合，也不会修改原链表结构。
*/

//: [下一题](@next)
