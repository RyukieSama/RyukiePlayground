//: [Previous](@previous)

import Foundation

/*:
 把n个骰子扔在地上，所有骰子朝上一面的点数之和为s。输入n，打印出s的所有可能的值出现的概率。

 你需要用一个浮点数数组返回答案，其中第 i 个元素代表这 n 个骰子所能掷出的点数集合中第 i 小的那个的概率。


 示例 1:

 输入: 1
 
 输出: [0.16667,0.16667,0.16667,0.16667,0.16667,0.16667]
 
 示例 2:

 输入: 2
 
 输出: [0.02778,0.05556,0.08333,0.11111,0.13889,0.16667,0.13889,0.11111,0.08333,0.05556,0.02778]

 限制：

 1 <= n <= 11

 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/nge-tou-zi-de-dian-shu-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/**
 2023-02-13
 */
func dicesProbability23213(_ n: Int) -> [Double] {
    /**
     动态规划
     
     n 个骰子，和范围 n～6n，共 6^n 种组合
     
     值x，有y种组合方式，概率就为 y / 6^n
     
     dp 表示，n个骰子，能组成x值的组合数量，key 是和的值 value 是组合数量
     例如：dp = [1: 1, 2: 1, 3: 1, 4: 1, 5: 1, 6: 1]
     
     需要构建这样一个 dp
     */
    // 总组合数
    let totalCpCount = Double(pow(6, Double(n)))
    var dps: [[Int: Int]] = [
        [1: 1, 2: 1, 3: 1, 4: 1, 5: 1, 6: 1]
    ]
    var res: [Double] = []
    
    if n > 1 {
        for count in 2...n {
            var dp: [Int: Int] = [:]
            // -1 数量的骰子的 DP
            let lastDp = dps[dps.count - 1]
            /**
             固定一个骰子的值
             两个固定一个值x
             
             循环：
             x = 1：
             
             x = 2:
             ...
             */
            for fixVal in 1...6 {
                for sum in count...6*count {
                    let deta = sum - fixVal
                    if deta > 0 {
                        // 同一个 sum 会有多种情况，这里累加
                        dp[sum] = (dp[sum] ?? 0) + (lastDp[deta] ?? 0)
                    }
                }
            }
    //        print(dp)
            dps.append(dp)
        }
    }
    
//    print(dps)
    
    if let last = dps.last {
        for sum in n...6*n {
            if let cps = last[sum] {
                res.append(Double(cps) / totalCpCount)
            }
        }
    }
    
    return res
}

dicesProbability23213(1)
dicesProbability23213(2)


/*:
 数组内元素和为 1
 
 要求每个和有多少种组合方式
 每个组合方式数/总组合数就是概率了
 */
func dicesProbability(_ n: Int) -> [Double] {
    let sRangeMin = n
    let sRangeMax = n * 6
    var total = 0
    var temp: [Int] = []
    var res: [Double] = []
    
    for s in sRangeMin...sRangeMax {
        let c = resultCount(of: s, by: n)
        total += c
        temp.append(c)
    }
    
    temp.forEach {
        res.append(Double($0) / Double(total))
    }
    
    return res
}


/*:
 设 f(n,x) 为 n 个骰子和为 x 的组合数
 
 f(n,x) = f(n-1, x-1) + f(n-1, x-2) + f(n-1, x-3) + f(n-1, x-4) + f(n-1, x-5) + f(n-1, x-6)
 */

var dp: [String : Int] = [:]

/// 求 n 个 1-6 的数字和为 num 的组合数
/// - Parameters:
///   - num: -
///   - n: -
/// - Returns: 组合数
func resultCount(of num: Int, by n: Int) -> Int {
    guard num >= n, num <= n*6 else { // 注意控制边界条件
        return 0
    }
    
    guard n > 1 else {
        return 1
    }
    
    let key = "\(n) - \(num)"
    if let r = dp[key] {
        return r
    }
    
    var res: Int = 0
    for i in 1...6 {
        res += resultCount(of: num - i, by: n - 1)
    }
    
    dp[key] = res
    return res
}

let re = dicesProbability(2)
re.forEach {
    print($0)
}

//: [Next](@next)
