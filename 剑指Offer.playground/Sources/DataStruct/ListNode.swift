import Foundation

public class ListNode: Equatable {
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
//        guard let lObj = lhs as? AnyObject, let rObj = rhs as AnyObject
        Unmanaged.passUnretained(lhs).toOpaque() == Unmanaged.passUnretained(rhs).toOpaque()
    }
    
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}
