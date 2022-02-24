//: [Previous](@previous)

/*:
 输入一个整数 n ，求1～n这n个整数的十进制表示中1出现的次数。

 例如，输入12，1～12这些整数中包含1 的数字有1、10、11和12，1一共出现了5次。

  

 示例 1：

 输入：n = 12
 输出：5
 示例 2：

 输入：n = 13
 输出：6
  

 限制：

 1 <= n < 2^31
 注意：本题与主站 233 题相同：https://leetcode-cn.com/problems/number-of-digit-one/

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/1nzheng-shu-zhong-1chu-xian-de-ci-shu-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

func countDigitOne(_ n: Int) -> Int {
    var base = 1
    var sum = 0

    while base <= n {
        let pre = n/base/10
        let aft = n%base
        let num = n / base % 10
        
        print("base: \(base) pre: \(pre) num: \(num) aft: \(aft)")
        
        if num == 1 {
            sum += ((pre * base) + (aft + 1))
        }
        else if num == 0 {
            sum += (pre * base)
        }
        else {
            sum += ((pre + 1) * base)
        }
        
        print("sum = \(sum)")
        
        base *= 10
    }
    
    return sum
}

countDigitOne(310295)

//: [Next](@next)
