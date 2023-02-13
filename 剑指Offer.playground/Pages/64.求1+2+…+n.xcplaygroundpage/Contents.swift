//: [Previous](@previous)

import Foundation

/*:
 求 1+2+...+n ，要求不能使用乘除法、for、while、if、else、switch、case等关键字及条件判断语句（A?B:C）。

 示例 1：

 输入: n = 3
 
 输出: 6
 
 示例 2：

 输入: n = 9
 
 输出: 45

 限制：

 1 <= n <= 10000

 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/qiu-12n-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/**
 2023-02-13
 */
func sumNums23213(_ n: Int) -> Int {
    /**
     不能使用乘除法、for、while、if、else、switch、case
     
     还剩 递归？
     */
    return n > 1 ? (sumNums23213(n - 1) + n) : n
}

sumNums23213(3)




/*:
 分析
 
 有限制条件，我们就不能直接使用公式：Sn = n * (n + 1) / 2 或 Smn=(n+m)(n-m+1)/2
 可以使用递归代替循环
 */

func sumNums(_ n: Int) -> Int {
    if n == 0 { return 0 }
    return n + sumNums(n - 1)
}

sumNums(100)

//: [Next](@next)
