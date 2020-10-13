//: [Previous](@previous)

import Foundation

// https://swifter.tips/indirect-nested-enum/

/**
 indirect 关键字
 由于 enum 是值类型的
 来提示编译器不要直接在值类型中直接嵌套
 http://fealonelei.github.io/2016/02/28/swift-里使用-indirect-enums-的持久化树.html
 */

indirect enum LinkedList<Element: Comparable> {
    case Empty
    case Node(Element, LinkedList<Element>)
    
    // 移除链表节点
    func linkedListRemoveElement(_ element: Element) -> LinkedList<Element> {
        guard case let .Node(value, next) = self else {
            return .Empty
        }
        return value == element ? next : LinkedList.Node(value, next.linkedListRemoveElement(element))
    }
    
}

let listA = LinkedList.Node(1,.Node(2,.Node(3,.Node(4,.Node(5,.Empty)))))

let listB = listA.linkedListRemoveElement(1)

//: [Next](@next)
