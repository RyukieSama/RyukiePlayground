//: [上一题](@previous)

/*:
# 35-复杂链表的复制

## 题目

请实现 copyRandomList 函数，复制一个复杂链表。在复杂链表中，每个节点除了有一个 next 指针指向下一个节点，还有一个 random 指针指向链表中的任意节点或者 null。

## 用例 1

**输入：** head = [[7,null],[13,0],[11,4],[10,2],[1,0]]
**输出：** [[7,null],[13,0],[11,4],[10,2],[1,0]]
## 用例 2

**输入：** head = [[1,1],[2,1]]
**输出：** [[1,1],[2,1]]
## 用例 3

**输入：** head = [[3,null],[3,0],[3,null]]
**输出：** [[3,null],[3,0],[3,null]]
## 用例 4

**输入：** head = []
**输出：** []
解释：给定的链表为空（空指针），因此返回 null。

## 提示

-10000 <= Node.val <= 10000
Node.random 为空（null）或指向链表中的节点。
节点数目不超过 1000 。

注意：本题与主站 138 题相同：https://leetcode-cn.com/problems/copy-list-with-random-pointer/

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/copy-list-with-random-pointer/)
*/
class ListRandomNode {
    let val: Int
    var next: ListRandomNode?
    var random: ListRandomNode?
    
    init(val: Int, next: ListRandomNode? = nil, random: ListRandomNode? = nil) {
        self.val = val
        self.next = next
        self.random = random
    }
}

func copyRandomListNode(_ node: ListRandomNode?) -> ListRandomNode? {
    let oldHead = node
    var newNode: ListRandomNode? = nil, newHead: ListRandomNode? = nil
    var node = node, newFlag = false
    
    // 构建一个主体为 A-a-B-b-C-c-D-d 的链表
    while let old = node {
        if newFlag {
            
        }
        else {
            let new = ListRandomNode(val: old.val)
            new.next = old.next
            old.next = new
            if newHead == nil {
                newHead = new
            }
        }
        
        node = node?.next
        newFlag.toggle()
    }
    
    node = oldHead
    newFlag = false
    
    var nextRandom: ListRandomNode?
    // 再构建 random 指向
    while let n = node {
        if newFlag {
            n.random = nextRandom
        }
        else {
            nextRandom = n.random?.next // 新的在旧的下一个
        }
        
        node = node?.next
        newFlag.toggle()
    }
        
    // 这里没有恢复原链表
//    // 删除旧的节点
//    while let n = newNode?.next?.next {
//        newNode?.next = n
//        newNode = newNode?.next
//    }
    
    var oldNode = oldHead
    var copyHead = newHead

    while let old = oldNode, let copy = old.next {
        let nextOld = copy.next
        
        // 恢复原链表
        old.next = nextOld
        
        // 连接复制链表
        copy.next = nextOld?.next
        
        oldNode = nextOld
    }
    
    return newHead
}

/*:
## 复杂链表复制解析

### 为什么普通复制不够

复杂链表除了 `next`，还有可以指向任意节点的 `random`。复制节点时不能只复制值和 `next`，还必须让新节点的 `random` 指向复制链表中的对应节点，而不是原链表节点。

### 第一步：交错插入复制节点

原链表：

```text
A -> B -> C
```

在每个原节点后插入复制节点：

```text
A -> a -> B -> b -> C -> c
```

其中 `a` 是 `A` 的复制节点，`b` 是 `B` 的复制节点。

这样原节点和复制节点之间存在固定关系：

```swift
old.next
```

就是对应的复制节点。

### 第二步：设置 `random`

如果原节点 `A.random` 指向原节点 `C`，那么复制节点 `a.random` 应该指向复制节点 `c`。

由于 `c` 紧跟在 `C` 后面，所以可以通过：

```swift
n.random?.next
```

找到对应的复制节点。

如果 `random == nil`，则复制节点的 `random` 保持为 `nil`。

### 第三步：拆分两条链表

交错链表拆分前：

```text
A -> a -> B -> b -> C -> c
```

拆分时同时处理原节点和复制节点：

```swift
let nextOld = copy.next
old.next = nextOld
copy.next = nextOld?.next
```

拆分后恢复为：

```text
原链表：A -> B -> C
复制链表：a -> b -> c
```

恢复原链表很重要，否则原链表会被交错结构破坏。

### 为什么额外空间是 `O(1)`

没有使用字典保存“原节点到复制节点”的映射，而是利用复制节点紧跟原节点的结构来完成映射。因此除了少量指针变量外，没有随着节点数量增长的额外数据结构。

### 边界情况

- 原链表为空：直接返回 `nil`。
- 单节点链表：`random` 可以指向自己，也可以为 `nil`。
- `random` 指向任意节点：通过目标原节点的 `next` 找到对应复制节点。

### 复杂度

- 时间复杂度：`O(n)`，需要依次完成交错插入、设置 `random` 和拆分。
- 额外空间复杂度：`O(1)`，不包括返回的复制链表本身。
*/

//: [下一题](@next)
