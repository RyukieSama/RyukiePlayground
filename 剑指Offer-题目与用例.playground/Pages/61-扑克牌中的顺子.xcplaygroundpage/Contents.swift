//: [上一题](@previous)

/*:
# 61-扑克牌中的顺子

## 题目

从若干副扑克牌中随机抽 5 张牌，判断是不是一个顺子，即这5张牌是不是连续的。2～10为数字本身，A为1，J为11，Q为12，K为13，而大、小王为 0 ，可以看成任意数字。A 不能视为 14。

## 用例 1

**输入：** [1,2,3,4,5]

**输出：** True

## 用例 2

**输入：** [0,0,1,2,5]

**输出：** True

## 约束

数组长度为 5

数组的数取值为 [0, 13] .

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/bu-ke-pai-zhong-de-shun-zi-lcof)
*/
func isStraight20261006(_ nums: [Int]) -> Bool {
    // 用于过滤重复的情况
    var numSet: Set<Int> = []
//    var minVal = 0, maxVal = 13// 注意这里的初始值设置
    var minVal = 14, maxVal = 0 // 这么设置是为了后面的值能进来
    
    for n in nums {
        if n == 0 { continue }
        if numSet.contains(n) { return false } // 有重复的，就不是顺子
        numSet.insert(n)
        
        minVal = min(minVal, n)
        maxVal = max(maxVal, n)
    }
    
    // 要是顺子差值只能在 4 以内
    return maxVal - minVal <= 4
}

func isStraight(_ nums: [Int]) -> Bool {
    var seen: Set<Int> = []
    var minValue = 14
    var maxValue = 0
    
    for num in nums {
        // 大小王可以补任意数字
        if num == 0 {
            continue
        }
        
        // 非王牌不能重复
        if seen.contains(num) {
            return false
        }
        
        seen.insert(num)
        minValue = min(minValue, num)
        maxValue = max(maxValue, num)
    }
    
    // 王牌数量需要补足最大值和最小值之间的空缺
    return maxValue - minValue < 5 // 因为一共有 5 张牌，如果它们能组成顺子，最大牌和最小牌之间最多只能跨越 4
}


//: [下一题](@next)
