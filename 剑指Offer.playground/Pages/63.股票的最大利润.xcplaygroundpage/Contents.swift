//: [Previous](@previous)

import Foundation

/*:
 假设把某股票的价格按照时间先后顺序存储在数组中，请问买卖该股票一次可能获得的最大利润是多少？

 示例 1:

 输入: [7,1,5,3,6,4]
 
 输出: 5
 
 解释: 在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
      注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格。
 
 示例 2:

 输入: [7,6,4,3,1]
 
 输出: 0
 
 解释: 在这种情况下, 没有交易完成, 所以最大利润为 0。

 限制：

 0 <= 数组长度 <= 10^5


 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/gu-piao-de-zui-da-li-run-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
let ps = [7,1,5,3,6,4]
//let ps = [7,6,4,3,1]
//let ps: [Int] = []

/**
 2023-02-13
 */
func maxProfit23213(_ prices: [Int]) -> Int {
    /**
     一次遍历
     
     找出最大的差值
     比如在 x 位，卖出利润最大，那么就要找到 前 x-1 位中最小的值
     利润 = x 位的值 - 最小值
     */
    guard prices.count > 1 else {
        return 0
    }

    var min = prices[0], idx = 1
    var profit = 0

    while idx < prices.count {
        let item = prices[idx]
        if item < min {
            min = item
        }
        else if item - min > profit {
            profit = item - min
        }
        
        idx += 1
    }
    
    return profit
}


func maxProfit(_ prices: [Int]) -> Int {
    guard prices.isEmpty == false else {
        return 0
    }
    var p = 0, res = 0, bottom = prices[0]
    
    while p < prices.count {
        let item = prices[p]
        if item <= bottom {
            bottom = item
        }
        else if item - bottom > res {
            res = item - bottom
        }
        p += 1
    }
    
    return res
}

maxProfit(ps)

//: [Next](@next)
