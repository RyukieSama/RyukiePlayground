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

//let result = [1,3,2,6,5]
let result = [1,6,3,2,5]
verifyPostorder(result)

//: [Next](@next)
