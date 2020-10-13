//: [Previous](@previous)

import Foundation

enum RBool {
    case rTrue,rFalse
}

/*:
 “布尔字面量转换协议”
 Bool to 自定义类型
 */

extension RBool: ExpressibleByBooleanLiteral {
    typealias BooleanLiteralType = Bool
    
    init(booleanLiteral value: RBool.BooleanLiteralType) {
        self = value ? .rTrue : .rFalse
    }
}

var rb: RBool = true // 没有准守上面的 “布尔字面量转换协议” 是不行的

/*:
 
 自定义类型 to Bool
 */
extension RBool: BooleanVue {
    
}


//if rb {
//    print("成功")
//}



//: [Next](@next)
