//: [Previous](@previous)

/*:
 
 我们把只包含质因子 2、3 和 5 的数称作丑数（Ugly Number）。求按从小到大的顺序的第 n 个丑数。
 
 示例:
 
 输入: n = 10
 
 输出: 12
 
 解释: 1, 2, 3, 4, 5, 6, 8, 9, 10, 12 是前 10 个丑数。
 
 说明:
 
 1 是丑数。
 
 n 不超过1690。
 
 注意：本题与主站 264 题相同：https://leetcode-cn.com/problems/ugly-number-ii/
 
 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/chou-shu-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */

import Foundation

/**
 2023-03-04
 穷举超时
 */
func nthUglyNumber230304(_ n: Int) -> Int {
    guard n > 0 else {
        return 0
    }
    
    var count = 0, num = 1
    
    while true {
        if isUgly(x: num) {
            count += 1
            if count == n {
                return num
            }
        }
        num += 1
    }
    
    func isUgly(x: Int) -> Bool {
        var x = x
        
        while x > 1 {
            if x % 2 == 0 {
                x /= 2
            }
            else if x % 3 == 0 {
                x /= 3
            }
            else if x % 5 == 0 {
                x /= 5
            }
            else {
                return false
            }
        }
        
        return x == 1
    }
    
    return 0
}
nthUglyNumber230304(10)

func nthUglyNumber230304A(_ n: Int) -> Int {
    guard n > 0 else {
        return 0
    }
    
    // 丑数 = 2*x + 3*y + 5*z
    var two = 0, three = 0, five = 0
    var dp: [Int] = Array(repeating: 1, count: n)
    
    for idx in 1..<n {
        let a = dp[two] * 2, b = dp[three] * 3, c = dp[five] * 5
        let min = min(min(a, b), c)
        
        if min == a {
            two += 1
        }
        
        if min == b {
            three += 1
        }
        
        if min == c {
            five += 1
        }
        /**
         如果按照下面的写法，只会有a++，所以下次还会计算到重复的丑数！
         */
//        switch min {
//        case a:
//            two += 1
//        case b:
//            three += 1
//        case c:
//            five += 1
//        default:
//            break
//        }
        dp[idx] = min
    }
    
    return dp[n - 1]
}
nthUglyNumber230304A(10)

func nthUglyNumber23211(_ n: Int) -> Int {
    /**
     丑数 =  2^x*3^y*5^z
     */
    var p2 = 0, p3 = 0, p5 = 0
    
    /**
     每个丑数，一定都是前面某一个丑数乘以 2，3，5 之一得到的
     定义三个指针分别代表
     上一个乘以2得到的丑数
     上一个乘以3得到的丑数
     上一个乘以5得到的丑数
     */
    var dp: [Int] = Array(repeating: 1, count: n)
    
    for idx in 1..<n {
        let num2 = dp[p2] * 2,
            num3 = dp[p3] * 3,
            num5 = dp[p5] * 5
        
        let res = min(min(num2, num3), num5)
        
        // 不对
//        switch res {
//        case num2:
//            p2 += 1
//        case num3:
//            p3 += 1
//        case num5:
//            p5 += 1
//        default:
//            break
//        }
        
        if res == num2 {
            p2 += 1
        }
        
        if res == num3 {
            p3 += 1
        }
        
        if res == num5 {
            p5 += 1
        }
        
        dp[idx] = res
    }
    
    return dp[n - 1]
}

nthUglyNumber23211(10)

//func nthUglyNumber(_ n: Int) -> Int {
//    var n = n
//    if n == 1 { return 1 }
//    n -= 1
//    var current = 1
//
//    while n > 0 {
//        current += 1
//        var temp = current
//
//        while temp >= 2 && temp % 2 == 0 { temp /= 2 }
//
//        while temp >= 3 && temp % 3 == 0 { temp /= 3 }
//
//        while temp >= 5 && temp % 5 == 0 { temp /= 5 }
//
//        if temp == 1 { n -= 1 }
//    }
//
//    return current
//}

func nthUglyNumberMinStack(_ n: Int) -> Int {
    var queue = SwiftPriorityQueue<Int>(hasHigherPriority: { $0 < $1 }, isEqual: { $0 == $1 })
    var map: [Int : Int] = [ 1 : 1 ]
    queue.enqueue(1)
    
    var res = 1
    
    for i in 0..<n {
        if let top = queue.dequeue() {
            print("n = \(i) top = \(top)")
            res = top
            for num in [2, 3, 5] {
                let temp = top * num
                if map[temp] == nil {
                    queue.enqueue(temp)
                    map[temp] = 1
                    print(temp)
                }
            }
        }
    }
    
    return res
}

func nthUglyNumberDP(_ n: Int) -> Int {
    var p2 = 0, p3 = 0, p5 = 0
    var dp: [Int] = Array(repeating: 1, count: n)
    
    for i in 1..<n {
        let num2 = dp[p2] * 2,
            num3 = dp[p3] * 3,
            num5 = dp[p5] * 5
        
        dp[i] = min(min(num2, num3), num5)
        
        if dp[i] == num2 {
            p2 += 1
        }
        if dp[i] == num3 {
            p3 += 1
        }
        if dp[i] == num5 {
            p5 += 1
        }
    }
    print(dp)
    return dp[n-1]
}

let num = 10
//nthUglyNumber(num)
//nthUglyNumberMinStack(num)
nthUglyNumberDP(num)

//: [Next](@next)
