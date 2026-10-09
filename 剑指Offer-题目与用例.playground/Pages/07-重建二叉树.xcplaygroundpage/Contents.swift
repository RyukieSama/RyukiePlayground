//: [上一题](@previous)

/*:
# 07-重建二叉树

## 题目

输入某二叉树的前序遍历和中序遍历的结果，请重建该二叉树。假设输入的前序遍历和中序遍历的结果中都不含重复的数字。

例如，给出

前序遍历 preorder = [3,9,20,15,7]

中序遍历 inorder = [9,3,15,20,7]

返回如下的二叉树：

```
3
/ \
9  20
    /  \
    15   7
```

## 约束

0 <= 节点个数 <= 5000

## 用例

**输入：** `preorder = [3,9,20,15,7]`，`inorder = [9,3,15,20,7]`

**输出：** `[3,9,20,null,null,15,7]`

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/zhong-jian-er-cha-shu-lcof)
*/
var preorder = [3,9,20,15,7]
var inorder = [9,3,15,20,7]

func rebuildTree20261009(pre: [Int], mid: [Int]) -> TreeNode? {
    guard let root = pre.first, mid.count == pre.count else {
        return nil
    }
    var node = TreeNode(root)
    if let rootIdxInMid = mid.firstIndex(of: root) {
        let leftCount = rootIdxInMid,
            rightCount = mid.count - rootIdxInMid - 1
        var leftPre: [Int] = [],
            rightPre: [Int] = [],
            leftIn: [Int] = [],
            rightIn: [Int] = []
        
        if leftCount > 0 {
            leftPre = Array(pre[1..<leftCount+1])
            leftIn = Array(mid[0..<leftCount])
        }
        
        if rightCount > 0 {
            rightPre = Array(pre[leftCount+1..<pre.count])
            rightIn = Array(mid[rootIdxInMid+1..<mid.count])
        }
        
        node.left = rebuildTree20261009(pre: leftPre, mid: leftIn)
        node.right = rebuildTree20261009(pre: rightPre, mid: rightIn)
    }
    
    return node
}


//func rebuildTree202609292_02X(pre: [Int], mid: [Int]) -> TreeNode? {
//    // idx 下标，不用每次都递归都 firstindex，优化时间复杂度
//    var midMap: [Int: Int] = [:]
//    for (idx, v) in mid.enumerated() {
//        midMap[v] = idx
//    }
//    
//    // 错了，内部循递归的数组不是初始的下标对不上的
//    func rebuild(pre: [Int], mid: [Int]) -> TreeNode? {
//        guard
//            let rootV = pre.first,
//            mid.count == pre.count,
//            let rootIdx = midMap[rootV]
//        else {
//            return nil
//        }
//        var tree = TreeNode(rootV)
//        let leftCount = rootIdx
//        tree.left = rebuild(pre: Array(pre[1..<(leftCount+1)]),
//                            mid: Array(mid[0..<rootIdx]))
//        tree.right = rebuild(pre: Array(pre[(leftCount+1)..<pre.count]),
//                             mid: Array(mid[(rootIdx+1)..<mid.count]))
//        return tree
//    }
//    
//    return rebuild(pre: pre, mid: mid)
//}

// 正确的优化解法
func rebuildTree202609292_02(
    pre: [Int],
    mid: [Int]
) -> TreeNode? {
    guard pre.count == mid.count,
          pre.isEmpty == false else {
        return nil
    }

    var middleIndexes: [Int: Int] = [:]

    for (index, value) in mid.enumerated() {
        middleIndexes[value] = index
    }

    var preorderIndex = 0

    func rebuild(
        middleLeft: Int,
        middleRight: Int
    ) -> TreeNode? {
        guard middleLeft <= middleRight,
              preorderIndex < pre.count else {
            return nil
        }

        let rootValue = pre[preorderIndex]
        preorderIndex += 1

        guard let rootIndex = middleIndexes[rootValue],
              rootIndex >= middleLeft,
              rootIndex <= middleRight else {
            return nil
        }

        let root = TreeNode(rootValue)

        root.left = rebuild(
            middleLeft: middleLeft,
            middleRight: rootIndex - 1
        )

        root.right = rebuild(
            middleLeft: rootIndex + 1,
            middleRight: middleRight
        )

        return root
    }

    return rebuild(
        middleLeft: 0,
        middleRight: mid.count - 1
    )
}

func rebuildTree20260929(pre: [Int], mid: [Int]) -> TreeNode? {
    guard
        let rootV = pre.first,
        mid.count == pre.count,
        let rootIdx = mid.firstIndex(of: rootV)
    else {
        return nil
    }
    /**
     各个元素不同，才能在现有条件下重建
     前序 确定根节点值
     中序 确定左右
     */
    var root: TreeNode = TreeNode(rootV)
    let leftCount = rootIdx//, rightCount = mid.count - leftCount - 1
    
//    root.left = rebuildTree20260929(pre: Array(pre[1...leftCount]), // 可能会崩溃
    root.left = rebuildTree20260929(pre: Array(pre[1..<(leftCount+1)]),
                                    mid: Array(mid[0..<leftCount]))
    root.right = rebuildTree20260929(pre: Array(pre[(leftCount+1)..<pre.count]),
                                     mid: Array(mid[(rootIdx + 1)..<mid.count]))
    return root
}

//preorder = [1, 2]
//inorder = [1, 2]

func rebuildTree(pre: [Int], mid: [Int]) -> TreeNode? {
    guard
        let rootVal = pre.first,
        let rootIdxInorder = mid.firstIndex(of: rootVal) // 注意，不含重复的数字是很重要的一点，可以确定在中序中根节点的位置
    else {
        return nil
    }
    
    let root = TreeNode(rootVal)
    // 递归遍历
    
    guard pre.count > 1, mid.count > 1 else {
        return root
    }
    
    let leftNodeCount = rootIdxInorder
    
    if rootIdxInorder > 0 {
        let leftPre = Array(pre[1...leftNodeCount]), leftIn = Array(mid[0..<rootIdxInorder])
        root.left = rebuildTree(pre: leftPre, mid: leftIn)
    }
    
    if leftNodeCount + 1 < pre.count, rootIdxInorder + 1 < mid.count {
        let rightPre = Array(pre[(leftNodeCount + 1)..<pre.count]), rightIn = Array(mid[(rootIdxInorder + 1)..<mid.count])
        root.right = rebuildTree(pre: rightPre, mid: rightIn)
    }
    
    return root
}

rebuildTree(pre: preorder, mid: inorder)

/*:
## 重建二叉树：总结

### 核心思路

前序遍历的第一个元素一定是当前子树的根节点。

找到根节点在中序遍历中的位置后：

- 根节点左侧的元素属于左子树。
- 根节点右侧的元素属于右子树。
- 左子树的节点数量决定了前序遍历中左右子树的切分位置。

例如：

```
preorder = [3, 9, 20, 15, 7]
inorder  = [9, 3, 15, 20, 7]
```

根节点是 `3`，它在中序遍历中的下标是 `1`，因此左子树有一个节点：

```
左子树：preorder = [9]，       inorder = [9]
右子树：preorder = [20,15,7]， inorder = [15,20,7]
```

对左右子树继续执行相同过程，就能递归构建整棵树。

### 当前实现为什么正确

- 第 48 行从前序遍历中取出当前根节点。
- 第 49 行根据根节点在中序遍历中的位置确定左右子树边界。
- 第 64 行按左子树节点数量切分左子树的前序遍历。
- 第 69 行使用同样的节点数量切分右子树的前序遍历。
- 递归结束后，所有节点都会被放回正确的父子关系中。

这依赖题目给出的重要条件：前序和中序遍历中没有重复数字。否则无法唯一确定根节点在中序遍历中的位置。

### 递归终止条件

- 前序遍历为空：没有节点，返回 `nil`。
- 当前子树只有一个节点：创建根节点并直接返回。
- 当前根节点位于中序遍历最左侧或最右侧时，对应子树为空，不进行递归。

### 当前实现的复杂度

当前实现每层递归都会：

- 使用 `firstIndex(of:)` 在线性查找根节点位置。
- 使用 `Array(...) `复制左右子数组。

因此最坏情况下：

- 时间复杂度：`O(n²)`
- 额外空间复杂度：最坏约为 `O(n²)`（反复复制子数组）
- 递归栈空间：`O(n)`

如果先用字典记录每个值在中序遍历中的下标，并改用下标区间递归，
可以将时间复杂度降到 `O(n)`，额外空间复杂度降到 `O(n)`。

### 输入有效性注意事项

题目保证输入有效且两个遍历数组长度相同。当前实现没有主动校验非法输入，例如：

```
pre = [1, 2]
mid  = [1]
```

遇到这类输入时，函数可能返回一个不完整的树，而不是明确报告输入无效。
这不影响题目约束下的正确性，但在实际项目代码中应额外校验长度和节点集合是否一致。
*/

//: [下一题](@next)
