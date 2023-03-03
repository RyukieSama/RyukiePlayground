//: [Previous](@previous)

/*:
 请实现一个函数，把字符串 s 中的每个空格替换成"%20"。

 示例 1：

 输入：s = "We are happy."
 
 输出："We%20are%20happy."

 限制：

 0 <= s 的长度 <= 10000
 
 链接：https://leetcode-cn.com/problems/ti-huan-kong-ge-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

let str = "We are happy."

/**
 2023-03-03
 */
func replaceSpace230303(_ s: String) -> String {
    var res = "", charArr = Array(s)
    
    for chr in charArr {
        if chr == " " {
            res += "%20"
        }
        else {
            res += String(chr)
        }
    }
    
    return res
}
replaceSpace230303(str)










/**
 2023-02-27
 */
func replaceSpace23227(_ s: String) -> String {
    var res = ""
    
    for c in s {
        if c == " " {
            res += "%20"
        }
        else {
            res += String(c)
        }
    }
    
    return res
}
replaceSpace23227(str)





func replaceSpace(_ s: String) -> String {
    // MARK: - 不使用系统API
    var temp = ""
    for c in s {
        if String(c) == " " {
            temp += "%20"
        }
        else {
            temp += String(c)
        }
    }
    return temp
}

replaceSpace(str)

//: [Next](@next)
