//: [Previous](@previous)

import Foundation

protocol DescriptionProtocol {
    var name: String { get }
    func printDescription()
}

extension DescriptionProtocol {
    func printDescription() {
        print("我是：\(name)")
    }
}

class Apple: DescriptionProtocol {
    var name: String {
        return "苹果"
    }
    
    func printDescription() {
        print("\(name)好好吃啊！")
    }
}

class People: DescriptionProtocol {
    var name: String {
        return "人类"
    }
    
    func printDescription() {
        print("\(name)真有意思！")
    }
}

let aApple = Apple()

let aPeople = People()

// 调用了Class内定义的方法
aApple.printDescription()
aPeople.printDescription()

func showDescription(of: DescriptionProtocol) {
    of.printDescription()
}

showDescription(of: aApple)
showDescription(of: aPeople)



//: [Next](@next)
