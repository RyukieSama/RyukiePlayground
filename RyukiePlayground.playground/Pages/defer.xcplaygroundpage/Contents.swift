//: [Previous](@previous)

import Foundation


/// defer Stack
func deferStack() {
    defer { print("wash the dishes") }
    defer { print("take out the recycling") }
    defer { print("clean the refrigerator") }
    
    print("play videogames")
}
deferStack()

/// 嵌套 defer
func deferInDefer() {
    print("Start")
    defer {
        print("outerDefer Uper")
        defer { print("I`m in defer") }
        print("outerDefer Down")
    }
    print("End")
}

deferInDefer()

/// defer 中变量取值
func deferValue(name: String?) {
    var value = ""
    defer {
        print(value)
    }
    guard name != nil else {
        value = "未知对象"
        return
    }
}

deferValue(name: nil)

//: [Next](@next)
