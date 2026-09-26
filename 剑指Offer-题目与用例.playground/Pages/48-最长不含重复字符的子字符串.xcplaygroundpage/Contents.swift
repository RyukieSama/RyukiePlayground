//: [上一题](@previous)

/*:
# 48-最长不含重复字符的子字符串

## 题目

请从字符串中找出一个最长的不包含重复字符的子字符串，计算该最长子字符串的长度。

## 用例 1

**输入：** "abcabcbb"
**输出：** 3
解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
## 用例 2

**输入：** "bbbbb"
**输出：** 1
解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
## 用例 3

**输入：** "pwwkew"
**输出：** 3
解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。

## 提示

s.length <= 40000

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/zui-chang-bu-han-zhong-fu-zi-fu-de-zi-zi-fu-chuan-lcof)
*/

func maxSubString(_ str: String) -> Int {
    let chars = Array(str)
    var left = 0
    var result = 0
    var window: Set<Character> = []
    
    for right in 0..<chars.count {
        let chr = chars[right]
        while window.contains(chr) {
            window.remove(chars[left])// 循环移除最左的，直到没有重复的
            left += 1
        }
        
        window.insert(chr)
        result = max(result, right - left + 1)
    }
    
    return result
}

// 错了，tempSet 不能清空，应该
//func maxSubString(_ str: String) -> Int {
//    guard str.isEmpty == false else {
//        return 0
//    }
//    let chars = Array(str)
//    var maxCount = 0, tempSet: Set<Character> = []
//    
//    for c in chars {
//        let oldSetCount = tempSet.count
//        tempSet.insert(c)
//        if tempSet.count == oldSetCount {
//            // 没增加说明有重复的
//            maxCount = max(maxCount, tempSet.count)
//            // 清空 temp
//            tempSet = []
//            tempSet.insert(c)
//        }
//        else {
//            // 增加了 说明没重复
//            maxCount = max(maxCount, tempSet.count)
//        }
//    }
//    
//    return maxCount
//}


/*:
## 题目解析

这道题要求找到不包含重复字符的最长连续子字符串，核心方法是滑动窗口。

当前窗口由 `left` 和 `right` 两个指针表示，范围是 `[left...right]`。`right` 不断向右扩展；如果新字符已经存在于窗口中，就移动 `left` 并删除左侧字符，直到窗口重新没有重复字符。

遇到重复字符时不能直接清空整个集合。例如 `"dvdf"` 中，第二个 `d` 出现后，正确窗口应该从第一个 `d` 的后面开始，得到 `"vdf"`，而不是清空后只保留新的 `d`。

当前代码中的：

`while window.contains(chr)`

会持续移除最左侧字符，直到当前字符可以安全加入窗口。使用 `while` 而不是 `if`，是因为有时需要连续移除多个字符。

窗口合法后加入当前字符，并用 `right - left + 1` 计算窗口长度，更新最大值。

例如 `abcabcbb`：窗口先扩展为 `abc`，遇到第二个 `a` 时移除左侧的 `a`，窗口变为 `bca`，最大长度仍为 `3`。

当前实现已经正确处理了空字符串、全部重复字符以及重复字符出现在窗口中间的情况。

### 复杂度

- 时间复杂度：`O(n)`，每个字符最多加入和移除窗口一次。
- 额外空间复杂度：`O(k)`，`k` 是窗口中不同字符的数量。
*/
//: [下一题](@next)
