//: [上一题](@previous)

/*:
# 05-替换空格

## 题目

请实现一个函数，把字符串 s 中的每个空格替换成"%20"。

## 用例 1

**输入：** s = "We are happy."

**输出：** "We%20are%20happy."

## 约束

0 <= s 的长度 <= 10000

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/ti-huan-kong-ge-lcof)
*/
let str = "We are happy."

func rep_20260914_01(_ str: String) -> String {
    guard !str.isEmpty else {
        return str
    }
    var arr = Array(str), res: String = "", idx = 0
    while idx < arr.count {
        let val = arr[idx]
        if val == " " {
            res += "%20"
        }
        else {
            res += String(val)
        }
        idx += 1
    }
    return res
}

rep_20260914_01(str)


//: [下一题](@next)
