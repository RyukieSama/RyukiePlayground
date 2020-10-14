//: [Previous](@previous)

/*:
 # 循环标签应用二：
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

gameLoop: while square != finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
    case finalSquare:
        print("骰子数刚好使玩家移动到最终的方格里，游戏结束。")
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        print("骰子数将会使玩家的移动超出最后的方格，那么这种移动是不合法的，玩家需要重新掷骰子")
        continue gameLoop
    default:
        print("合法移动，做正常的处理")
        square += diceRoll
        square += board[square]
    }
}
print("Game over!")

//: [Next](@next)
