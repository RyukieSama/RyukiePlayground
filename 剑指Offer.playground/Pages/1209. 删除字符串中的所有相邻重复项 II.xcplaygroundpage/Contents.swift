//: [Previous](@previous)

import Foundation

/*:
 [1209. 删除字符串中的所有相邻重复项 II](https://leetcode.cn/problems/remove-all-adjacent-duplicates-in-string-ii/)
 */
var s = "deeedbbcccbdaa", k = 3
s = "pbbcggttciiippooaais"
k = 2
s = "yfttttfbbbbnnnnffbgffffgbbbbgssssgthyyyy"
k = 4

/**
 2023-02-24
 */
func removeDuplicates23224(_ s: String, _ k: Int) -> String {
    guard s.count > 0, k < s.count else {
        return s
    }
    var charArray = Array(s),
        res: [Character] = [],
        countStack: [Int] = []// 重复个数栈
    
    for chr in charArray {
        if let lastChar = res.last, let lastCount = countStack.last, lastChar == chr {
            if lastCount == k - 1 {
                // 重复够了，移除
                countStack.removeLast()
                for _ in 0..<lastCount {
                    res.removeLast()
                }
            }
            else {
                res.append(chr)
                countStack[countStack.count - 1] = lastCount + 1
            }
        }
        else {
            res.append(chr)
            countStack.append(1)
        }
    }
        
    return String(res)
}
removeDuplicates23224(s, k)

/**
 2023-02-24
 超时了居然。。。
 */
func removeDuplicates(_ s: String, _ k: Int) -> String {
    guard s.count > 0, k < s.count else {
        return s
    }
    var charArray = Array(s), blockArray: [String] = []
    
    for chr in charArray {
        if let lastBlock = blockArray.last, let lastChr = lastBlock.last, lastChr == chr {
            if lastBlock.count == k - 1 {
                // 到极限了，移除
                blockArray.removeLast()
            }
            else {
                // 还能加
                blockArray[blockArray.count - 1] = "\(lastBlock)\(chr)"
            }
        }
        else {
            blockArray.append(String(chr))
        }
    }
        
    var res = ""
    blockArray.forEach {
        res += $0
    }
    return res
}

removeDuplicates(s, k)
//: [Next](@next)
