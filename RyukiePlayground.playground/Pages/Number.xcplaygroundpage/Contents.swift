//: [Previous](@previous)

import UIKit

let helloWorld = "Hello, World!"
let subStringTo5 = String(helloWorld[..<helloWorld.index(helloWorld.startIndex, offsetBy: 5)])
print("subStringTo5: \(subStringTo5)")


//字符串范围截取
let num = "8888888.9999999"
let deRange = num.range(of: ".")

//FIXME:按某个字符串截取

//截取小数点前字符(不包含小数点)  123
let wholeNumber = num.prefix(upTo: deRange!.lowerBound)
//截取小数点后字符(不包含小数点) 45
let backNumber = num.suffix(from: deRange!.upperBound)
//截取小数点前字符(包含小数点) 123.
let wholeNumbers = num.prefix(upTo: deRange!.upperBound)
//截取小数点后字符(包含小数点) .45
let backNumbers = num.suffix(from: deRange!.lowerBound)



//
////FIXME:删除字符串中的某部分  Ho
//str = "Hello"
//let startIndex = str.index(str.startIndex, offsetBy: 1)
//let endIndex = str.index(str.startIndex, offsetBy: 3)
//str.removeSubrange(startIndex...endIndex)
////替换字符串  Hnewo
//var sig = "Hello"
//sig.replacingCharacters(in: startIndex...endIndex, with: "new")

//: [Next](@next)
