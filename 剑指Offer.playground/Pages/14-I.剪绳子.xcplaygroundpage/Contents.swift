//: [Previous](@previous)

import Foundation

/*:
 ## 一、 题目

 给你一根长度为 n 的绳子，请把绳子剪成整数长度的 m 段（m、n都是整数，n>1并且m>1），每段绳子的长度记为 k[0],k[1]...k[m-1] 。

 请问 k[0]*k[1]*...*k[m-1] 可能的最大乘积是多少？

 例如，当绳子的长度是8时，我们把它剪成长度分别为2、3、3的三段，此时得到的最大乘积是18。

 示例 1：

 ```
 输入: 2
 输出: 1
 解释: 2 = 1 + 1, 1 × 1 = 1
 ```

 示例 2:

 ```
 输入: 10
 输出: 36
 解释: 10 = 3 + 3 + 4, 3 × 3 × 4 = 36
 ```

 提示：

 2 <= n <= 58

 注意：本题与主站 343 题相同：https://leetcode-cn.com/problems/integer-break/

 来源：[力扣（LeetCode）](https://leetcode-cn.com/problems/jian-sheng-zi-lcof)

 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

 ## 二、 动态规划

 动态规划是面试中的热门话题。

 ### 2.1 什么样的场景适合动态规划呢？

 * 如果题目是：
   * 求一个问题的最优解（通常是`最大值`或者`最小值`）
   * 而且改问题能够分解为若干个子问题
   * 并且字问题之间还有重叠的更小的子问题
 * 就可以考虑使用动态规划来解决这个问题

 ### 2.2 本题是否适合动态规划？

 * 我们把长度为n的绳子剪成若干段后得到的乘积的最大值定义为函数`f(n)`。
 * 假设我们把第一刀剪在了长度为`i（0 < i < n）`的位置，于是把绳子剪成了长度为`i`和`n-i`的两段。
 * 我们想要得到整个问题的最优解`f(n)`那么要同样用最优化的方法把长度为`i`和`n-i`的两段分别剪成若干段，使得各自剪出的每段绳子的乘积最大。
 * 也就是说整体问题的最优解是依赖各个子问题的最优解。

 ### 2.3 动态规划的过程

 * 由于子问题在分解大问题的过程中重复出现，为了避免重复求解子问题，我们可以：
   * 从下往上的顺序先计算小问题的最优解并存储下来
   * 再以此为基础求取大问题的最优解
 * 这种从上往下分析问题，从下往上解决问题也是动态规划的一大特征。

 ### 2.4 应用在本题中

 在应用动态规划的时候，我们每一步都可能面临若干个选择。

 本题中：

 * 第一刀有n-1种选择。我们可以剪再 1,2...n-1 的任意位置。
 * 由于我们事先不知道那个位置是最优解，只好把所有可能的额都尝试一遍，然后比较出最优解。
 * 用数学表示就是
   * `f(n) = max(f(i), f(n-i))`
   * `0 < i < n`

 ### 代码
 */

/**
 2023-02-27
 */
func cuttingRope23227A(_ n: Int) -> Int {
    guard n >= 4 else {
        return n - 1
    }
    /**
     贪心
     */
    var res = 0, maxThree = n / 3, more = n % 3
    
    /**
     4 的时候 2 2 最好
     如果模 3 剩 1 的话，就特殊处理一下
     */
    if more == 1 {
        maxThree -= 1
        more = 4
    }
    
    res = Int(pow(3, Double(maxThree)))
    
    if more > 0 {
        res *= more
    }
    
    return res
}
cuttingRope23227A(10)

func cuttingRope23227B(_ n: Int) -> Int {
    /**
     动态规划长度为 n 的，最大乘积为 dp[n]
     n 长度遍历所有剪法，只保存最大的进 dp
     */
    var dp: [Int : Int] = [
        0: 0,
        1: 0,
        2: 1,
        3: 2
    ]
    
    guard n > 3 else {
        return dp[n] ?? 0
    }
    
    for length in 4...n {
        /**
         从 4 开始构建到 n 的 dp
         */
        for cut in 2...n/2 {
            /**
             length 长的 剪掉 cut 后有两种选择
             
             一、不再剪了 = cut * (length - cut)
             二、剪 = cut * (dp[length - cut])
             */
            dp[length] = max(dp[length] ?? 0, cut * max(length - cut, (dp[length - cut] ?? 0)))
        }
    }
    return dp[n] ?? 0
}
cuttingRope23227B(4)

// --
func cuttingRope(_ n: Int) -> Int {
    if n < 4 {
        return n - 1
    }
    var dp = [Int](repeating: 1, count: n + 1)
    // 外层循环，类似于递归 n
    for i in 3...n {
        // 内层循环，剪绳子
        for j in 2..<i {
            dp[i] = max(dp[i], max(j * (i - j), j * dp[i - j]))
        }
    }
    return dp[n]
}

cuttingRope(2)
cuttingRope(4)
cuttingRope(10)

// 2023-02-03
func cuttingRope1(_ n: Int) -> Int {
    var dp: [Int: Int] = [
        0: 0,
        1: 0,
        2: 1,
        3: 2
    ]
    
    guard n > 3 else { return dp[n] ?? 0 }
    
    for length in 4...n { // 由下往上循环
//        print(length)
        for i in 2...(length / 2) {
            /**
            length 切下 i 长度

            i 从2 开始，1没必要，切了就小了

            剩下的部分可以剪或者不剪

            剪的话就是 i * dp[length - i]
            不剪 i * (length - i)

            dp[length] = 两种情况中最大的一种
            */
            dp[length] = max(dp[length] ?? 0, i * max(length - i, (dp[length - i ] ?? 0)))
        }
    }
    return dp[n] ?? 0
}

cuttingRope1(2)
cuttingRope1(4)
cuttingRope1(10)

// 2023-02-04
func cuttingRope11(_ n: Int) -> Int {
    guard n > 3 else {
        switch n {
        case 3: return 2
        case 2: return 1
        default: return 0
        }
    }
    
    var dp = Array(repeating: 0, count: n + 1)
    dp[1] = 0
    dp[2] = 1
    dp[3] = 2
    
    for length in 4...n {
        for cut in 2...(length / 2) {
            /**
             一刀剪 cut ，剩下的有两种方案
             剪 就是 dp[length - cut]
             不剪 就是 length - cut
             */
            dp[length] = max(dp[length], cut * max(length - cut, dp[length - cut]))
        }
    }
    
    return dp[n]
}

cuttingRope11(2)
cuttingRope11(4)
cuttingRope11(10)

/*:
 ## 三、 贪婪算法

 贪婪算法和动态规划不一样。当我们应用贪婪算法解决问题的时候，每一步都可以做出一个贪婪的选择，基于这个选择，我们确定能够得到最优解。

 至于为什么这样的贪婪选择能够得到最优解。这就需要使用数学方式来证明了。

 * [K大的贪婪证明](https://leetcode-cn.com/problems/jian-sheng-zi-lcof/solution/mian-shi-ti-14-i-jian-sheng-zi-tan-xin-si-xiang-by/)
 
 
 */

func cuttingRope2(_ n: Int) -> Int {
    if n < 2 {
        return 0
    }
    if n == 2 {
        return 1
    }
    if n == 3 {
        return 2
    }
        
    // 3长度的最大段数
    var threeCount = n / 3
     
    // 当绳子剩下4的时候 不能再剪3长度，更优的方式是剪成长度为2的，因为 2x2 > 3x1
    if n % 3 == 1 {
        threeCount -= 1
    }
    
    let twoCount = (n - threeCount * 3) / 2
    
    return Int(truncating: NSDecimalNumber(decimal: pow(3, threeCount))) * Int(truncating: NSDecimalNumber(decimal: pow(2, twoCount)))
}

cuttingRope2(2)
cuttingRope2(4)
cuttingRope2(10)

//: [Next](@next)
