//: [Previous](@previous)

import Foundation

var stringList = ["Ryukie", "Wang", "Ak", "Qq", "Tim"]

// 对于字符串中的字符来说，"大于" 表示 "按照字母顺序较晚出现"。 这意味着字母"B"大于字母"A"，字符串"S"大于字符串"D"。 其将进行字母逆序排序，"AT"将会排在"AE"之前。

func backwards(stringOne: String, stringTwo: String) -> Bool {
    return stringOne > stringTwo
}

/*:
 1. 闭包函数
 */
let result1 = stringList.sorted(by: backwards(stringOne:stringTwo:))

/*:
 2. 闭包表达式语法
 */
let result2 = stringList.sorted { (s1, s2) -> Bool in
    return s1 > s2
}

/*:
 3. 根据上下文推断类型
 */
let result3 = stringList.sorted { (s1, s2) in return s1 > s2 }

/*:
 4. 单表达式闭包隐式返回
 */
let result4 = stringList.sorted { (s1, s2) in s1 > s2 }

/*:
 5. 参数名称缩写
 */
let result5 = stringList.sorted { $0 > $1 }

/*:
 6. 运算符函数
 */
let result6 = stringList.sorted(by: >)

print(result6)

//: [Next](@next)
