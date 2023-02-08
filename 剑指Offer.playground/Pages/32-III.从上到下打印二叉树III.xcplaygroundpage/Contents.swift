//: [Previous](@previous)

import Foundation

/*:
 请实现一个函数按照之字形顺序打印二叉树，即第一行按照从左到右的顺序打印，第二层按照从右到左的顺序打印，第三行再按照从左到右的顺序打印，其他行以此类推。
 
 例如:
 给定二叉树: [3,9,20,null,null,15,7],
 
 3
 / \
 9  20
 /  \
 15   7
 返回其层次遍历结果：
 
 [
 [3],
 [20,9],
 [15,7]
 ]
  
 
 提示：
 
 节点总数 <= 1000
 
 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/cong-shang-dao-xia-da-yin-er-cha-shu-iii-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
/**
 2023-02-08
 */
func levelOrder2328(_ root: TreeNode?) -> [[Int]] {
    var res: [[Int]] = []
    guard let root = root else { return res }
    var queue: [TreeNode] = [root]
    var temp: [Int] = []
    var currentLineCount = 1
    var nextLineCount = 0
    // 1 向右 -1 向左
    var dir = 1
    
    while let top = queue.first {
        dir > 0 ? temp.append(top.val) : temp.insert(top.val, at: 0)
        queue.removeFirst()
        currentLineCount -= 1
        
        if let left = top.left {
            queue.append(left)
            nextLineCount += 1
        }
        
        if let right = top.right {
            queue.append(right)
            nextLineCount += 1
        }
        
        if currentLineCount == 0 {
            currentLineCount = nextLineCount
            nextLineCount = 0
            dir *= -1
            if temp.isEmpty == false {
                res.append(temp)
                temp = []
            }
        }
    }
    
    if temp.isEmpty == false {
        res.append(temp)
    }
    return res
}


/**
 2023-02-07
 */

func levelOrder2327(_ root: TreeNode?) -> [[Int]] {
    var res: [[Int]] = []
    guard let root = root else { return res }
    var queue: [TreeNode] = [root]
    var temp: [Int] = []
    var leftCount = 1
    var nextCount = 0
    // 方向 1 向右 -1 向左
    var dir = 1
    
    while let top = queue.first {
        if dir > 0 {
            temp.append(top.val)
        }
        else {
            temp.insert(top.val, at: 0)
        }
        queue.removeFirst()
        leftCount -= 1
        
        if let left = top.left {
            queue.append(left)
            nextCount += 1
        }
        
        if let right = top.right {
            queue.append(right)
            nextCount += 1
        }
        
        if leftCount == 0 {
            leftCount = nextCount
            nextCount = 0
            dir *= -1 // 换行就转向
            if temp.isEmpty == false {
                res.append(temp)
                temp = []
            }
        }
        
    }
    
    if temp.isEmpty == false {
        res.append(temp)
    }
    
    return res
}


// 想当然的典型错误
//func levelOrderF(_ root: TreeNode?) -> [[Int]] {
//    var queue: [TreeNode] = []
//    var toBePrint = 0
//    var nextLevelCount = 0
//    var result: [[Int]] = []
//    var temp: [Int] = []
//
//    var flag = false
//
//    if let r = root {
//        queue.append(r)
//        toBePrint += 1
//    }
//
//    while queue.isEmpty == false {
//        if let first = queue.first {
//            temp.append(first.val)
//            queue.removeFirst()
//            toBePrint -= 1
//
//            if flag {
//                if let left = first.left {
//                    queue.append(left)
//                    nextLevelCount += 1
//                }
//
//                if let right = first.right {
//                    queue.append(right)
//                    nextLevelCount += 1
//                }
//            }
//            else {
//                if let right = first.right {
//                    queue.append(right)
//                    nextLevelCount += 1
//                }
//
//                if let left = first.left {
//                    queue.append(left)
//                    nextLevelCount += 1
//                }
//            }
//
//            if toBePrint == 0 {
//                result.append(temp)
//                temp = []
//
//                toBePrint = nextLevelCount
//                nextLevelCount = 0
//
//                flag.toggle()
//            }
//        }
//    }
//
//    return result
//}

//func levelOrderFF(_ root: TreeNode?) -> [[Int]] {
//    var queue: [TreeNode] = []
//    var queueB: [TreeNode] = []
//    var toBePrint = 0
//    var nextLevelCount = 0
//    var result: [[Int]] = []
//    var temp: [Int] = []
//
//    var flag = true
//
//    if let r = root {
//        queue.append(r)
//        toBePrint += 1
//    }
//
//    while queue.isEmpty == false {
//        var current: TreeNode?
//        if flag, let first = queue.first {
//            temp.append(first.val)
//            queue.removeFirst()
//            current = first
//        }
//        else if let last = queue.last {
//            temp.append(last.val)
//            queue.removeLast()
//            current = last
//        }
//
//        toBePrint -= 1
//
//        // 这里的基准错了，会乱
//        if let left = current?.left {
//            queueB.append(left)
//            nextLevelCount += 1
//        }
//
//        if let right = current?.right {
//            queueB.append(right)
//            nextLevelCount += 1
//        }
//
//        if toBePrint == 0 {
//            result.append(temp)
//            temp = []
//
//            toBePrint = nextLevelCount
//            nextLevelCount = 0
//
//            queue.append(contentsOf: queueB)
//            queueB = []
//
//            flag.toggle()
//            print("flag: \(flag)")
//            queue.forEach { print(" - \($0.val)") }
//        }
//
//    }
//
//
//    return result
//}

func levelOrder(_ root: TreeNode?) -> [[Int]] {
    var queue: [TreeNode] = []
    var toBePrint = 0
    var nextLevelCount = 0
    var result: [[Int]] = []
    var temp: [Int] = []
    
    var flag = true
    
    if let r = root {
        queue.append(r)
        toBePrint += 1
    }
    
    while queue.isEmpty == false, let first = queue.first {
        temp.append(first.val)
        queue.removeFirst()
        toBePrint -= 1
        
        if let left = first.left {
            queue.append(left)
            nextLevelCount += 1
        }
        
        if let right = first.right {
            queue.append(right)
            nextLevelCount += 1
        }
        
        if toBePrint == 0 {
            result.append(flag ? temp : temp.reversed())
            temp = []
            
            toBePrint = nextLevelCount
            nextLevelCount = 0
            flag.toggle()
        }
    }
    
    return result
}

// 别人的
func levelOrder2(_ root: TreeNode?) -> [[Int]] {
    if root == nil {
        return []
    }

    var list:[[Int]] = []
    var nList:[TreeNode] = [root!]
    var l = true
    while nList.isEmpty == false {
        let len = nList.count
        var n = nList.count
        var tempList:[TreeNode] = []
        var tempNum: [Int] = Array(repeating: 0, count: n)
        while n > 0 {
            let node = nList.removeFirst()
            tempNum[l == true ? len-n : n-1] = node.val
            if node.left != nil {
                tempList.append(node.left!)
            }
            
            if node.right != nil {
                tempList.append(node.right!)
            }
            n -= 1
        }
        
        list.append(tempNum)
        nList = tempList
        
        l = !l
    }
    
    return list
}

func levelOrder3(_ root: TreeNode?) -> [[Int]] {
    guard let r = root else {
        return []
    }
    
    var queue: [TreeNode] = []
    var queueB: [TreeNode] = []
    var toBePrint = 0
    var nextLevelCount = 0
    var result: [[Int]] = []
    var flag = true
    
    queue.append(r)
    toBePrint += 1
    
    var temp = Array(repeating: 0, count: queue.count)
    
    while queue.isEmpty == false {
        let first = queue.removeFirst()
        temp[flag ? (temp.count - toBePrint) : (toBePrint - 1)] = first.val
        toBePrint -= 1
        
        if let left = first.left {
            queueB.append(left)
            nextLevelCount += 1
        }
        
        if let right = first.right {
            queueB.append(right)
            nextLevelCount += 1
        }
        
        if toBePrint == 0 {
            result.append(temp)
            queue = queueB
            temp = Array(repeating: 0, count: nextLevelCount)
            
            toBePrint = nextLevelCount
            nextLevelCount = 0
            queueB = []
            flag.toggle()
        }
    }
    
    return result
}


let t1 = TreeNode(1)
let t2 = TreeNode(2)
let t3 = TreeNode(3)
let t4 = TreeNode(4)
let t5 = TreeNode(5)

t1.left = t2
t1.right = t3

t2.left = t4

t3.right = t5

//levelOrder(t1)

//levelOrder2(t1)

levelOrder3(t1)
//levelOrderF(t1)

//: [Next](@next)

