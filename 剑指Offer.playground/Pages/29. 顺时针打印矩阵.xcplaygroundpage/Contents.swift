//: [Previous](@previous)

import Foundation

/*:
 输入一个矩阵，按照从外向里以顺时针的顺序依次打印出每一个数字。

 示例 1：

 输入：matrix = [[1,2,3],[4,5,6],[7,8,9]]
 输出：[1,2,3,6,9,8,7,4,5]
 示例 2：

 输入：matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
 输出：[1,2,3,4,8,12,11,10,9,5,6,7]
  
 限制：

 0 <= matrix.length <= 100
 0 <= matrix[i].length <= 100
 注意：本题与主站 54 题相同：https://leetcode-cn.com/problems/spiral-matrix/

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/shun-shi-zhen-da-yin-ju-zhen-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/**
 非常好理解的解法
 
 * 出现需要变更方向的点的拐向是一定的：
    * 当前向➡️扫描，拐点一定向⤵️
    * 当前向⤵️扫描，拐点一定向⬅️
    * 当前向⬅️扫描，拐点一定向⤴️
    * 当前向⤴️扫描，拐点一定向➡️
 
 flags 为标记数组，用来标识已经扫描过的下标
 在一个方向上：
 扫描到边界
 或者
 扫描到已标记的坐标
 触发转向
 */

enum Dirction {
    /// x + 1
    case Right
    /// y + 1
    case Down
    /// x - 1
    case Left
    /// y - 1
    case Up
}

func spiralOrder(_ matrix: [[Int]]) -> [Int] {
    var result: [Int] = []
    let height = matrix.count
    
    guard let first = matrix.first, height > 0 else {
        return result
    }
    
    let width = first.count
    var x = 0, y = 0
    var dir: Dirction = .Right
    
    var flags: [[Bool]] = Array(repeating: Array(repeating: false, count: width), count: height)
    
    while x >= 0, y >= 0, x < width, y < height, result.count < width * height {
        flags[y][x] = true
        result.append(matrix[y][x])
        
        switch dir {
        case .Right:
            if x + 1 < width, flags[y][x + 1] == false {
                x += 1
            }
            else {
                dir = .Down
                y += 1
            }
        case .Down:
            if y + 1 < height, flags[y + 1][x] == false {
                y += 1
            }
            else {
                dir = .Left
                x -= 1
            }
        case .Left:
            if x - 1 >= 0, x - 1 < width, flags[y][x - 1] == false {
                x -= 1
            }
            else {
                dir = .Up
                y -= 1
            }
        case .Up:
            if y - 1 >= 0, y - 1 < height, flags[y - 1][x] == false {
                y -= 1
            }
            else {
                dir = .Right
                x += 1
            }
        }
    }
    
    return result
}

let matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]

spiralOrder(matrix)

//: [Next](@next)
