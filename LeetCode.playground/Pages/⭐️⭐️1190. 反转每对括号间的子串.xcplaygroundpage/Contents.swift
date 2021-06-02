//: [Previous](@previous)

import Foundation

/*:
 给出一个字符串 s（仅含有小写英文字母和括号）。
 
 请你按照从括号内到外的顺序，逐层反转每对匹配括号中的字符串，并返回最终的结果。
 
 注意，您的结果中 不应 包含任何括号。
 
  
 
 示例 1：
 
 输入：s = "(abcd)"
 输出："dcba"
 示例 2：
 
 输入：s = "(u(love)i)"
 输出："iloveu"
 示例 3：
 
 输入：s = "(ed(et(oc))el)"
 输出："leetcode"
 示例 4：
 
 输入：s = "a(bcdefghijkl(mno)p)q"
 输出："apmnolkjihgfedcbq"
  
 
 提示：
 
 0 <= s.length <= 2000
 s 中只有小写英文字母和括号
 我们确保所有括号都是成对出现的
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/reverse-substrings-between-each-pair-of-parentheses
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


// MARK: - 错了：只考虑了括号一层层包的情况
func reverseParentheses(_ s: String) -> String {
    
    var leftString = ""
    var rightString = ""
    /*:
     双指针：
     两边同时开始向中间找
     
     创建两个容器
     
     left/right 遇到(或)就停下，第一次遇到括号之前的字符串不做处理，分别赋值左右容器
     
     之后的都 leftArr rightArr，分别逆序，然后添加到对面的尾部与头部
     
     最后得出结果
     */
    
    var pl = 0
    var pr = s.count - 1
    
    var sArr: [String] = []
    
    s.forEach { c in
        sArr.append(String(c))
    }
    
    var leftBracketCount: Int64 = 0
    var rightBracketCount: Int64 = 0
    
    while pl <= pr {
        let strL = sArr[pl]
        let strR = sArr[pr]
        
        var bracketLAdd = false
        var bracketRAdd = false
        let currentLevel = min(leftBracketCount, rightBracketCount)
        
        if strL == "(" && strR == ")" {
            pl += 1
            pr -= 1
            leftBracketCount += 1
            rightBracketCount += 1
        }
        else {
            //            if pl == pr && strL != "(" && strR != ")" {
            //                return leftString + strL + rightString
            //            }
            //
            if strL == "(" {
                bracketLAdd = true
                pl += 1
            }
            else {
                if leftBracketCount == 0 {
                    leftString += strL
                    pl += 1
                }
                else if leftBracketCount > rightBracketCount {
//                    print("左边等")
                }
                else { // 走
                    if currentLevel % 2 == 0 {
                        leftString += strL
                    }
                    else {
                        rightString = strL + rightString
                    }
                    pl += 1
                }
            }
            
            if strR == ")" {
                bracketRAdd = true
                pr -= 1
            }
            else {
                if rightBracketCount == 0 {
                    rightString = strR + rightString
                    pr -= 1
                }
                else if rightBracketCount > leftBracketCount {
//                    print("右边等")
                }
                else { // 走
                    if currentLevel % 2 == 0 {
                        rightString = strR + rightString
                    }
                    else {
                        leftString = leftString + strR
                    }
                    pr -= 1
                }
            }
            
            leftBracketCount += (bracketLAdd ? 1 : 0)
            rightBracketCount += (bracketRAdd ? 1 : 0)
        }
    }
    
    return leftString + rightString
}

let s = "ta()usw((((a))))"// 这个比较极端的用例

reverseParentheses(s)

func reverseParentheses2(_ s: String) -> String {
    var charStack = [String.Element]()
    for char in s {
        if char == ")" {
            var tempStack = [String.Element]()
            var lastChar = charStack.removeLast()
            while lastChar != "(" {
                tempStack.append(lastChar)
                lastChar = charStack.removeLast()
            }
            charStack += tempStack
        } else {
            charStack.append(char)
        }
    }
    
    var result = ""
    for char in charStack {
        result += String.init(char)
    }
    return result
}

reverseParentheses2(s)

func reverseParentheses3(_ s: String) -> String {
    var result = ""
    var chars = [String.Element]()
    
    for c in s {
        if c == ")" {
            var temp = [String.Element]()
            var lastC = chars.removeLast()
            while lastC != "(" {
                temp.append(lastC)// 倒序了
                lastC = chars.removeLast()
            }
            chars += temp
        }
        else {
            chars.append(c)
        }
    }
    
    
    for c in chars {
        result += String(c)
    }
    return result
}

reverseParentheses3(s)

//: [Next](@next)
