//: [Previous](@previous)

import Foundation

class Bar {
    init(numbers: [Int], title: String) {
        items = numbers
        name = title
    }
    var items: [Int]
    var name: String
}

var level: Int = 6
var aBar = Bar(numbers: [], title: "B")

for index in 1...level {
    aBar.items.append(index)
}

var bBar = Bar(numbers: [], title: "B")
var cBar = Bar(numbers: [], title: "C")

func hhhh(from: Bar, buffer: Bar, to: Bar) {
    if from.items.count == 1 {
        print("\(from.name) -> \(to.name)")
    }
    else {
        
    }
}




//: [Next](@next)
