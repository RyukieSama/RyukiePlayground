//: [Previous](@previous)

import Foundation

struct Tool {
    var sa: StructA?
    var ab: StructB?
}

struct StructA: StructProtocol {
    
}

struct StructB: StructProtocol {
    
}

protocol StructProtocol {
    func creatStruct<T: StructProtocol>() -> T?
}

extension StructProtocol {
    func creatStruct<T: StructProtocol>() -> T? { return nil }
}









//: [Next](@next)
