//: [Previous](@previous)

/*:
 # 循环标签应用一：
 */

// https://ryukiedev.gitbook.io/leetcode-swift/swift/xun-huan-de-biao-qian-kong-zhi

import Foundation

let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)

// 一些转折点
board[03] = +08;
board[06] = +11;
board[09] = +09;
board[10] = +02
board[14] = -10;
board[19] = -11;
board[22] = -02;
board[24] = -08


var square = 0
var diceRoll = 0
while square < finalSquare {
    // 掷骰子
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // 根据点数移动
    square += diceRoll
    if square < board.count {
        // 如果玩家还在棋盘上，顺着梯子爬上去或者顺着蛇滑下去
        square += board[square]
    }
}
print("Game over!")

//: [Next](@next)
