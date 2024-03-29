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

var matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]

/**
 2023-03-03
 要细心
 */
func spiralOrder230303(_ matrix: [[Int]]) -> [Int] {
    enum Dir {
        case Up // y - 1
        case Down // y + 1
        case Left // x - 1
        case Right // x + 1
    }
    
    var res: [Int] = [], height = matrix.count, width = matrix.first?.count ?? 0
    guard height > 0, width > 0 else {
        return res
    }
    var x = 0, y = 0, maxY = height - 1, maxX = width - 1, minX = 0, minY = 0
    var d: Dir = .Right
    while x >= minX, y >= minY, x <= maxX, y <= maxY, minX <= maxX, minY <= maxY {
        let val = matrix[y][x]
        res.append(val)
        switch d {
        case .Right:
            x += 1
            if x > maxX {
                x -= 1
                d = .Down
                y += 1
                minY += 1
            }
        case .Left:
            x -= 1
            if x < minX {
                x += 1
                d = .Up
                y -= 1
                maxY -= 1
            }
        case .Up:
            y -= 1
            if y < minY {
                y += 1
                d = .Right
                x += 1
                minX += 1
            }
        case .Down:
            y += 1
            if y > maxY {
                y -= 1
                d = .Left
                x -= 1
                maxX -= 1
            }
        }
    }
    
    return res
}
spiralOrder230303(matrix)

/**
 2023-02-07
 */
func spiralOrder2327(_ matrix: [[Int]]) -> [Int] {
    enum Dirction {
        case left // X - 1
        case right // X + 1
        case up // Y - 1
        case down // Y + 1
    }
    var height = matrix.count
    var res: [Int] = []
    
    guard height > 0 else { return res }
    
    let width = matrix[0].count
    
    var dir: Dirction = .right
    
    var x = 0, y = 0
    var minx = 0, maxx = width - 1
    var miny = 0, maxy = height - 1
    
    while x >= minx, x <= maxx, y >= miny, y <= maxy {
        let val = matrix[y][x]
//        print("\(dir), val = \(val), x = \(x), y = \(y) \n minx = \(minx), maxx = \(maxx), miny = \(miny), maxy = \(maxy) \n")
        res.append(val)
        switch dir {
        case .right:
            if x == maxx {
                dir = .down
                miny += 1
                y += 1
            }
            else {
                x += 1
            }
        case .down:
            if y == maxy {
                dir = .left
                maxx -= 1
                x -= 1
            }
            else {
                y += 1
            }
        case .left:
            if x == minx {
                dir = .up
                maxy -= 1
                y -= 1
            }
            else {
                x -= 1
            }
        case .up:
            if y == miny {
                dir = .right
                minx += 1
                x += 1
            }
            else {
                y -= 1
            }
        }
    }
    
    return res
}

spiralOrder2327(matrix)

/**
 2023-02-06
 不难，需要细心
 */
func spiralOrder2326(_ matrix: [[Int]]) -> [Int] {
    var res: [Int] = []
    var height = matrix.count, width = height > 0 ? matrix[0].count : 0
    
    if height == 0 { return res }
    if height == 1 { return matrix[0] }
    
    enum Dir {
        case right
        case left
        case up
        case down
    }
    
    var dir: Dir = .right
    var x = 0, y = 0
    var minX = 0, maxX = width - 1
    var minY = 0, maxY = height - 1
    
    while width > 0, x >= minX, y >= minY, x <= maxX, y <= maxY {
//        print("x = \(x), y = \(y)")
        let val = matrix[y][x]
        res.append(val)
        
        switch dir {
        case .right:
            if x == maxX {
                minY += 1
                dir = .down
                y += 1
            }
            else {
                x += 1
            }
        case .left:
            if x == minX {
                maxY -= 1
                dir = .up
                y -= 1
            }
            else {
                x -= 1
            }
        case .down:
            if y == maxY {
                maxX -= 1
                dir = .left
                x -= 1
            }
            else {
                y += 1
            }
        case .up:
            if y == minY {
                minX += 1
                dir = .right
                x += 1
            }
            else {
                y -= 1
            }
        }
    }
    
    return res
}

//spiralOrder2326([])
//spiralOrder2326([[]])
spiralOrder2326(matrix)

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

spiralOrder(matrix)

//: [Next](@next)
