//: [Previous](@previous)

import Foundation

/*:
 定义栈的数据结构，请在该类型中实现一个能够得到栈的最小元素的 min 函数在该栈中，调用 min、push 及 pop 的时间复杂度都是 O(1)。
  
 示例:
 
 ```C++
 MinStack minStack = new MinStack();
 minStack.push(-2);
 minStack.push(0);
 minStack.push(-3);
 minStack.min();   --> 返回 -3.
 minStack.pop();
 minStack.top();      --> 返回 0.
 minStack.min();   --> 返回 -2.
 ```
 
 提示：
 
 各函数的调用总次数不超过 20000 次
  
 
 注意：本题与主站 155 题相同：https://leetcode-cn.com/problems/min-stack/
 
 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/bao-han-minhan-shu-de-zhan-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/**
 2023-03-03
 */
class MinStack230303 {
    var stack: [Int] = []
    // 累计最小的元素
    var small: [Int] = []
    
    /** initialize your data structure here. */
    init() {

    }

    func push(_ x: Int) {
        stack.append(x)
        if let smallTop = small.last {
            if smallTop >= x {
                small.append(x)
            }
        }
        else {
            small.append(x)
        }
    }

    func pop() {
        guard let top = stack.popLast() else {
            return
        }
        if let topSmall = small.last, topSmall == top {
            small.removeLast()
        }
    }

    func top() -> Int {
        stack.last ?? 0
    }

    func min() -> Int {
        small.last ?? 0
    }
}

/**
 2023-02-07
 */
class MinStack2327 {
    var stack: [Int] = []
    /**
     把相对较小的暂存起来，每次移除的时候查下，如果移除的邮箱等的就也同步出栈
     */
    var small: [Int] = []
    /** initialize your data structure here. */
    init() {

    }
    
    func push(_ x: Int) {
        stack.append(x)
        if let top = small.last {
            if top >= x {
                small.append(x)
            }
        }
        else {
            small.append(x)
        }
    }
    
    func pop() {
        if let top = stack.last, let topSmall = small.last, topSmall == top {
            small.removeLast()
        }
        stack.removeLast()
    }
    
    func top() -> Int {
        stack.last ?? 0
    }
    
    func min() -> Int {
        small.last ?? 0
    }
}

var minStack2327 = MinStack2327()
minStack2327.push(-2)
minStack2327.push(0)
minStack2327.push(-3)
minStack2327.min()
minStack2327.pop()
minStack2327.top()
minStack2327.min()


/**
 2023-02-06
 
 */

// 复杂度不符合要求
//class MinStack2326 {
//
//    var stack: [Int] = []
//    var minEl: Int?
//
//    /** initialize your data structure here. */
//    init() {
//
//    }
//
//    func push(_ x: Int) {
//        stack.append(x)
//        minEl = nil
//    }
//
//    func pop() {
//        stack.removeLast()
//        minEl = nil
//    }
//
//    private func findMin() -> Int {
//        var arr = stack
//        var length = arr.count
//
//        for i in 0..<length {
//            let l = length - i
//            for j in 0..<l {
//                if j + 1 < l {
//                    if arr[j] > arr[j + 1] {
//                        arr.swapAt(j, j+1)
//                    }
//                }
//            }
//        }
//
//        let res = arr.first ?? 0
//        print(arr)
//        print(stack)
//        minEl = res
//        return res
//    }
//
//    func top() -> Int {
//        return stack.last ?? 0
//    }
//
//    func min() -> Int {
//        // 类似于懒加载
//        return minEl ?? findMin()
//    }
//}

//var minStack2326 = MinStack2326()
//minStack2326.push(-2)
//minStack2326.push(0)
//minStack2326.push(-3)
//minStack2326.min()
//minStack2326.pop()
//minStack2326.top()
//minStack2326.min()

class MinStack2326 {
    var stack: [Int] = []
    var small: [Int] = []
    /** initialize your data structure here. */
    init() {

    }
    
    func push(_ x: Int) {
        stack.append(x)
        if small.last == nil {
            small.append(x)
        }
        else if let min = small.last, min >= x {
            small.append(x)
        }
    }
    
    func pop() {
        let leave = stack.removeLast()
        if leave == small.last {
            small.removeLast()
        }
    }
    
    func top() -> Int {
        return stack.last ?? 0
    }
    
    func min() -> Int {
        return small.last ?? 0
    }
}

var minStack2326 = MinStack2326()
minStack2326.push(-2)
minStack2326.push(0)
minStack2326.push(-3)
minStack2326.min()
minStack2326.pop()
minStack2326.top()
minStack2326.min()


class MinStack {
    
    var elements: [Int] = []
    
    var smaller: [Int] = []
    
    init() {
        
    }
    
    func push(_ x: Int) {
        elements.append(x)
        if smaller.last == nil || smaller.last ?? 0 >= x {
            smaller.append(x)
        }
    }
    
    func pop() {
        if elements.removeLast() == smaller.last {
            smaller.removeLast()
        }
    }
    
    func top() -> Int {
        return elements.last ?? 0
    }
    
    func min() -> Int {
        return smaller.last ?? 0
    }
}

var minStack = MinStack()
minStack.push(-2)
minStack.push(0)
minStack.push(-3)
minStack.min()
minStack.pop()
minStack.top()
minStack.min()

//: [Next](@next)
