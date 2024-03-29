//: [Previous](@previous)

import Foundation

/*:
 地上有一个m行n列的方格，从坐标 [0,0] 到坐标 [m-1,n-1] 。
 
 一个机器人从坐标 [0, 0] 的格子开始移动，它每次可以向左、右、上、下移动一格（不能移动到方格外），也不能进入行坐标和列坐标的数位之和大于k的格子。
 
 例如，当k为18时，机器人能够进入方格 [35, 37] ，因为3+5+3+7=18。但它不能进入方格 [35, 38]，因为3+5+3+8=19。请问该机器人能够到达多少个格子？
 
 
 示例 1：
 
 ```C++
 输入：m = 2, n = 3, k = 1
 输出：3
 ```
 
 示例 2：
 
 ```C++
 输入：m = 3, n = 1, k = 0
 输出：1
 ```
 
 提示：
 
 ```C++
 1 <= n,m <= 100
 0 <= k <= 20
 ```
 
 来源：力扣（LeetCode）
 
 
 链接：https://leetcode-cn.com/problems/ji-qi-ren-de-yun-dong-fan-wei-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

let m = 2, n = 3, k = 1
//let m = 3, n = 1, k = 0
//let m = 1, n = 3, k = 11

/**
 2023-03-03
 */
func movingCount230303(_ m: Int, _ n: Int, _ k: Int) -> Int {
    guard m > 0, n > 0 else {
        return 0
    }
    guard k > 0 else {
        return 1
    }
    let height = m, width = n
    var count = 0, flags: [[Bool]] = Array(repeating: Array(repeating: false, count: n), count: m)
    
    move(0, 0)
    
    func digSum(_ a: Int, _ b: Int) -> Int {
        var sum = 0, a = a, b = b
        
        while a > 0 {
            sum += a % 10
            a /= 10
        }
        
        while b > 0 {
            sum += b % 10
            b /= 10
        }
        
        return sum
    }
    
    func move(_ x: Int, _ y: Int) {
        guard x >= 0, y >= 0, x < width, y < height else {
            return
        }
        
        if flags[y][x] == false, digSum(x, y) <= k {
            count += 1
            flags[y][x] = true
            move(x, y - 1)
            move(x, y + 1)
            move(x - 1, y)
            move(x + 1, y)
        }
    }
    
    return count
}
movingCount230303(m, n, k)


/**
 2023-02-27
 */
func movingCount23227(_ m: Int, _ n: Int, _ k: Int) -> Int {
    var flagMap: [[Bool]] = Array(repeating: Array(repeating: false, count: n), count: m)
    
    func countCore(_ x: Int, _ y: Int) -> Int {
        guard x >= 0, y >= 0, x < n, y < m, flagMap[y][x] == false else {
            return 0
        }
        flagMap[y][x] = true
        if numSum(x, y) <= k {
            return 1 + countCore(x - 1, y) + countCore(x + 1, y) + countCore(x, y - 1) + countCore(x, y + 1)
        }
        return 0
    }
    
    func numSum(_ a: Int, _ b: Int) -> Int {
        var sum = 0, a = a, b = b
        
        while a > 0 {
            sum += a % 10
            a /= 10
        }
        
        while b > 0 {
            sum += b % 10
            b /= 10
        }
        
        return sum
    }
        
    return countCore(0, 0)
}

movingCount23227(m, n, k)

// MARK: - 深度优先

func movingCount(_ m: Int, _ n: Int, _ k: Int) -> Int {
    if m <= 0 || n <= 0 || k < 0 {
        return 0
    }
    var flags: [[Bool]] = Array(repeating: Array(repeating: false, count: n), count: m)
    return moveTo(0, 0, k, flags: &flags)
}

func moveTo(_ x: Int, _ y: Int, _ k: Int, flags: inout [[Bool]]) -> Int {
    if (x < 0 || x >= flags.first?.count ?? 0) ||
        (y < 0 || y >= flags.count) ||
        (flags[y][x] == true) ||
        (digitSum(x) + digitSum(y) > k)
    {
        return 0
    }
    
    flags[y][x] = true
    
    let count = 1
        + moveTo(x + 1, y, k, flags: &flags)
        + moveTo(x - 1, y, k, flags: &flags)
        + moveTo(x, y + 1, k, flags: &flags)
        + moveTo(x, y - 1, k, flags: &flags)
    
    return count
}

func digitSum(_ num: Int) -> Int {
    var temp = num
    var result = 0
    while temp > 0 {
        result += temp % 10
        temp = Int(floor(Double(temp) / 10.0))
    }
    return result
}

// MARK: - 深度优先优化
/*:
 在深度优先的解法中，我们才拆分为了`上下左右`四个方向的子问题。

 但实际上本题只需要`右下`两个方向就可以，因为上左一定是走过的。
 */
func moveTo2(_ x: Int, _ y: Int, _ k: Int, flags: inout [[Bool]]) -> Int {
    if (x < 0 || x >= flags.first?.count ?? 0) ||
        (y < 0 || y >= flags.count) ||
        (flags[y][x] == true) ||
        (digitSum(x) + digitSum(y) > k)
    {
        return 0
    }
    
    flags[y][x] = true
    
    let count = 1
        + moveTo(x + 1, y, k, flags: &flags)
        + moveTo(x, y + 1, k, flags: &flags)
    
    return count
}

// MARK: - 广度优先
func movingCount_bfs(_ m: Int, _ n: Int, _ k: Int) -> Int {
    var visited = Array(repeating: Array(repeating: false, count: n), count: m)
    var result = 0
    
    var queue:Array = [(0,0,0,0)]//
    while !queue.isEmpty{
        let (y,x,si,sj) = queue.removeFirst()
        if y >= m || x >= n || k < si + sj || visited[y][x]{
            continue
        }
        visited[y][x] = true
        result = result + 1
        queue.append((y + 1, x, digitSum(y + 1), sj))
        queue.append((y, x + 1, si, digitSum(x + 1)))
    }
    return result
}

digitSum(191111111)

movingCount(m, n, k)
movingCount_bfs(m, n, k)
//: [Next](@next)
