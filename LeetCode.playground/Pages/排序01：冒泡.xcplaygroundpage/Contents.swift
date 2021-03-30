//: [Previous](@previous)

import Foundation

var nums = [12, 3, 6, 1, 19, 2, 7, 8, 11, 23, 5]

func b1(arr: [Int]) -> [Int] {
    var tempArr = arr
    if tempArr.isEmpty {
        return tempArr
    }
    for index in 0..<tempArr.count {
        for subIndex in 0..<(tempArr.count - index - 1) {
            if tempArr[subIndex + 1] > tempArr[subIndex] {
                // 通过元祖进行交换
//                (tempArr[subIndex], tempArr[subIndex + 1]) = (tempArr[subIndex + 1], tempArr[subIndex])
                // swapAt进行交换
                tempArr.swapAt(subIndex, subIndex + 1)
            }
        }
    }
    return tempArr
}

b1(arr: nums)

//: [Next](@next)
