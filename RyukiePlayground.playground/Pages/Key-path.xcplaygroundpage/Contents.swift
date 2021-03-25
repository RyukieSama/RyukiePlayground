//: [Previous](@previous)

import Foundation

// https://swiftgg.gitbook.io/swift/yu-yan-can-kao/04_expressions#key-path-expression

struct KeyPathItemStruct {
    var name: String
    var number: Int
}

struct KeyPathStruct {
    var items: [KeyPathItemStruct]
    var title: String
}

let data = KeyPathStruct(items: [
    KeyPathItemStruct(name: "Jack01", number: 24),
    KeyPathItemStruct(name: "Jack02", number: 27),
    KeyPathItemStruct(name: "Jack03", number: 35),
    KeyPathItemStruct(name: "Jack04", number: 25),
    KeyPathItemStruct(name: "Jack05", number: 42)
],
title: "Endless")

let value = data[keyPath: \.items[0].name]

let value1 = data[keyPath: \.self]

let value2 = data.items[keyPath: \[KeyPathItemStruct].[3]]

//: [Next](@next)
