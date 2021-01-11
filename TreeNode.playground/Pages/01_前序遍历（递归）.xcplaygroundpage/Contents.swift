//: [Previous](@previous)

import Foundation

let tree = MockTree.mock()

func preOrder(tree: TreeNode) {
    print("\(tree.val)")
    if let left = tree.left {
        preOrder(tree: left)
    }
    
    if let right = tree.right {
        preOrder(tree: right)
    }
}

preOrder(tree: tree)

//: [Next](@next)
