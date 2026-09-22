//: [上一题](@previous)

/*:
# 33-二叉搜索树的后序遍历序列

## 题目

输入一个整数数组，判断该数组是不是某二叉搜索树的后序遍历结果。如果是则返回 true，否则返回 false。假设输入的数组的任意两个数字都互不相同。

参考以下这颗二叉搜索树：

```
5
/ \
2   6
/ \
1   3
```

## 用例 1

```
输入: [1,6,3,2,5]
输出: false
```

## 用例 2

```
输入: [1,3,2,6,5]
输出: true
```

## 提示

数组长度 <= 1000

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/er-cha-sou-suo-shu-de-hou-xu-bian-li-xu-lie-lcof)
*/
/**
 左子树所有节点值 < 当前节点值
 右子树所有节点值 > 当前节点值
 */

func isSearchTree(_ nums: [Int]) -> Bool {    
    func match(_ left: Int, _ right: Int) -> Bool {
        guard left < right else { return true }
        let root = nums[right]
        var idx = left
        
        while idx < right, nums[idx] < root {
            idx += 1
        }
        // 转折点左侧全部小于根节点 ，走到这就找到了转折点，或者到头了
        
        for rightIdx in idx..<right {
            if nums[rightIdx] < root {
                return false // 应该全部大于根节点
            }
        }
        
        // 到这里就符合 左边小 右边大了 需要再验证每个子树是否匹配
        
        return match(left, idx - 1) && match(idx, right - 1)
    }
    
    return match(0, nums.count - 1)
}

/*:
## 二叉搜索树后序序列解析

后序遍历顺序是“左子树、右子树、根节点”，所以当前区间最后一个元素 `nums[right]` 一定是当前子树的根节点。

二叉搜索树满足：左子树所有节点小于根节点，右子树所有节点大于根节点。代码从左向右扫描，找到第一个不小于根节点的位置 `idx`，将它作为右子树的起点。

找到分界后，需要检查 `idx..<right` 区间中的所有节点是否都大于根节点。如果发现某个节点小于根节点，说明序列不可能是二叉搜索树的后序遍历。

通过检查后，再递归验证左右两个区间：

```swift
match(left, idx - 1)
match(idx, right - 1)
```

其中 `right` 是根节点位置，因此递归右子树时使用 `right - 1`。当区间为空或只剩一个节点时，直接返回 `true`。

例如 `[1, 3, 2, 6, 5]` 的根节点是 `5`，左子树候选为 `[1, 3, 2]`，右子树候选为 `[6]`，两边都满足规则，因此结果为 `true`。

而 `[1, 6, 3, 2, 5]` 的右子树候选中包含小于 `5` 的节点 `3` 和 `2`，所以结果为 `false`。

### 复杂度

- 时间复杂度：最坏为 `O(n²)`，退化树会重复扫描区间。
- 递归空间复杂度：`O(n)`；树平衡时约为 `O(log n)`。
*/

//: [下一题](@next)
