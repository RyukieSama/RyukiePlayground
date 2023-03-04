//: [Previous](@previous)

import Foundation

/*:
 输入一个英文句子，翻转句子中单词的顺序，但单词内字符的顺序不变。为简单起见，标点符号和普通字母一样处理。例如输入字符串"I am a student. "，则输出"student. a am I"。

  

 示例 1：

 输入: "the sky is blue"
 
 输出: "blue is sky the"
 
 示例 2：

 输入: "  hello world!  "
 
 输出: "world! hello"
 
 解释: 输入字符串可以在前面或者后面包含多余的空格，但是反转后的字符不能包括。
 
 示例 3：

 输入: "a good   example"
 
 输出: "example good a"
 
 解释: 如果两个单词间有多余的空格，将反转后单词间的空格减少到只含一个。

 说明：

 无空格字符构成一个单词。
 
 输入字符串可以在前面或者后面包含多余的空格，但是反转后的字符不能包括。
 
 如果两个单词间有多余的空格，将反转后单词间的空格减少到只含一个。

 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/fan-zhuan-dan-ci-shun-xu-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

let str = "a good  example"

/**
 2023-03-04
 */
func reverseWords230304(_ s: String) -> String {
    guard s.isEmpty == false else {
        return ""
    }
    var chrArr = Array(s), words: [[Character]] = [], temp: [Character] = []
    
    for chr in chrArr {
        if chr == " " {
            if temp.isEmpty == false {
                words.insert(temp, at: 0)
                temp = []
            }
        }
        else {
            temp.append(chr)
        }
    }
    
    if temp.isEmpty == false {
        words.insert(temp, at: 0)
    }
    
    var res = ""
    for (idx, word) in words.enumerated() {
        res.append(String(word))
        if words.count > 1, idx < words.count - 1 {
            res.append(" ")
        }
    }
    return res
}
reverseWords230304(str)

/**
 2023-02-12
 一
 */
func reverseWords23212(_ s: String) -> String {
    var res = "", temp = "", lastChr: Character?
    var charsArr: [Character] = Array(s)
    for chr in charsArr {
        if let last = lastChr {
            if chr != " " { // 字符
                if last == " " {
                    // 前面是空格
                    res = temp + res
                    temp = String(chr)
                }
                else {
                    // 前面是字符
                    temp.append(chr)
                }
            }
            else { // 空格
                if last != " " {
                    // 前面是字符，暂存一下
                    res = temp + res
                    temp = String(chr)
                }
            }
            lastChr = chr
        }
        else if chr != " " {
            temp.append(chr)
            lastChr = chr
        }
    }
    
    if temp.isEmpty == false, Array(temp)[0] != " " {
        res = temp + res
    }
    
    return res
}

reverseWords23212(str)

/**
 2023-02-12
 二
 */
func reverseWords232122(_ s: String) -> String {
    var chrsArr: [[Character]] = []
    var temp: [Character] = []
    for chr in Array(s) {
        if chr != " " {
            temp.append(chr)
        }
        else if temp.isEmpty == false {
            if chrsArr.isEmpty == false {
                chrsArr.insert([" "], at: 0) // 两组单词见加一个空格
            }
            chrsArr.insert(temp, at: 0)
            temp = []
        }
    }
    
    if temp.isEmpty == false {
        if chrsArr.isEmpty == false {
            chrsArr.insert([" "], at: 0) // 两组单词见加一个空格
        }
        chrsArr.insert(temp, at: 0)
    }
    
    var res = ""
    chrsArr.forEach {
        res += String($0)
    }
    
    return res
}
reverseWords232122(str)


/*:
 暴力
 */
func reverseWords(_ s: String) -> String {
    var res: String = ""
    var temp: String = ""
    
    for i in s {
        if i == " " {
            if temp.isEmpty == false {
                res = (res.isEmpty == false) ? "\(temp) \(res)" : temp
                temp = ""
            }
        }
        else {
            temp = "\(temp)\(i)"
        }
    }
    
    if temp.isEmpty == false {
        res = (res.isEmpty == false) ? "\(temp) \(res)" : temp
    }
    
    return res
}

reverseWords(str)

//: [Next](@next)
