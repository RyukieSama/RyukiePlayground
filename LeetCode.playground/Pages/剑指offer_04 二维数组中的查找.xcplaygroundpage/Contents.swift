
/*:
 在一个 n * m 的二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。请完成一个高效的函数，输入这样的一个二维数组和一个整数，判断数组中是否含有该整数。
 
  
 
 示例:
 
 现有矩阵 matrix 如下：
 
 [
 [1,   4,  7, 11, 15],
 [2,   5,  8, 12, 19],
 [3,   6,  9, 16, 22],
 [10, 13, 14, 17, 24],
 [18, 21, 23, 26, 30]
 ]
 给定 target = 5，返回 true。
 
 给定 target = 20，返回 false。
 
  
 
 限制：
 
 0 <= n <= 1000
 
 0 <= m <= 1000
 
  
 
 注意：本题与主站 240 题相同：https://leetcode-cn.com/problems/search-a-2d-matrix-ii/
 
 
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/er-wei-shu-zu-zhong-de-cha-zhao-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */

import UIKit

// MARK: - 暴力遍历 O(nm) O(1)
func hard(_ matrix: [[Int]], _ target: Int) -> Bool {
    for arr in matrix {
        for item in arr {
            if item == target {
                return true
            }
        }
    }
    return false
}

// MARK: - 二分法
func half(_ matrix: [[Int]], _ target: Int) -> Bool {
    return false
}

// MARK: - 根据排列规则遍历 最大O(n + m) O(1)
// TODO: WRQ 了解一下二叉搜索树
func rule(_ matrix: [[Int]], _ target: Int) -> Bool {
    guard let firstLine = matrix.first else { return false }
    let yCount = matrix.count
    let xCount = firstLine.count
    if xCount == 0 || yCount == 0 {
        return false
    }
    
    for arr in matrix {
        let last = arr[xCount - 1]
        if last < target {
            continue
        }
        else {
            for i in 0...(xCount - 1) {
                if arr[i] == target {
                    return true
                }
            }
        }
    }
    return false
}

func ruleWhile(_ matrix: [[Int]], _ target: Int) -> Bool {
    guard let firstLine = matrix.first else { return false }
    let yCount = matrix.count
    let xCount = firstLine.count
    
    if xCount == 0 || yCount == 0 {
        return false
    }
    var x = xCount - 1, y = 0
    while x >= 0, y < yCount {
        let num = matrix[y][x]
        if (num == target) {
            return true
        }
        else if (num > target) {
            x -= 1
        }
        else {
            y += 1
        }
    }
    return false
}
// MARK: - Test
var array =  [
    [1,   4,  7, 11, 15],
    [2,   5,  8, 12, 19],
    [3,   6,  9, 16, 22],
    [10, 13, 14, 17, 24],
    [18, 21, 23, 26, 30]
]

let target = 23

func findNumberIn2DArray(_ matrix: [[Int]], _ target: Int) -> Bool {
    //    return hard(array, target)
    //    return half(array, target)
//        return rule(array, target)
    return ruleWhile(array, target)
}

findNumberIn2DArray(array, target)

