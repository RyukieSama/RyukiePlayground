//: [Previous](@previous)

import Foundation

/*:
 给你一个二维矩阵 matrix 和一个整数 k ，矩阵大小为 m x n 由非负整数组成。
 
 矩阵中坐标 (a, b) 的 值 可由对所有满足 0 <= i <= a < m 且 0 <= j <= b < n 的元素 matrix[i][j]（下标从 0 开始计数）执行异或运算得到。
 
 请你找出 matrix 的所有坐标中第 k 大的值（k 的值从 1 开始计数）。
 
 示例 1：
 
 输入：matrix = [[5,2],[1,6]], k = 1
 输出：7
 解释：坐标 (0,1) 的值是 5 XOR 2 = 7 ，为最大的值。
 示例 2：
 
 输入：matrix = [[5,2],[1,6]], k = 2
 输出：5
 解释：坐标 (0,0) 的值是 5 = 5 ，为第 2 大的值。
 示例 3：
 
 输入：matrix = [[5,2],[1,6]], k = 3
 输出：4
 解释：坐标 (1,0) 的值是 5 XOR 1 = 4 ，为第 3 大的值。
 示例 4：
 
 输入：matrix = [[5,2],[1,6]], k = 4
 输出：0
 解释：坐标 (1,1) 的值是 5 XOR 2 XOR 1 XOR 6 = 0 ，为第 4 大的值。
  
 
 提示：
 
 m == matrix.length
 n == matrix[i].length
 1 <= m, n <= 1000
 0 <= matrix[i][j] <= 106
 1 <= k <= m * n
 
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/find-kth-largest-xor-coordinate-value
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

// MARK: - 我的第一版
struct MatrixIndex: Hashable {
    let x: Int
    let y: Int
}

func kthLargestValue(_ matrix: [[Int]], _ k: Int) -> Int {
    var dp: [MatrixIndex : Int] = [ : ]
    
    let m = matrix.count, n = matrix[0].count
    var values: [Int] = []
    for y in 0..<m {
        for x in 0..<n {
            let v = XORAll(matrix, dp, in: MatrixIndex(x: x, y: y))
            dp[MatrixIndex(x: x, y: y)] = v
            values.append(v)
        }
    }
    
    values.sort()
    values.reverse()
    
    return values[k-1]
}

func XORAll(_ matrix: [[Int]], _ dp: [MatrixIndex : Int], in index: MatrixIndex) -> Int {
    let lastIndex = MatrixIndex(x: index.x - 1, y: index.y)
    var value: Int = dp[lastIndex] ?? matrix[0][index.x]    
    var y = (dp[lastIndex] == nil) ? 1 : 0
    
    while y <= index.y {
        value ^= matrix[y][index.x]
        y += 1
    }
    
    return value
}

// MARK: - 这是别人的答案，我的超时了
func kthLargestValue1(_ matrix: [[Int]], _ k: Int) -> Int {
    
    let H = matrix.count
    let W = matrix[0].count
    
    var XORResults = [Int]()
    
    var lastRowXORResults = Array<Int>(repeating: 0, count: W)
    
    for y in 0..<H {
        var temp = 0
        for x in 0..<W {
            temp ^= matrix[y][x]
            lastRowXORResults[x] ^= temp
            print(lastRowXORResults)
            XORResults.append(lastRowXORResults[x])
            print("XORResults = \(XORResults)")
        }
    }
    
    let counterSize = XORResults.max()! + 1
    var counter = [Int](repeating: 0, count: counterSize)
    
    for num in XORResults {
        counter[num] += 1
    }
    
    var cnt = 0
    for idx in stride(from: counterSize - 1, through: 0, by: -1) {
        cnt += counter[idx]
        if cnt >= k {
            return idx
        }
    }
    return -1
}

// MARK: - 我的第二版：超时
func kthLargestValue2(_ matrix: [[Int]], _ k: Int) -> Int {
    let height = matrix.count
    let width = matrix[0].count
    var results: [Int] = []
    
    var lastLineHXORs: [Int] = Array(repeating: 0, count: width)
    
    for y in 0..<height {
        var lineValue = 0
        for x in 0..<width {
            let v = matrix[y][x]
            lineValue ^= v
            lastLineHXORs[x] ^= lineValue
            results.append(lastLineHXORs[x])
        }
    }
    // 找第K大的元素这里需要优化
    results.sort()
    results.reverse()
    return results[k-1]
}

// MARK: - 我的第三版：

/**
 执行用时：
 3824 ms
 , 在所有 Swift 提交中击败了
 50.00%
 的用户
 内存消耗：
 35.1 MB
 , 在所有 Swift 提交中击败了
 100.00%
 的用户
 */

func kthLargestValue3(_ matrix: [[Int]], _ k: Int) -> Int {
    let height = matrix.count
    let width = matrix[0].count
    var results: [Int] = []
    
    var lastLineHXORs: [Int] = Array(repeating: 0, count: width)
    
    for y in 0..<height {
        var lineValue = 0
        for x in 0..<width {
            let v = matrix[y][x]
            lineValue ^= v
            lastLineHXORs[x] ^= lineValue
            results.append(lastLineHXORs[x])
        }
    }
    
    let counterSize = results.max()! + 1
    var counter = [Int](repeating: 0, count: counterSize)
    
    for num in results {
        counter[num] += 1
    }
    
    var cnt = 0
    for idx in stride(from: counterSize - 1, through: 0, by: -1) {
        cnt += counter[idx]
        if cnt >= k {
            return idx
        }
    }
    return -1
}

// MARK: - 我的第四版：优化找K 超时
func kthLargestValue4(_ matrix: [[Int]], _ k: Int) -> Int {
    let height = matrix.count
    let width = matrix[0].count
    var results: [Int] = []
    
    var lastLineHXORs: [Int] = Array(repeating: 0, count: width)
    
    for y in 0..<height {
        var lineValue = 0
        for x in 0..<width {
            let v = matrix[y][x]
            lineValue ^= v
            lastLineHXORs[x] ^= lineValue
            results.append(lastLineHXORs[x])
        }
    }
    
    return findKthLargest(results, k)
}

// MARK: - 找K
func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    if nums.isEmpty || k == 0 {
        return 0
    }
    var nums1 = nums
    let length = nums1.count
    quickSearch(&nums1, 0, length - 1, length - k)
    
    return nums1[length - k]
}

func quickSearch(_ arr: inout [Int], _ low: Int, _ high: Int, _ k: Int) {
    let res = partition(&arr, low: low, high: high)
    if res == k {
        return
    }
    else if res > k {
        quickSearch(&arr, low, res-1, k)
    }
    else {
        quickSearch(&arr, res+1, high, k)
    }
}

func partition(_ arr: inout [Int], low: Int, high: Int) -> Int {
    var l = low
    var h = high
    while l < h {
        while (l < h && arr[h] >= arr[low]) {
            h = h - 1;
        }
        while (l < h && arr[l] <= arr[low]) {
            l = l + 1;
        }
        (arr[l], arr[h]) = (arr[h], arr[l])
    }
    (arr[low], arr[l]) = (arr[l], arr[low])
    return l // 返回tmp的正确位置
}


let matrix = [[5,2],[1,6]], k = 1

kthLargestValue(matrix, k)

kthLargestValue1(matrix, k)

kthLargestValue2(matrix, k)

kthLargestValue3(matrix, k)

kthLargestValue4(matrix, k)
