//: [Previous](@previous)

import Foundation

/*:
 写一个函数，求两个整数之和，要求在函数体内不得使用 “+”、“-”、“*”、“/” 四则运算符号。

 示例:

 输入: a = 1, b = 1
 
 输出: 2
  
 提示：

 a, b 均可能是负数或 0
 
 结果不会溢出 32 位整数

 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/bu-yong-jia-jian-cheng-chu-zuo-jia-fa-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/**
 2023-02-13
 */
func add23213(_ a: Int, _ b: Int) -> Int {
    /**
     不用 加减乘除 做加法
     */
//    var da: [Int] = [], db: [Int] = []
//    var a = a, b = b, flag = 1
//
//    for _ in 0..<32 {
//        da.insert((a & flag == 0) ? 0 : 1, at: 0)
//        db.insert((b & flag == 0) ? 0 : 1, at: 0)
//
////        a >>= 1
////        b >>= 1
//        flag <<= 1
//    }
//
//    da.insert((a < 0) ? 1 : 0, at: 0)
//    db.insert((b < 0) ? 1 : 0, at: 0)
//
//    print(da)
//    print(db)

    return 0
}

add23213(-2, 3)

/**
 预备知识

 有符号整数通常用补码来表示和存储，补码具有如下特征：

 正整数的补码与原码相同；负整数的补码为其原码除符号位外的所有位取反后加 111。

 可以将减法运算转化为补码的加法运算来实现。

 符号位与数值位可以一起参与运算。

 可以发现，对于整数 aaa 和 bbb：

 在不考虑进位的情况下，其无进位加法结果为 a ^ b。

 而所有需要进位的位为 a & b，进位后的进位结果为 (a & b) << 1

 于是，我们可以将整数 aaa 和 bbb 的和，拆分为 aaa 和 bbb 的无进位加法结果与进位结果的和。因为每一次拆分都可以让需要进位的最低位至少左移一位，又因为 aaa 和 bbb 可以取到负数，所以我们最多需要 log⁡(max_int)\log (max\_int)log(max_int) 次拆分即可完成运算。

 因为有符号整数用补码来表示，所以以上算法也可以推广到 0 和负数。
 
 作者：力扣官方题解
 链接：https://leetcode.cn/problems/bu-yong-jia-jian-cheng-chu-zuo-jia-fa-lcof/solutions/1790724/bu-yong-jia-jian-cheng-chu-zuo-jia-fa-by-0a30/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */

func add232132(_ a: Int, _ b: Int) -> Int {
    var sum = 0, carry = 0
    var num1 = a, num2 = b
    
    /**
     异或：找出不用进位的
     与：找出需要进位的位，但结果需要左移一位，因为是要进位的
     和，就为两部分的和，由于不能使用四则运算，所以需要循环执行，直到不需要进位了
     递归反而更好理解
     */
    
    while num2 != 0 {
        sum = num1 ^ num2
        carry = (num1 & num2) << 1
        num1 = sum
        num2 = carry
    }
    
    return num1
}

add232132(-2, 3)

func add232133(_ a: Int, _ b: Int) -> Int {
    guard b != 0 else {
        return a
    }
    return add232133(a ^ b, (a & b) << 1)
}
add232133(-2, 3)


/*:
 很容易想到要用位运算，但是怎么写？
 
 
 
 */

func add(_ a: Int, _ b: Int) -> Int {
    return 0
}

add(2, 5)

//: [Next](@next)
