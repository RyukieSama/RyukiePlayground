//: [Previous](@previous)

import Foundation

/*:
 
 在字符串 s 中找出第一个只出现一次的字符。如果没有，返回一个单空格。 s 只包含小写字母。
 
 示例 1:
 
 输入：s = "abaccdeff"
 
 输出：'b'
 
 示例 2:
 
 输入：s = ""
 
 输出：' '
  
 
 限制：
 
 0 <= s 的长度 <= 50000
 
 
 
 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/di-yi-ge-zhi-chu-xian-yi-ci-de-zi-fu-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */
var s = "abaccdeff"
s = "aadadaad"

/**
 2023-02-11
 */
func firstUniqChar23211(_ s: String) -> Character {
    var charArray: [Character] = Array(s)
    var dic: [Character: Bool] = [:]
    
    charArray.forEach {
        if let _ = dic[$0] {
            dic[$0] = false
        }
        else {
            dic[$0] = true
        }
    }
    
    // 字典是无序的，再遍历一边原字符串，对比dic 进行对比判断
    for c in charArray {
        if dic[c] == true {
            return c
        }
    }
    
    return " "
}



func firstUniqChar(_ s: String) -> Character {
    let strArr = Array(s)
    var dp: [Character : Int] = [:]
    var indexs: [Character] = []
    
    strArr.forEach {
        if dp[$0] != nil {
            if let idx = indexs.firstIndex(of: $0) {
                indexs.remove(at: idx)                
            }
        }
        else {
            dp[$0] = 1
            indexs.append($0)
        }
    }
    
    return indexs.first ?? " "
}

firstUniqChar(s)

//: [Next](@next)
