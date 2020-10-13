//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

let randomStringCharacters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

func randomString(length : Int) -> String {
    var ranStr = ""
    for _ in 0..<length {
        let index = Int(arc4random_uniform(UInt32(randomStringCharacters.count)))
        ranStr.append(randomStringCharacters[randomStringCharacters.index(randomStringCharacters.startIndex, offsetBy: index)])
    }
    return ranStr
}

let string = randomString(length: 32)

//: [Next](@next)
