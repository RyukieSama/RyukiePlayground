//: [Previous](@previous)

import Foundation

/*:
输入一棵二叉树和一个整数，打印出二叉树中节点值的和为输入整数的所有路径。从树的根节点开始往下一直到叶节点所经过的节点形成一条路径。

示例:
给定如下二叉树，以及目标和 target = 22，

```
               5
              / \
             4   8
            /   / \
           11  13  4
          /  \    / \
         7    2  5   1
```
 
返回:

```
 [
    [5,4,11,2],
    [5,8,4,5]
 ]
```

提示：

节点总数 <= 10000

来源：[力扣（LeetCode）](https://leetcode-cn.com/problems/er-cha-shu-zhong-he-wei-mou-yi-zhi-de-lu-jing-lcof)
*/

let t10 = TreeNode(10)
let t5 = TreeNode(5)
let t12 = TreeNode(12)
let t4 = TreeNode(4)
let t7 = TreeNode(7)

t10.left = t5
t10.right = t12

t5.left = t4
t5.right = t7

/**
 2023-03-03
 */
func pathSum230303(_ root: TreeNode?, _ target: Int) -> [[Int]] {
    var res: [[Int]] = []
    guard let root = root else { return res }
    let left = root.left, right = root.right, deta = target - root.val
    
    if left == nil, right == nil { // 到达叶子节点
        return deta == 0 ? [[root.val]] : []
    }
    
    let leftP = pathSum230303(left, deta), rightP = pathSum230303(right, deta)
    
    if let _ = leftP.first?.first {
        leftP.forEach { arr in
            res.append([root.val] + arr)
        }
    }
    
    if let _ = rightP.first?.first {
        rightP.forEach { arr in
            res.append([root.val] + arr)
        }
    }
    
    return res
}
pathSum230303(t10, 22)


/**
 2023-02-08
 
 记住，要求一直到叶子结点才结束
 */
func pathSum2328(_ root: TreeNode?, _ target: Int) -> [[Int]] {
    var res: [[Int]] = []
    guard let root = root else { return res }
    
    // 到了叶子结点，没这个结果都是空
    if root.val == target, root.left == nil, root.right == nil {
        return [[root.val]]
    }
    
    // 先判断有没有必要再递归效率高些，现在的方式效率低
    let leftRes: [[Int]] = pathSum2328(root.left, target - root.val),
        rightRes: [[Int]] = pathSum2328(root.right, target - root.val)
    
    for arr in leftRes {
        if arr.isEmpty == false {
            res.append([root.val] + arr)
        }
    }
    
    for arr in rightRes {
        if arr.isEmpty == false {
            res.append([root.val] + arr)
        }
    }
    
    return res
}

/**
 2023-02-07
 */
func pathSum2327(_ root: TreeNode?, _ target: Int) -> [[Int]] {
    var res: [[Int]] = []
    guard let root = root else { return res }
    
    print("target = \(target), root.val = \(root.val)")
    
//    if root.val == target {
//        // 因为：“一直到叶节点” 所以需要加判断
//        return (root.left == nil && root.right == nil) ? [[root.val]] : []
//    }
    // 上面的判断过早停止了，没有走到根节点
    
    
    if root.val == target, root.left == nil, root.right == nil {
        // 因为：“一直到叶节点” 所以需要加判断
        return [[root.val]]
    }
    
    var leftPath: [[Int]]?
    var rightPath: [[Int]]?
    
    if let left = root.left {
        leftPath = pathSum2327(left, target - root.val)
    }
    
    if let right = root.right {
        rightPath = pathSum2327(right, target - root.val)
    }
    
    for l in leftPath ?? [] {
        if l.isEmpty == false {
            var l = l
            l.insert(root.val, at: 0)
            res.append(l)
        }
    }
    
    for r in rightPath ?? [] {
        if r.isEmpty == false {
            var r = r
            r.insert(root.val, at: 0)
            res.append(r)
        }
    }
    
    return res
}

pathSum2327(t10, 22)


func pathSum(_ root: TreeNode?, _ target: Int) -> [[Int]] {
    guard let rootV = root?.val else {
        return []
    }
    var result: [[Int]] = []
    let deta = target - rootV
    var temp: [TreeNode] = []
    
    if let left = root?.left {
        temp.append(left)
    }
    
    if let right = root?.right {
        temp.append(right)
    }
    
//    print("rootV = \(rootV) target = \(target)")
    
    if temp.isEmpty { // 到达叶节点了
        if target == rootV {
            result.append([rootV])
        }
    }
    else {
        temp.forEach { tree in
            pathSum(tree, deta).forEach { datas in
                result.append([rootV] + datas)
            }
        }
    }
    
    return result
}

pathSum(t10, 22)

//: [Next](@next)
