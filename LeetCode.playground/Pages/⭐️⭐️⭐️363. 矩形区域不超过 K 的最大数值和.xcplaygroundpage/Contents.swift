//: [Previous](@previous)

import Foundation

/*:
 给你一个 m x n 的矩阵 matrix 和一个整数 k ，找出并返回矩阵内部矩形区域的不超过 k 的最大数值和。
 
 题目数据保证总会存在一个数值和不超过 k 的矩形区域。
  
 示例 1：
 
 输入：matrix = [[1,0,1],[0,-2,3]], k = 2
 输出：2
 解释：蓝色边框圈出来的矩形区域 [[0, 1], [-2, 3]] 的数值和是 2，且 2 是不超过 k 的最大数字（k = 2）。
 示例 2：
 
 输入：matrix = [[2,2,-1]], k = 3
 输出：3
 
 提示：
 
 m == matrix.length
 n == matrix[i].length
 1 <= m, n <= 100
 -100 <= matrix[i][j] <= 100
 -105 <= k <= 105
  
 
 进阶：如果行数远大于列数，该如何设计解决方案？
 
 
 链接：https://leetcode-cn.com/problems/max-sum-of-rectangle-no-larger-than-k
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

//let matrix = [
//    [1,0,1],
//    [0,-2,3]
//]
//let k = 2
// 2

//let matrix = [[2,2,-1]]
//let k = 0
// -1

let matrix = [
    [5,-4,-3,4],
    [-3,-4,4,5],
    [5,1,5,-4]
]
let k = 8
// 8

// MARK: - 一：暴力超时
func maxSumSubmatrixTimeOut(_ matrix: [[Int]], _ k: Int) -> Int {
    var maxSumValue: Int?
    
    let totalHeight = matrix.count
    let totalWidth = matrix.first?.count ?? 0
    
    print("总高度\(totalHeight)总宽度\(totalWidth)")
    
    for width in 1...totalWidth {
        for height in 1...totalHeight {
            // w h 决定了矩形的形态
            // 把每种形态的矩形都去计算一下
            // 从0，0开始移动
            var y = 0
            
            while y <= (totalHeight - height) { // 不够矩形的高度了就停止
                var x = 0
                // 开始移动
                while x <= (totalWidth - width) { // 不能再右移
                    // 开始计算矩形内元素和
                    
                    // 左上角 x,y 右下角 (x + width - 1, y + height - 1)
                    var sum = 0
                    
                    print("当前矩形宽\(width)高\(height)在第\(y)层第\(x)列")
                    
                    var xPoint = x
                    
                    while xPoint <= (x + width - 1) {
                        var yPoint = y
                        while yPoint <= (y + height - 1) {
                            sum += matrix[yPoint][xPoint]
                            yPoint += 1
                        }
                        xPoint += 1
                    }
                    
                    
                    if sum <= k {
                        if maxSumValue == nil {
                            maxSumValue = sum
                        }
                        else if let max = maxSumValue, sum > max {
                            maxSumValue = sum
                        }
                    }
                    
                    x += 1
                }
                y += 1
                print("===换行===")
            }
            
        }
    }
    
    return maxSumValue ?? 0
}

// MARK: - 二：
func maxSumSubmatrix(_ matrix: [[Int]], _ k: Int) -> Int {
    return 0
}

maxSumSubmatrix(matrix, k)

//: [Next](@next)
