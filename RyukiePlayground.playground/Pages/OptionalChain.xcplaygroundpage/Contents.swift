//: [Previous](@previous)

/*:
 ### 可选链
 */

import Foundation

extension Dictionary {
    func valuesForKeys(keys: [Key]) -> [Value?] {
        return keys.map { self[$0] }
        // 说明了为什么Swift没有提供轻量级的API接口，因为小伙伴们简单的调用map就可以实现。
    }
}

let testDictionary = [ "1" : "One",
    "2" : "Two",
    "3" : "Three",
    "4" : "Four",
    "5" : "Five"
]

let result1 = testDictionary.valuesForKeys(keys: ["1","5"]).last
print(result1) // Optional(Optional("Five")) last 的返回值也是 ？的

let result2 = testDictionary.valuesForKeys(keys: ["1","5","6"]).last
print(result2) // Optional(nil)

let result3 = testDictionary.valuesForKeys(keys: ["1","5"])
print(result3) // [Optional("One"), Optional("Five")]

//: [Next](@next)
