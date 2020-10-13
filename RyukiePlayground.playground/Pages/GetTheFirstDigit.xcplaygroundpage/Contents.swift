//: [Previous](@previous)

import Foundation

var num: Int64 = 6245723466234

func getTheFirstDigit(from: Int64) -> Int64 {
    var value = from
    while value >= 10 {
        value /= 10
    }
    return value
}

getTheFirstDigit(from: num)

//: [Next](@next)
