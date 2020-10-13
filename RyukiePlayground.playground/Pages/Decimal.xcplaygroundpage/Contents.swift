//: [Previous](@previous)

import Foundation

let numberA: Double = 0.9999999999999
let numberB: Int = 2


let numberC = numberA * Double(numberB)


func decimalAdd(value: Double, addValue: Double) -> String {
    let decimalA = Decimal(value)
    let decimalB = Decimal(addValue)
    return (decimalA+decimalB).string
}





//: [Next](@next)
