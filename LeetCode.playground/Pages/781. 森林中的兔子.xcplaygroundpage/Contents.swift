//: [Previous](@previous)

/*:
 森林中，每个兔子都有颜色。其中一些兔子（可能是全部）告诉你还有多少其他的兔子和自己有相同的颜色。我们将这些回答放在 answers 数组里。
 
 返回森林中兔子的最少数量。
 
 示例:
 输入: answers = [1, 1, 2]
 输出: 5
 解释:
 两只回答了 "1" 的兔子可能有相同的颜色，设为红色。
 之后回答了 "2" 的兔子不会是红色，否则他们的回答会相互矛盾。
 设回答了 "2" 的兔子为蓝色。
 此外，森林中还应有另外 2 只蓝色兔子的回答没有包含在数组中。
 因此森林中兔子的最少数量是 5: 3 只回答的和 2 只没有回答的。
 
 输入: answers = [10, 10, 10]
 输出: 11
 
 输入: answers = []
 输出: 0
 说明:
 
 answers 的长度最大为1000。
 answers[i] 是在 [0, 999] 范围内的整数。
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/rabbits-in-forest
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */

import Foundation

//let ras = [1, 2, 1] // 5
//let ras = [10, 10, 10] // 11
//let ras = [1, 0, 1, 0, 0]// 5
let ras = [0, 0, 1, 1, 1] // 6

// 错的思路
//// 思路一：答案相同的就可能是同色的，那么筛选出所有不同答案，再求和就行了
//
//func numRabbits(_ answers: [Int]) -> Int {
//    var diffArr: [Int] = []
//    var count = 0
//
//    answers.forEach {
//        if $0 == 0 {
//            count += 1
//        }
//        else if diffArr.contains($0) == false {
//            diffArr.append($0)
//        }
//    }
//
//    return count + diffArr.reduce(0, +) + diffArr.count
//}

func numRabbits(_ answers: [Int]) -> Int {
    var map: [Int : Int] = [:]
    answers.forEach {
        map[$0] = (map[$0] ?? 0) + 1
    }
    
    var count = 0
    map.forEach {
        let number = Float($0.key)
        let rCount = Float($0.value)
        // 有x只回答有y只和自己颜色相同，最少有x/y+1向上取整种不同颜色，每种有y+1只
        count += Int(ceil(rCount / (number + 1.0))) * Int(number + 1)
    }
    return count
}

numRabbits(ras)

//: [Next](@next)
