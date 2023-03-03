//: [Previous](@previous)

import Foundation

/*:
 给定一个 m x n 二维字符网格 board 和一个字符串单词 word 。如果 word 存在于网格中，返回 true ；否则，返回 false 。
 
 单词必须按照字母顺序，通过相邻的单元格内的字母构成，其中“相邻”单元格是那些水平相邻或垂直相邻的单元格。同一个单元格内的字母不允许被重复使用。
 
  
 
 例如，在下面的 3×4 的矩阵中包含单词 "ABCCED"（单词中的字母已标出）。
 
 |A|B|C|E|
 |S|F|C|S|
 |A|D|E|E|
 
 示例 1：
 
 输入：board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
 输出：true
 示例 2：
 
 输入：board = [["a","b"],["c","d"]], word = "abcd"
 输出：false
  
 
 提示：
 
 1 <= board.length <= 200
 1 <= board[i].length <= 200
 board 和 word 仅由大小写英文字母组成
  
 
 注意：本题与主站 79 题相同：https://leetcode-cn.com/problems/word-search/
 
 
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/ju-zhen-zhong-de-lu-jing-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
let board:[[Character]] = [
    ["A","B","C","E"],
    ["S","F","C","S"],
    ["A","D","E","E"]]
let word: String = "ABCCED"

/**
 2023-03-03
 */
func exist230303(_ board: [[Character]], _ word: String) -> Bool {
    let height = board.count, width = board.first?.count ?? 0
    
    guard height > 0, width > 0, word.isEmpty == false else { return true }
    var flags: [[Bool]] = Array(repeating: Array(repeating: false, count: width), count: height), charArray = Array(word)
    var idx = 0
    
    // 选择起点
    for v in 0..<height {
        for h in 0..<width {
            if match(h, v) {
                return true
            }
        }
    }
    
    // 从某一点开始是否能够完成
    func match(_ x: Int, _ y: Int) -> Bool {
        guard idx < word.count else {
            return true
        }
        if x >= 0,
           y >= 0,
           x < width,
           y < height,
           charArray[idx] == board[y][x],
           flags[y][x] == false {
            flags[y][x] = true
            idx += 1
            
            let res = match(x - 1, y) || match(x + 1, y) || match(x, y - 1) || match(x, y + 1)
            if res {
                return res
            }
            
            flags[y][x] = false
            idx -= 1
        }
        
        return false
    }
    
    return false
}
exist230303(board, word)


/**
 2023-02-27
 */
func exist23227(_ board: [[Character]], _ word: String) -> Bool {
    var height = board.count, width = height > 0 ? board[0].count : 0
    // 插眼
    var flagMap: [[Bool]] = Array(repeating: Array(repeating: false, count: width), count: height)
    var wordIdx = 0, chrArr = Array(word)
    
    for v in 0..<height {
        for h in 0..<width {
            if matchWords(vIdx: v, hIdx: h) {
                return true
            }
        }
    }
    
    func matchWords(vIdx: Int, hIdx: Int) -> Bool {
        guard wordIdx < word.count else {
            return true
        }
        
        if vIdx >= 0,
           vIdx < height,
           hIdx >= 0,
           hIdx < width,
           chrArr[wordIdx] == board[vIdx][hIdx],
           flagMap[vIdx][hIdx] == false {
            wordIdx += 1
            flagMap[vIdx][hIdx] = true
            let res = matchWords(vIdx: vIdx - 1, hIdx: hIdx) ||
            matchWords(vIdx: vIdx + 1, hIdx: hIdx) ||
            matchWords(vIdx: vIdx, hIdx: hIdx - 1) ||
            matchWords(vIdx: vIdx, hIdx: hIdx + 1)
            
            if res == false {
                wordIdx -= 1
                flagMap[vIdx][hIdx] = false
            }
            else {
                return res
            }
            
        }
        return false
    }
    
    return false
}
exist23227(board, word)

/**
 1、确定首字符
 2、重头开始移动开始查找
 3、找到目标，保存 firstNode 位置，第4步；遍历完成也没找到 return false
 4、从 firstNode 位置开始发散寻找第二个字符
 5、找到下一个字符，找到下一个 添加节点 nextNode；找不到下一个字符，从firstNode位置开始继续查找第一个，重置firstNode，跳第三步
 6、如果没有下一个需要查找，即查找到符合要求的了，return true；否则，继续执行第五步
 */
func exist(_ board: [[Character]], _ word: String) -> Bool {
    let maxY = board.count
    let chars: [Character] = Array(word)
    
    guard let maxX = board.first?.count, maxY > 0, maxX > 0 else {
        return false
    }
    
    // 用于保存访问状态
    var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: maxX), count: maxY)
    
    var pathLength = 0
    
    for y in 0..<maxY {
        for x in 0..<maxX {
            if hasPathCore(board, chars, maxX: maxX, maxY: maxY, pathLength: &pathLength, x: x, y: y, visted: &visited) {
                return true
            }
        }
    }
    
    return false
}

func hasPathCore(_ board: [[Character]], _ chars: [Character], maxX: Int, maxY: Int, pathLength: inout Int, x: Int, y: Int, visted: inout [[Bool]]) -> Bool {
    if pathLength == chars.count {
        return true
    }
    
    var result = false
    print("\(x)-\(y)-\(pathLength)-\(chars[pathLength])")
    if x >= 0, y >= 0,
       x < maxX, y < maxY,
       visted[y][x] == false,
       board[y][x] == chars[pathLength]
    {
        print("asdasda")
        pathLength += 1
        visted[y][x] = true
        
        result =
        hasPathCore(board, chars, maxX: maxX, maxY: maxY, pathLength: &pathLength, x: x - 1, y: y, visted: &visted) ||
        hasPathCore(board, chars, maxX: maxX, maxY: maxY, pathLength: &pathLength, x: x + 1, y: y, visted: &visted) ||
        hasPathCore(board, chars, maxX: maxX, maxY: maxY, pathLength: &pathLength, x: x, y: y - 1, visted: &visted) ||
        hasPathCore(board, chars, maxX: maxX, maxY: maxY, pathLength: &pathLength, x: x, y: y + 1, visted: &visted)
        
        if result == false {
            pathLength -= 1
            visted[y][x] = false
        }
    }
    
    return result
}

exist(board, word)

//: [Next](@next)
