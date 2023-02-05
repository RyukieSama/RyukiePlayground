//: [Previous](@previous)

/*:
 输入数字 n，按顺序打印出从 1 到最大的 n 位十进制数。比如输入 3，则打印出 1、2、3 一直到最大的 3 位数 999。
 
 示例 1:
 
 输入: n = 1
 输出: [1,2,3,4,5,6,7,8,9]
  
 
 说明：
 
 用返回一个整数列表来代替打印
 n 为正整数
 
 链接：https://leetcode-cn.com/problems/da-yin-cong-1dao-zui-da-de-nwei-shu-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

/**
 2023-02-05
 
 虽慢满足题意，并且能过用例，但是不能大数的处理是个坑
 */
func printNumbers1(_ n: Int) -> [Int] {
    var res: [Int] = []
    var temp = NSDecimalNumber(decimal: pow(10, n)).intValue
    for val in 1..<temp {
        res.append(val)
    }
    return res
}

//printNumbers1(2)

/**
 2023-02-05
 用字符串处理数
 */
func printNumbers2(_ n: Int) {
    if n < 1 { return }
    var arr: [Int] = Array(repeating: 0, count: n)
    var flag = true
    
    while flag {
        if (arr[n - 1] == 9) { // 个位为9 需要进位了
            arr[n - 1] = 0
            var leftIdx = n - 2
            
            while leftIdx >= 0, flag {
                if arr[leftIdx] == 9 { // 上一位是 9 也需要进位
                    if leftIdx == 0 { // 最高位需要进位，也就是满了，跳出循环
                        flag = false
                    }
                    else {
                        arr[leftIdx] = 0
                        leftIdx -= 1 // 继续进位
                    }
                }
                else {
                    arr[leftIdx] += 1
                    print(arr)// 完成这一次 +1
                    break // 跳出内循环
                }
            }
        }
        else {// 不需要进位
            arr[n - 1] += 1
            print(arr) // 完成一次 +1
        }
    }
}

printNumbers2(2)
printNumbers2(3)

func printNumbers(_ n: Int) -> [Int] {
    // 根据位数确定最大数
    let max = NSDecimalNumber(decimal: pow(10, n)).intValue
    var result: [Int] = []
    for value in 1..<max {
        result.append(value)
    }
    return result
}

//printNumbers(2)
//: [Next](@next)
