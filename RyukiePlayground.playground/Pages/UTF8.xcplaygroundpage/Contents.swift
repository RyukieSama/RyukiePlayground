//: [Previous](@previous)

import Foundation

var str = "Hello,playground哈哈"

func toUTF8(string: String) -> String? {
    guard let stringA = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
        return nil
    }
    
    return stringA
}

let utf8String = toUTF8(string: str)

//: [Next](@next)
