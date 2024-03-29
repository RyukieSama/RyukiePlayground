import Foundation

public struct SwiftPriorityQueue<Element> {
    private let _hasHigherPriority: (Element, Element) -> Bool
    private let _isEqual: (Element, Element) -> Bool

    private var _elements = [Element]()

    public init(hasHigherPriority: @escaping (Element, Element) -> Bool, isEqual: @escaping (Element, Element) -> Bool) {
        _hasHigherPriority = hasHigherPriority
        _isEqual = isEqual
    }

    public mutating func enqueue(_ element: Element) {
        _elements.append(element)
        bubbleToHigherPriority(_elements.count - 1)
    }

    public func peek() -> Element? {
        return _elements.first
    }
    
    public func array() -> [Element] {
        return _elements
    }

    public var isEmpty: Bool {
        return _elements.count == 0
    }
    
    public var count: Int {
        return _elements.count
    }

    public mutating func dequeue() -> Element? {
        guard let front = peek() else {
            return nil
        }

        removeAt(0)

        return front
    }

    public mutating func remove(_ element: Element) {
        for i in 0 ..< _elements.count {
            if _isEqual(_elements[i], element) {
                removeAt(i)
                return
            }
        }
    }

    private mutating func removeAt(_ index: Int) {
        let removingLast = index == _elements.count - 1
        if !removingLast {
            _elements.swapAt(index, _elements.count - 1)
        }

        _ = _elements.popLast()

        if !removingLast {
            bubbleToHigherPriority(index)
            bubbleToLowerPriority(index)
        }
    }

    private mutating func bubbleToHigherPriority(_ initialUnbalancedIndex: Int) {
        precondition(initialUnbalancedIndex >= 0)
        precondition(initialUnbalancedIndex < _elements.count)

        var unbalancedIndex = initialUnbalancedIndex

        while unbalancedIndex > 0 {
            let parentIndex = (unbalancedIndex - 1) / 2
            guard _hasHigherPriority(_elements[unbalancedIndex], _elements[parentIndex]) else { break }
            _elements.swapAt(unbalancedIndex, parentIndex)
            unbalancedIndex = parentIndex
        }
    }

    private mutating func bubbleToLowerPriority(_ initialUnbalancedIndex: Int) {
        precondition(initialUnbalancedIndex >= 0)
        precondition(initialUnbalancedIndex < _elements.count)

        var unbalancedIndex = initialUnbalancedIndex
        while true {
            let leftChildIndex = unbalancedIndex * 2 + 1
            let rightChildIndex = unbalancedIndex * 2 + 2

            var highestPriorityIndex = unbalancedIndex

            if leftChildIndex < _elements.count && _hasHigherPriority(_elements[leftChildIndex], _elements[highestPriorityIndex]) {
                highestPriorityIndex = leftChildIndex
            }

            if rightChildIndex < _elements.count && _hasHigherPriority(_elements[rightChildIndex], _elements[highestPriorityIndex]) {
                highestPriorityIndex = rightChildIndex
            }

            guard highestPriorityIndex != unbalancedIndex else { break }
            _elements.swapAt(highestPriorityIndex, unbalancedIndex)

            unbalancedIndex = highestPriorityIndex
        }
    }
}

extension SwiftPriorityQueue : CustomDebugStringConvertible {
    public var debugDescription: String {
        return _elements.debugDescription
    }
}
