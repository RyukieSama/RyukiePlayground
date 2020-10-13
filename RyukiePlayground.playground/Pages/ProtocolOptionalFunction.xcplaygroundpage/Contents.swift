//: [Previous](@previous)

import Foundation


protocol MotherProtocol {
    // optional func textFun() //不能用 optional 修饰
//    func optionalText() // 默认是必须实现的
}

//这样相当于 Optional 了
extension MotherProtocol {
    func giveBirthToBaby() {}
}

class Mother : MotherProtocol {
    func giveBirthToBaby() {
        print(#function)
    }
}

let mo = Mother()
mo.giveBirthToBaby()

//: [Next](@next)
