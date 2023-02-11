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

/**
 2023-02-10
 */
func countDigitOne2310(_ n: Int) -> Int {
    var res = 0,
        dig = 1 // 位
    /**
     密码锁
     */
    while dig <= n {
        // 当前位的数字
        let current = n / dig % 10
        // 左侧
        let leftVal = n / dig / 10
        // 右侧
        let rightVal = n % dig
        
        switch current {
        case 1:
            /**
             123 1 56
             left : 00 ~ 122 right: 00~99
             left 123 right: 00~56
             */
            res += (leftVal * dig) + 1 * (rightVal + 1)
        case 0:
            /**
             123 0 56
             如果此位要为1
             那么 left：00～122right: 00 ~ 99
             */
            res += (leftVal * dig)
        default:
            /**
             123 4 56
             如果此位要为1
             left: 00~122 right: 00~99
             left: 123 right: 0~99
             */
            res += (leftVal * dig) + 1 * dig
        }
        dig *= 10
    }
    
    return res
}

countDigitOne2310(12)


/**
 2023-02-09
 
 找规律
 */
func countDigitOne23092(_ n: Int) -> Int {
    var sum = 0
    var dig = 1
    /**
     每一位有多招种场景显示 1 的和
     想象密码锁的形式
     一位位看
     */
    while dig <= n {
        var left = n / dig / 10, current = n / dig % 10, right = n % dig
        print("位: \(dig) left: \(left) current: \(current) right: \(right)")
        
        if current == 0 {
            sum += left * dig
        }
        else if current == 1 {
            /**
             左边：
             范围 0 ~ left， left + 1 种
             右边：
             当左边 =  left，右边 0～right：right + 1 种：right + 1
             当左边 0 ～ （left - 1），右边 0～（dig - 1）： left * dig
             */
            sum += left * dig + (right + 1)
        }
        else {
            sum += left * dig + dig
        }
        
        dig *= 10
    }
    
    return sum
}

/**
 2023-02-09
 
 超时
 */

func countDigitOne2309(_ n: Int) -> Int {
    var res = 0
    var number = 1
    
    while number <= n {
        var cArr = Array("\(number)")
        
        while let temp = cArr.first {
            if temp == "1" {
                res += 1
            }
            cArr.removeFirst()
        }
        
        number += 1
    }
    
    return res
}

countDigitOne2309(12)

/*
 *计算从1-n出现1的总次数
 *就是计算1-n所有整数 个位+十位+百位+..为1的总和
 
 *下面三个例子，分别对应的位元素 大于1，等于1，等于0 三种情况
 
 *例一：把百位的5固定 3101 5 92
 *  我们把百位设为1，5前面可以取0-3101，5后面可以取0-99
 *  共有（3101 + 1）* 100（规律是百位即99 + 1）种组合使百位为1
 *
 *例二：把千位的1固定 310 1 592
 *  我们把千位设为1，这里可以分两种情况：
 *  当1前面取310，1后面可以取0-592
 *  当1前面可以取0-309，1后面可以取0-999
 *  共有（309 + 1）* 1000（规律是千位即999 + 1）+（592 + 1）种组合使千位为1
 
 *例三：把万位的0固定 31 0 1592
 *  把万位设为1， 0前面可以取0-30，0后面可以取0-9999
 *  共有（30 + 1）* 10000（规律是万位即9999 + 1）种组合使万位为1
 
 *我们可以分别计算一个数的个位百位...对应的组合数，最后相加
 */
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
