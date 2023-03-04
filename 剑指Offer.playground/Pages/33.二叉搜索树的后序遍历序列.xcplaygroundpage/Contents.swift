//: [Previous](@previous)

import Foundation

/*:
输入一个整数数组，判断该数组是不是某二叉搜索树的后序遍历结果。如果是则返回 true，否则返回 false。假设输入的数组的任意两个数字都互不相同。

参考以下这颗二叉搜索树：

```
      5
     / \
    2   6
   / \
  1   3
```
 
示例 1：
 
```
输入: [1,6,3,2,5]
输出: false
```

示例 2：

```
输入: [1,3,2,6,5]
输出: true
```

提示：

数组长度 <= 1000

来源：[力扣（LeetCode）](https://leetcode-cn.com/problems/er-cha-sou-suo-shu-de-hou-xu-bian-li-xu-lie-lcof)
 */

var result = [1,3,2,6,5]
result = [1,6,3,2,5]
result = [4, 8, 6, 12, 16, 14, 10]

/**
 2023-03-03
 */
func verifyPostorder230303(_ postorder: [Int]) -> Bool {
    guard let root = postorder.last else {
        return true
    }
    var left: [Int] = [], right: [Int] = [], idx = 0
    var flag = true
    
    while idx < postorder.count - 1 {
        let val = postorder[idx]
        if flag == true {
            if val < root {
                idx += 1
                left.append(val)
            }
            else {
                flag.toggle()
            }
        }
        else {
            if val > root {
                idx += 1
                right.append(val)
            }
            else {
                return false
            }
        }
    }
    
    return verifyPostorder230303(left) && verifyPostorder230303(right)
}
verifyPostorder230303(result)

/**
 2023-02-08
 */
func verifyPostorder2328(_ postorder: [Int]) -> Bool {
    guard let root = postorder.last else { return true }
    var left: [Int] = []
    var right: [Int] = []
    var flag = false
    
    for item in postorder {
        if item == root { break }
        if flag == false {
            if item < root {
                left.append(item)
            }
            else {
                // 拐点，下面的是右节点了
                flag = true
                right.append(item)
            }
        }
        else {
            if item > root {
                right.append(item)
            }
            else {
                return false
            }
        }
    }
    
    return verifyPostorder2328(left) && verifyPostorder2328(right)
}

verifyPostorder2328(result)

/**
 2023-02-07
 
 二叉搜索树
 
 - 非空左子树所有节点都比 根节点小
 - 非空右子树所有节点都比根节点 大
 - 左右子树的子树也是二叉搜索树
 
 前序遍历：根 左 右
 中序遍历：左 根 右
 后序遍历：左 右 根
 
 遍历方式是按照根节点的位置来命名的
 
 后序遍历的根节点在数组末尾
 
 本题的后续结果应该是 左子树结果A + 右子树结果B + 根节点
 判断两部分的趋势就可以了，且AB两部分也必须满足条件
 */
func verifyPostorder2327(_ postorder: [Int]) -> Bool {
    guard let root = postorder.last else {
        return true
    }
    var idx = 0
    var flag = false// 趋势
    var leftArr: [Int] = [], rightArr: [Int] = []
    
    while idx < postorder.count - 1{
        if flag == false, postorder[idx] < root {
            leftArr.append(postorder[idx])
            idx += 1
        }
        else if postorder[idx] > root {
            rightArr.append(postorder[idx])
            if flag == false {
                flag = true
            }
            idx += 1
        }
        else {
            return false
        }
    }
    
    print("left = \(leftArr), right = \(rightArr)")
    
    return verifyPostorder2327(leftArr) && verifyPostorder2327(rightArr)
}

verifyPostorder2327(result)





func verifyPostorder(_ postorder: [Int]) -> Bool {
    guard let root = postorder.last else {
        return true
    }
    var left: [Int] = []
    var right: [Int] = []
    var flag = false
    
    for offset in 1..<postorder.count {
        let v = postorder[postorder.count - 1 - offset]
        if v < root {
            if flag == false { flag = true }
            left.insert(v, at: 0)
        }
        else if v > root, flag == false {
            right.insert(v, at: 0)
        }
        else {
            return false
        }
    }
    
    return verifyPostorder(left) && verifyPostorder(right)
}

verifyPostorder(result)

//: [Next](@next)
