//: [Previous](@previous)

/*:
 ## 数据模型转字典
 
 > [不同角度看问题 - 从 Codable 到 Swift 元编程 by.onevcat](https://mp.weixin.qq.com/s/-JTjXBacgzK5qCToCOBNkg)
 
 > 在 Swift 4 引入 Codable 之后，我们有更优秀的方式来做这件事：那就是将 Cat 声明为 Codable (或者至少声明为 Encodable - 记住 Codable 其实就是 Decodable &amp; Encodable)，然后使用相关的 encoder 来进行编码。不过 Swift 标准库中并没有直接将一个对象编码为字典的编码器，我们可以进行一些变通，先将需要处理的类型声明为 Codable，然后使用 JSONEncoder 将其转换为 JSON 数据，最后再从 JSON 数据中拿到对应的字典.
 
 > 这种方法已经足够优秀了，它没有添加任何难以理解的部分，我们只需要将 encoder 在全局进行统一的配置，然后用它来对任意 Codable 进行编码即可。唯一美中不足的是，JSONEncoder 本身其实在内部就是先编码为字典，然后再从字典转换为数据的。在这里我们又“多此一举”地将数据转换回字典，稍显浪费。但是在非瓶颈的代码路径上，这一点性能损失完全可以接受的。
 
 */

import Foundation

struct Cat {
    let name: String
    let age: Int
}


let kitten = Cat(name: "kitten", age: 2)
let mirror = Mirror(reflecting: kitten)
for child in mirror.children {
    print("\(child.label!) - \(child.value)")
}

/*:
 ## 字典协议
 -----
 */

protocol DictionaryValueProtocol {
    var value: Any { get }
}

extension DictionaryValueProtocol {
    var value: Any {
        let mirror = Mirror(reflecting: self)
        var result = [String: Any]()
        for child in mirror.children {
            // 如果无法获得正确的 key，报错
            guard let key = child.label else {
                fatalError("Invalid key in child: \(child)")
            }
            // 如果 value 无法转换为 DictionaryValueProtocol，报错
            if let value = child.value as? DictionaryValueProtocol {
                result[key] = value.value
            } else {
                fatalError("Invalid value in child: \(child)")
            }
        }
        return result
    }
}

extension Int: DictionaryValueProtocol { var value: Any { return self } }
extension Int8: DictionaryValueProtocol { var value: Any { return self } }
extension Int16: DictionaryValueProtocol { var value: Any { return self } }
extension Int32: DictionaryValueProtocol { var value: Any { return self } }
extension Int64: DictionaryValueProtocol { var value: Any { return self } }
extension Float: DictionaryValueProtocol { var value: Any { return self } }
extension Double: DictionaryValueProtocol { var value: Any { return self } }
extension String: DictionaryValueProtocol { var value: Any { return self } }
extension Bool: DictionaryValueProtocol { var value: Any { return self } }

extension Cat: DictionaryValueProtocol {
    
}

print(kitten.value)

/*:
 ## 嵌套
 -----
 */
struct Wizard: DictionaryValueProtocol {
    let name: String
    let cat: Cat
}

let wizard = Wizard(name: "Hermione", cat: kitten)
print(wizard.value)

/*:
 ## 集合
 -----
 */

extension Array: DictionaryValueProtocol where Element: DictionaryValueProtocol {
    var value: Any { return map { $0.value } }
}

extension Dictionary: DictionaryValueProtocol where Value: DictionaryValueProtocol {
    var value: Any { return mapValues { $0.value } }
}

struct Gryffindor: DictionaryValueProtocol {
    let wizards: [Wizard]
}

let crooks = Cat(name: "Crookshanks", age: 2)
let hermione = Wizard(name: "Hermione", cat: crooks)

let hedwig = Cat(name: "hedwig", age: 3)
let harry = Wizard(name: "Harry", cat: hedwig)
let gryffindor = Gryffindor(wizards: [harry, hermione])

print(gryffindor.value)

/*:
 > Mirror 很 cool，它让我们可以在运行时探索和列举实例的特性。除了上面用到的存储属性之外，对于集合类型，多元组以及枚举类型，Mirror 都可以对其进行探索。强大的运行时特性，也意味着额外的开销。Mirror 的文档明确告诉我们，这个类型更多是用来在 Playground 和调试器中进行输出和观察用的。如果我们想要以高效的方式来处理字典转换问题，也许应该试试看其他思路。
 */

//: [Next](@next)
