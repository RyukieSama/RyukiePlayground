//: [Previous](@previous)

import Foundation

/*:
 [剑指 Offer 09. 用两个栈实现队列](https://leetcode.cn/problems/yong-liang-ge-zhan-shi-xian-dui-lie-lcof/description/?favorite=xb9nqhhg)
 */

var greeting = "Hello, playground"

class CQueue {
    var stackA: [Int] = []
    var stackB: [Int] = []
    
    
    init() {

    }
    
    func appendTail(_ value: Int) {
        stackA.append(value)
    }
    
    func deleteHead() -> Int {
        if stackB.isEmpty {
            while let last = stackA.popLast() {
                stackB.append(last)
            }
        }
        return stackB.popLast() ?? -1
    }
}

//: [Next](@next)
