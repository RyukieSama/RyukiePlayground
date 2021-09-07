import Foundation

public class ComplexListNode {
    public var val: Int
    public var next: ComplexListNode?
    public var random: ComplexListNode?
    public init(_ val: Int) {
        self.val = val
        next = nil
        random = nil
    }
}
