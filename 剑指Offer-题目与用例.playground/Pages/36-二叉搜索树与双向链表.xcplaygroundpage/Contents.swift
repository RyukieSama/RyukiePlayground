//: [上一题](@previous)

/*:
# 36-二叉搜索树与双向链表

## 题目

输入一棵二叉搜索树，将该二叉搜索树转换成一个排序的循环双向链表。要求不能创建任何新的节点，只能调整树中节点指针的指向。

为了让您更好地理解问题，以下面的二叉搜索树为例：

我们希望将这个二叉搜索树转化为双向循环链表。链表中的每个节点都有一个前驱和后继指针。对于双向循环链表，第一个节点的前驱是最后一个节点，最后一个节点的后继是第一个节点。

下图展示了上面的二叉搜索树转化成的链表。“head” 表示指向链表中有最小元素的节点。

特别地，我们希望可以就地完成转换操作。当转化完成以后，树中节点的左指针需要指向前驱，树中节点的右指针需要指向后继。还需要返回链表中的第一个节点的指针。

## 用例

**输入：** `root = [4,2,5,1,3]`

**输出：** 双向循环链表 `[1,2,3,4,5]`

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/er-cha-sou-suo-shu-yu-shuang-xiang-lian-biao-lcof)
*/
//class CircleListNode {
//    let val: Int
//    var pre: CircleListNode?
//    var next: CircleListNode?
//    init(val: Int, pre: CircleListNode? = nil, next: CircleListNode? = nil) {
//        self.val = val
//        self.pre = pre
//        self.next = next
//    }
//}

func buildCircleListNode2(_ root: TreeNode?) -> TreeNode? {
    guard let root = root else { return nil }
    var head: TreeNode?, lastHandle: TreeNode?
    
    func inorder(node: TreeNode?) {
        guard let node = node else {
            return
        }
        
        inorder(node: node.left)
        
        if let lastHandle = lastHandle {
            lastHandle.right = node
            node.left = lastHandle
        }
        else {
            head = node // 到了左最深的叶子
        }
        
        lastHandle = node
        inorder(node: node.right)
    }
    
    inorder(node: root)
    
    head?.left = lastHandle
    lastHandle?.right = head
    
    return head
}

func buildCircleListNode(_ root: TreeNode?) -> TreeNode? {
    guard let root else {
        return nil
    }
    // 双向链表头节点
    var head: TreeNode?
    // 上一个已经处理的节点
    var previous: TreeNode?
    
    func inorder(_ node: TreeNode?) {
        guard let node else {
            return
        }
        
        inorder(node.left)
        
        if let previous {
            previous.right = node
            node.left = previous
        }
        else {
            head = node
        }
        
        previous = node
        inorder(node.right)
    }
    
    inorder(root)
    
    head?.left = previous
    previous?.right = head
    
    return head
}

// 错了
//func buildCircleListNode(_ searchTree: TreeNode?) -> TreeNode? {
//    guard let searchTree = searchTree else { return nil }
//    // 二叉搜索树 中序遍历结果是有序的
//    let pre = buildCircleListNode(searchTree.left)
//    let next = buildCircleListNode(searchTree.right)
//    searchTree.left = pre
//    searchTree.right = next
//    var head = searchTree, last = searchTree
//    while let preNode = head.left {
//        head = preNode
//    }
//    
//    while let lastNode = last.right {
//        last = lastNode
//    }
//    
//    head.left = last
//    last.right = head
//
//    return head
//}

/*:
## 二叉搜索树转循环双向链表解析

### 核心性质

二叉搜索树的中序遍历顺序是：

```text
左子树 → 当前节点 → 右子树
```

中序遍历得到的节点天然是从小到大排列的，因此可以在遍历过程中直接建立有序双向链表。

### `head` 和 `previous`

- `head`：保存链表中最小的节点，也就是中序遍历访问到的第一个节点。
- `previous`：保存上一次访问的节点，用来连接当前节点。

访问当前节点时：

```swift
previous.right = node
node.left = previous
previous = node
```

树节点的 `left` 被当作链表前驱，`right` 被当作链表后继。

如果 `previous == nil`，说明当前节点是最小节点，需要保存为 `head`。

### 示例

对于：

```text
    4
   / \
  2   5
 / \
1   3
```

中序访问顺序为：

```text
1 → 2 → 3 → 4 → 5
```

连接后得到：

```text
1 <-> 2 <-> 3 <-> 4 <-> 5
```

### 构造循环

中序遍历结束后，`previous` 指向最大节点。将头尾连接：

```swift
head?.left = previous
previous?.right = head
```

这样就满足：

```text
最小节点.left → 最大节点
最大节点.right → 最小节点
```

### 为什么不能递归返回子树头节点后再寻找尾节点

如果子树已经连接成循环，再沿 `left` 或 `right` 查找尾节点，可能会一直在环中循环。使用 `previous` 在中序遍历过程中直接连接，可以避免重复查找和环路问题。

### 复杂度

- 时间复杂度：`O(n)`，每个节点访问一次。
- 额外空间复杂度：`O(h)`，来自递归栈。
- 不创建新节点，直接复用树节点的 `left` 和 `right` 指针。
*/

//: [下一题](@next)
