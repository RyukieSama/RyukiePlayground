//: [Previous](@previous)

import Foundation

/*:
 输入两个整数序列，第一个序列表示栈的压入顺序，请判断第二个序列是否为该栈的弹出顺序。假设压入栈的所有数字均不相等。
 
 例如，序列 {1,2,3,4,5} 是某栈的压栈序列，序列 {4,5,3,2,1} 是该压栈序列对应的一个弹出序列，但 {4,3,5,1,2} 就不可能是该压栈序列的弹出序列。
  
 
 示例 1：
 
 * 输入：pushed = [1,2,3,4,5], popped = [4,5,3,2,1]
 * 输出：true
 
 ***解释：我们可以按以下顺序执行：***
 
 push(1), push(2), push(3), push(4), pop() -> 4,
 
 push(5), pop() -> 5, pop() -> 3, pop() -> 2, pop() -> 1
 
 示例 2：
 
 * 输入：pushed = [1,2,3,4,5], popped = [4,3,5,1,2]
 * 输出：false
 
 解释：1 不能在 2 之前弹出。
 
 提示：
 
 0 <= pushed.length == popped.length <= 1000
 
 0 <= pushed[i], popped[i] < 1000
 
 pushed 是 popped 的排列。
 
 注意：本题与主站 946 题相同：https://leetcode-cn.com/problems/validate-stack-sequences/
 
 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/zhan-de-ya-ru-dan-chu-xu-lie-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

var pushed = [1,2,3,4,5]
var popped = [4,3,5,1,2]

//pushed = [1,2,3,4,5]
//popped = [4,5,3,2,1]

//pushed = [2, 1, 0]
// popped = [1, 2, 0]

//pushed = [2,3,0,1]
//popped = [0,3,2,1]

/**
 2023-03-03
 */
func validateStackSequences230304(_ pushed: [Int], _ popped: [Int]) -> Bool {
    guard pushed.isEmpty == false, popped.isEmpty == false else {
        return true
    }
    
    var pushIdx = 0, popIdx = 0, pushed = pushed, popped = popped
    
    while pushIdx < pushed.count, popIdx < popped.count, popIdx >= 0, pushIdx >= 0 {
        let pushVal = pushed[pushIdx], popVal = popped[popIdx]
//        print("push = \(pushVal) pop = \(popVal)")
        if pushVal == popVal {
            pushed.remove(at: pushIdx)
            if pushIdx > 0 { // 注意这个边界条件，很容易越界
                pushIdx -= 1
            }
            popIdx += 1
        }
        else {
            pushIdx += 1
        }
    }
//    print("pushIdx = \(pushIdx) popIdx = \(popIdx)")
    // pop 干净了就是 true
    return popIdx == popped.count
}
validateStackSequences230304(pushed, popped)


/**
 2023-02-07
 */
func validateStackSequences2327(_ pushed: [Int], _ popped: [Int]) -> Bool {
    var needPop = popped, needPush = pushed
    var temp: [Int] = []
    //操作数组元素，效率低点儿，还是直接用 index， 不remove 效率高点儿
    while let popVal = needPop.first {
        if let p = needPush.first, p == popVal {
            needPop.removeFirst()
            needPush.removeFirst()
        }
        else if let tTop = temp.last, tTop == popVal {
            temp.removeLast()
            needPop.removeFirst()
        }
        else if let v = needPush.first {
            temp.append(v)
            needPush.removeFirst()
        }
        else {
            return false
        }
    }
    
    return temp.isEmpty
}

validateStackSequences2327(pushed, popped)

/**
 2023-02-06
 */

func validateStackSequences2326(_ pushed: [Int], _ popped: [Int]) -> Bool {
    if pushed.isEmpty || popped.isEmpty {
        return true
    }
    var stack: [Int] = []
    var indexPush = 0, indexPop = 0
    
    while indexPop < popped.count {
        let needPop = popped[indexPop]
        if let top = stack.last, top == needPop {
            stack.removeLast()
            indexPop += 1
        }
        else if indexPush < pushed.count {
            stack.append(pushed[indexPush])
            indexPush += 1
        }
        else {
            return false
        }

//        print("stack = \(stack), indexPush = \(indexPush), indexPop = \(indexPop)")
    }
    
    return stack.isEmpty
}

// ❌
//func validateStackSequences2326(_ pushed: [Int], _ popped: [Int]) -> Bool {
//    if pushed.isEmpty || popped.isEmpty {
//        return true
//    }
//    var stack: [Int] = []
//    var pushIdx = 0, popIdx = 0
//
//    // 遍历 push 栈
//    while pushIdx < pushed.count, popIdx < popped.count - 1 {
//        if pushed[pushIdx] != popped[popIdx] {
//            if popped[popIdx] == stack.last {
//                stack.removeLast()
//                popIdx += 1
//            }
//            stack.append(pushed[pushIdx])
//        }
//        else {
//            popIdx += 1
//        }
//        pushIdx += 1
//        print(stack)
//    }
//
//    if stack.isEmpty {
//        return true
//    }
//
//    pushIdx = stack.count - 1
//    // 遍历 stack 栈，这里面剩的就全部都是要 pop 的，必须每个都对上才 true
//    while pushIdx >= 0, popIdx < popped.count - 1 {
//        if stack[pushIdx] == popped[popIdx] {
//            stack.removeLast()
//            pushIdx -= 1
//            popIdx += 1
//        }
//        else {
//            return false
//        }
//    }
//
//    return true
//}

validateStackSequences2326(pushed, popped)


func validateStackSequences(_ pushed: [Int], _ popped: [Int]) -> Bool {
    if pushed.isEmpty {
        return true
    }
    
    var result: [Int] = [], pA = 0, pB = 0
    
    while pB < popped.count {
        let b = popped[pB]
        
        if let top = result.last, top == b {
            result.removeLast()
            pB += 1
        }
        else if pA < pushed.count {
            let a = pushed[pA]
            result.append(a)
            pA += 1
        }
        else {
            return false
        }
    }
    
    return result.isEmpty
}

validateStackSequences(pushed, popped)

//: [Next](@next)
