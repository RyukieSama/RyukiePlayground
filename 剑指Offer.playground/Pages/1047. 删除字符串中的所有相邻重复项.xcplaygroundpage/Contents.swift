//: [Previous](@previous)

import Foundation

/*:
 [1047. 删除字符串中的所有相邻重复项](https://leetcode.cn/problems/remove-all-adjacent-duplicates-in-string/)
 */
var str = "abbaca"

/**
 2023-02-24
 */
func removeDuplicates23224(_ s: String) -> String {
    var charArray = Array(s), res: [Character] = []
    
    for chr in charArray {
        if let last = res.last, last == chr {
            res.removeLast()
        }
        else {
            res.append(chr)
        }
    }
    
    return String(res)
}

removeDuplicates23224(str)

/**
 2023-02-24
 超时了
 */
func removeDuplicates(_ s: String) -> String {
    guard s.count >= 2 else {
        return s
    }
    
    var charArray = Array(s), left = 0, right = 1
    while left < right, right < charArray.count {
        let leftVal = charArray[left], rightVal = charArray[right]
        if leftVal == rightVal {
            charArray.remove(at: right)
            charArray.remove(at: left)
        }
        else {
            left += 1
            right += 1
        }
    }
    
    let res = String(charArray)
    return s.count > res.count ? removeDuplicates(res) : res
}
removeDuplicates(str)

//: [Next](@next)
