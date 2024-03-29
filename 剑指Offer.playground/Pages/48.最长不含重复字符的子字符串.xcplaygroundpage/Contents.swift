//: [Previous](@previous)

/*:
 请从字符串中找出一个最长的不包含重复字符的子字符串，计算该最长子字符串的长度。
 
 示例 1:
 
 输入: "abcabcbb"
 输出: 3
 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
 示例 2:
 
 输入: "bbbbb"
 输出: 1
 解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
 示例 3:
 
 输入: "pwwkew"
 输出: 3
 解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
      请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
  
 
 提示：
 
 s.length <= 40000
 
 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/zui-chang-bu-han-zhong-fu-zi-fu-de-zi-zi-fu-chuan-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

var str = "dvdf"
str = "abcabcbb"
//str = "bbbbb"
//str = "pwwkew"
//str = "abba"

/**
 2023-03-04
 */
func lengthOfLongestSubstring230304(_ s: String) -> Int {
    guard s.isEmpty == false else {
        return 0
    }
    var maxCount = 0,chrArray = Array(s)
    var temp: [Character] = []
    
    for chr in chrArray {
        if let idx = temp.firstIndex(of: chr) {
            if idx + 1 == temp.count {
                temp = [chr]
            }
            else {
                temp = Array(temp[idx + 1..<temp.count])
                temp.append(chr)
            }
        }
        else {
            temp.append(chr)
        }
        
        maxCount = max(maxCount, temp.count)
    }
    
    return maxCount
}
lengthOfLongestSubstring230304(str)

/**
 2023-02-20
 */
func lengthOfLongestSubstring23220(_ s: String) -> Int {
    guard s.isEmpty == false else {
        return 0
    }
    var maxCount = 0,chrArray = Array(s)
    var temp: [Character] = []
    
    for chr in chrArray {
        if let idx = temp.firstIndex(of: chr) {
            if idx + 1 < temp.count {
                temp = Array(temp[idx + 1..<temp.count])
                temp.append(chr)
            }
            else {
                temp = [chr]
            }
        }
        else {
            temp.append(chr)
        }
        maxCount = max(maxCount, temp.count)
    }
    
    return maxCount
}

lengthOfLongestSubstring23220(str)

/**
 2023-02-16
 */
func lengthOfLongestSubstring23216(_ s: String) -> Int {
    guard s.isEmpty == false else {
        return 0
    }
    var charArray: [Character] = Array(s), maxCount = 0, temp: [Character] = []
    
    for chr in charArray {
        if let lastIdx = temp.firstIndex(of: chr) {
            if lastIdx + 1 < temp.count {
                temp = Array(temp[lastIdx + 1..<temp.count])
                temp.append(chr)
            }
            else {// "ab" + "b"
                temp = [chr]
            }
        }
        else {
            temp.append(chr)
        }
        
        maxCount = max(maxCount, temp.count)
    }
        
    return maxCount
}
lengthOfLongestSubstring23216(str)

/**
 2023-02-11
 */
func lengthOfLongestSubstring23211(_ s: String) -> Int {
    guard s.isEmpty == false else { return 0 }
    let arr = Array(s)
    var res = 0
    var tempLength = 0// 当前连续长度
    var charIndexMap: [Character: Int] = [:]
    
    for idx in 0..<arr.count {
        let char = arr[idx]
        if let lastIndex = charIndexMap[char] {
            // 当前的字符出现过
            if idx - lastIndex <= tempLength { // 重复出现在当前连续不重复区段内
                tempLength = idx - lastIndex
            }
            else {
                // 重复发生在当前重复区间外
                tempLength += 1
            }
        }
        else {
            tempLength += 1
        }
        charIndexMap[char] = idx
        
        res = max(tempLength, res)
    }
    
    return res
}

lengthOfLongestSubstring23211(str)


func lengthOfLongestSubstring(_ s: String) -> Int {
    guard s.isEmpty == false else {
        return 0
    }
    let stringArr: [Character] = Array(s)
    var maxCount: Int = 0
    /// 最后一次元素出现的下标
    var map: [Character : Int] = [ : ]
    /// 一个重复段内的不重复子串长度
    var temp: Int = 0
    
    for idx in 0..<stringArr.count {
        if let last = map[stringArr[idx]] {
            temp = (temp < (idx - last)) ? (temp + 1) : (idx - last)
        }
        else {
            temp += 1
        }
        map[stringArr[idx]] = idx
        maxCount = max(maxCount, temp)
    }
    
    return maxCount
}

func lengthOfLongestSubstring1(_ s: String) -> Int {
    guard s.isEmpty == false else {
        return 0
    }
    let stringArr: [Character] = Array(s)
    var maxCount: Int = 0
    var map: [Character : Int] = [ : ]
    var temp: Int = 0
    
    for idx in 0..<stringArr.count {
        let last = map[stringArr[idx]] ?? -1
        temp = (temp < (idx - last)) ? (temp + 1) : (idx - last)
        map[stringArr[idx]] = idx
        maxCount = max(maxCount, temp)
    }
    
    return maxCount
}

lengthOfLongestSubstring(str)


//: [Next](@next)
