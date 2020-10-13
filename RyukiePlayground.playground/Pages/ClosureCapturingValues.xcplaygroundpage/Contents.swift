//: [Previous](@previous)

import Foundation

func increase(number: Int) -> () -> Int {
    var myNumber = 0
    
    func add() -> Int {
        myNumber += number
        print("\(myNumber)")
        return myNumber
    }
    
    return add
}

let addTwo = increase(number: 2)
addTwo() //2
addTwo() //4
addTwo() //6
addTwo() //8
addTwo() //10


//: [Next](@next)
