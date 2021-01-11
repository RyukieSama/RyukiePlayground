import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}


public struct MockTree {
    public static  let root = TreeNode(10)

    static let root01 = TreeNode(6)

    static let root02 = TreeNode(14)

    static let root11 = TreeNode(4)

    static let root12 = TreeNode(8)

    static let root13 = TreeNode(12)

    static let root14 = TreeNode(16)

    public static func mock() -> TreeNode {
        root.left = root01
        root.right = root02

        root01.left = root11
        root01.right = root12

        root02.left = root13
        root02.right = root14
        
        return root
    }
}
