//: [上一题](@previous)

/*:
# 37-序列化二叉树

## 题目

请实现两个函数，分别用来序列化和反序列化二叉树。

你需要设计一个算法来实现二叉树的序列化与反序列化。这里不限定你的序列 / 反序列化算法执行逻辑，你只需要保证一个二叉树可以被序列化为一个字符串并且将这个字符串反序列化为原始的树结构。

## 提示
输入输出格式与 LeetCode 目前使用的方式一致，详情请参阅 [LeetCode 序列化二叉树的格式](https://support.leetcode-cn.com/hc/kb/article/1194353/) 。 你并非必须采取这种方式，你也可以采用其他的方法解决这个问题。


## 用例

```
输入：root = [1,2,3,null,null,4,5]
输出：[1,2,3,null,null,4,5]
```

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/xu-lie-hua-er-cha-shu-lcof)
*/
func toString(_ tree: TreeNode?) -> String {
    var res: [String] = []
    
    func pre(_ node: TreeNode?) {
        guard let node = node else {
            res.append("x")
            return
        }
        res.append("\(node.val)")
        pre(node.left)
        pre(node.right)
    }
    
    pre(tree)
    
    return res.joined(separator: ",")
}

func fromString(_ str: String?) -> TreeNode? {
    guard
        let str = str,
        str.isEmpty == false
    else {
        return nil
    }
    
    let strArr = str.components(separatedBy: ",")
    var idx = 0
    
    guard strArr.isEmpty == false else {
        return nil
    }
    
    func buildTree() -> TreeNode? {
        guard idx < strArr.count else {
            return nil
        }
        let str = strArr[idx]
        idx += 1
        
        if str == "x" {
            return nil
        }
        
        guard let val = Int(str) else { return nil }
        let tree = TreeNode(val)
        tree.left = buildTree() // 利用前序遍历的特点
        tree.right = buildTree()
        return tree
    }
    
    return buildTree()
}

func serialize(_ root: TreeNode?) -> String {
    var result: [String] = []
    
    func dfs(_ node: TreeNode?) {
        guard let node = node else {
            result.append("#")
            return
        }
        
        result.append(String(node.val))
        dfs(node.left)
        dfs(node.right)
    }
    
    dfs(root)
    return result.joined(separator: ",")
}

func deserialize(_ data: String) -> TreeNode? {
    let values = data.split(separator: ",").map(String.init)
    var index = 0
    
    func dfs() -> TreeNode? {
        guard index < values.count else {
            return nil
        }
        
        let value = values[index]
        index += 1
        
        if value == "#" {
            return nil
        }
        
        guard let number = Int(value) else {
            return nil
        }
        
        let node = TreeNode(number)
        node.left = dfs()
        node.right = dfs()
        return node
    }
    
    return dfs()
}

// 这种思路只能用于元素不重复的，所以做不下去了
//func treeNodeToString(_ tree: TreeNode?) -> String? {
//    // 前序 中序 遍历组成数组用来还原
//    var preRes: [Int] = [], inRes: [Int] = []
//    pre(tree, res: &preRes)
//    ino(tree, res: &inRes)
//    
//    guard preRes.isEmpty == false, inRes.isEmpty == false else {
//        return nil
//    }
//    let pStr = preRes.map({ "\($0)" }).joined(separator: ","),
//        inStr = inRes.map({ "\($0)" }).joined(separator: ",")
//    
//    return pStr + " " + inStr
//}
//
//func pre(_ tree: TreeNode?, res: inout [Int]) -> [Int] {
//    if let tree = tree {
//        res.append(tree.val)
//        pre(tree.left, res: &res)
//        pre(tree.right, res: &res)
//    }
//    return res
//}
//
//func ino(_ tree: TreeNode?, res: inout [Int]) -> [Int] {
//    if let tree = tree {
//        ino(tree.left, res: &res)
//        res.append(tree.val)
//        ino(tree.right, res: &res)
//    }
//    return res
//}
//
//func stringToTreeNode(_ string: String?) -> TreeNode? {
//    guard
//        let string = string,
//        string.isEmpty == false
//    else {
//        return nil
//    }
//    
//    let sp = string.components(separatedBy: " ")
//    guard sp.count == 2 else {
//        return nil
//    }
//    
//    let preString = sp[0].components(separatedBy: ","), inString = sp[1].components(separatedBy: ",")
//    
//    guard preString.isEmpty == false, inString.isEmpty == false else {
//        return nil
//    }
//    
//    var preRes: [Int] = [], inRes: [Int] = []
//    
//    for str in preString {
//        if let num = Int(str) {
//            preRes.append(num)
//        }
//        else {
//            return nil
//        }
//    }
//    
//    for str in inString {
//        if let num = Int(str) {
//            inRes.append(num)
//        }
//        else {
//            return nil
//        }
//    }
//    
//    guard preRes.isEmpty == false, preRes.count == inRes.count else { return nil }
//    
//    return buildTree(preRes, inRes)
//}
//
//// 使用前序 中序的结果重建二叉树
//func buildTree(_ pre: [Int], _ ino: [Int]) -> TreeNode? {
//    guard let root = pre.first, pre.count == ino.count else {
//        return nil
//    }
//    let node = TreeNode(root)
//    
//    return node
//}
/*:
## 题目解析

这道题要求实现两个互相对应的过程：

1. **序列化**：把一棵二叉树转换成字符串。
2. **反序列化**：根据字符串重新构造出原来的二叉树。

重点不是单纯记录节点值，而是要同时记录空节点的位置。否则不同结构的二叉树可能得到相同的字符串，反序列化时就无法判断左右子树的边界。

### 当前前序 + 中序思路的问题

使用前序遍历和中序遍历重建二叉树时，通常要求节点值互不重复：

- 前序遍历的第一个节点是当前子树的根节点。
- 在中序遍历中找到根节点的位置，就能把数组分成左子树和右子树。

如果节点值重复，就无法确定中序数组中应该选择哪一个相同值作为根节点，因此结构可能无法唯一确定。

当前代码还有两个问题：

- `ino` 函数中递归遍历子树时应调用 `ino`，不能调用 `pre`，否则得到的不是中序遍历结果。
- `buildTree` 当前只创建了根节点，还没有递归构造左右子树，因此反序列化尚未完成。

### 推荐方案：前序遍历 + 空节点标记

更适合本题的方式是使用带空节点标记的前序遍历。例如：

```text
    1
   / \\
  2   2

序列化结果：1,2,#,#,2,#,#
```

其中 `#` 表示空节点。读取字符串时按照同样的前序顺序递归：

1. 读取到 `#`，返回 `nil`。
2. 读取到数字，创建当前节点。
3. 继续递归读取左子树。
4. 再递归读取右子树。

由于空节点的位置也被保存了，即使节点值重复，也能准确恢复原来的树结构。

### 复杂度

- 序列化时间复杂度：`O(n)`。
- 反序列化时间复杂度：`O(n)`。
- 递归栈空间复杂度：`O(h)`，`h` 是二叉树高度。
- 序列化字符串本身需要 `O(n)` 的存储空间。

本题的核心是：**序列化和反序列化必须使用完全一致的遍历顺序和空节点标记规则**。
*/
//: [下一题](@next)
