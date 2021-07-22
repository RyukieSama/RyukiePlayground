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

func cuttingRope(_ n: Int) -> Int {
    if n < 4 {
        return n - 1
    }
    var dp = [Int](repeating: 1, count: n + 1)
    for i in 3...n {
        for j in 2..<i {
            dp[i] = max(dp[i], max(j * (i - j), j * dp[i - j]))
        }
    }
    return dp[n]
}

cuttingRope(10)

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
    if n - threeCount * 3 == 1 {
        threeCount -= 1
    }
    
    let twoCount = (n - threeCount * 3) / 2
    
    
    
    return Int(truncating: NSDecimalNumber(decimal: pow(3, threeCount))) * Int(truncating: NSDecimalNumber(decimal: pow(2, twoCount)))
}

cuttingRope2(10)

//: [Next](@next)
