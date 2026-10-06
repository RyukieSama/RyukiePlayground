//: [上一题](@previous)

/*:
# 63-股票的最大利润

## 题目

假设把某股票的价格按照时间先后顺序存储在数组中，请问买卖该股票一次可能获得的最大利润是多少？

## 用例 1

**输入：** [7,1,5,3,6,4]

**输出：** 5

解释: 在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格。

## 用例 2

**输入：** [7,6,4,3,1]

**输出：** 0

解释: 在这种情况下, 没有交易完成, 所以最大利润为 0。

## 约束

0 <= 数组长度 <= 10^5

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/gu-piao-de-zui-da-li-run-lcof)
*/

func max20261006(_ nums: [Int]) -> Int {
    guard nums.count > 1 else {
        return 0
    }
    var result = 0, minVal = nums[0]
    
    for idx in 1..<nums.count {
        let val = nums[idx], deta = val - minVal
        if val < minVal {
            minVal = val
        }
        else if deta > 0 {
            result = max(result, deta)
        }
    }
    
    return result
}


func maxP(_ nums: [Int]) -> Int {
    guard nums.count > 1 else {
        return 0
    }
    
    var profit = 0, minPrice = nums[0]
    
    for v in nums {
        let deta = v - minPrice
        if v <= minPrice {
            minPrice = v
        }
        else if deta > profit {
            profit = deta
        }
    }
    
    return profit
}

//: [下一题](@next)
