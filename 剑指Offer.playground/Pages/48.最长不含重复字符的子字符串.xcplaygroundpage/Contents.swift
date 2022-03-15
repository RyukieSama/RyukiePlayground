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

//let str = "dvdf"
//let str = "abcabcbb"
//let str = "bbbbb"
//let str = "pwwkew"
let str = "abba"
lengthOfLongestSubstring(str)


//: [Next](@next)
