//: [Previous](@previous)

import Foundation

/*:
输入整数数组 arr ，找出其中最小的 k 个数。例如，输入4、5、1、6、2、7、3、8这8个数字，则最小的4个数字是1、2、3、4。

示例 1：

```
输入：arr = [3,2,1], k = 2
输出：[1,2] 或者 [2,1]
```

示例 2：

```
输入：arr = [0,1,2,1], k = 1
输出：[0]
```

限制：

0 <= k <= arr.length <= 10000
0 <= arr[i] <= 10000

来源：力扣（LeetCode）
 
链接：https://leetcode-cn.com/problems/zui-xiao-de-kge-shu-lcof
 
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/

var arr = [0,0,0,2,0,5], k = 5
arr = [0,0,1,2,4,2,2,3,1,4]
k = 8
//arr = [0,1,1,2,4,4,1,3,3,2]
//k = 6

/**
 2023-03-03
 */
func getLeastNumbers230303(_ arr: [Int], _ k: Int) -> [Int] {
    var res = arr
    guard k < arr.count else {
        return arr
    }
    
    /**
     冒泡
     */
    var switchFlag = false
    for j in 0..<res.count {
        for i in 0..<(res.count - j - 1) {
            if res[i + 1] < res[i] {
                res.swapAt(i, i + 1)
                switchFlag = true
            }
        }
        if switchFlag == false {
            break
        }
        if res.count - j == k {
            break
        }
    }
    
    return Array(res[0..<k])
}
getLeastNumbers230303(arr, k)

/**
 2023-02-10
 */
func getLeastNumbers2310(_ arr: [Int], _ k: Int) -> [Int] {
    if arr.isEmpty || k == 0 { return [] }
    if arr.count == k { return arr }
    // 伪 冒泡
    var numbers = arr, swapFlag = false
    
    for i in 0..<numbers.count {
        for j in 0..<(numbers.count - i - 1) {
            if numbers[j] > numbers[j+1] {
                (numbers[j], numbers[j+1]) = (numbers[j+1], numbers[j])
                swapFlag = true
            }
        }
        
        if !swapFlag || (numbers.count - i == k) {// 提前退出
            break
        }
    }
    
    return Array(numbers[0..<k])
}

getLeastNumbers2310(arr, k)

/**
 2023-02-09
 */
func getLeastNumbers2329(_ arr: [Int], _ k: Int) -> [Int] {
    if arr.isEmpty { return [] }
    if k == arr.count { return arr }
    /**
     冒泡，但不用冒泡完
     */
    var arr = arr
    var switchFlag = false
    
    for i in 0..<arr.count {
        for j in 0..<(arr.count - i - 1) {
            if arr[j] > arr[j+1] {
                arr.swapAt(j, j + 1)
                switchFlag = true
            }
        }
        if switchFlag == false || (arr.count - i == k) {
            print("提前退出")
            break
        }
    }
    
    return Array(arr[0..<k])
}

getLeastNumbers2329(arr, k)

// MARK: - 暴力解法
/**
 暴力解法
 */
func getLeastNumbers(_ arr: [Int], _ k: Int) -> [Int] {
    if k == 0 { return [] }
    if arr.count <= k { return arr }
    let rearr: [Int] = arr.sorted { $0 <= $1 }
    return Array(rearr[0...k-1])
}

// MARK: - 快速排序-辅助空间
/**
 快速排序-辅助空间
 */
func getLeastNumbers2(_ arr: [Int], _ k: Int) -> [Int] {
    if k == 0 { return [] }
    if arr.count <= k { return arr }
    let result = quickSort(arr)
    return Array(result[0...k-1])
}

/**
 辅助空间快速排序
 */
func quickSort<T: Comparable>(_ arr: [T]) -> [T] {
    guard let base = arr.first, arr.count > 1 else {
        return arr
    }
    
    var left: [T] = []
    var right: [T] = []
    var result: [T] = []

    for index in 1..<arr.count {
        let value = arr[index]
        if value < base {
            left.append(value)
        }
        else {
            right.append(value)
        }
    }
        
    result = quickSort(left)
    result.append(base)
    result.append(contentsOf: quickSort(right))
    
    return result
}

// MARK: - 快速排序-原地
/**
 快速排序-原地
 */
func getLeastNumbers3(_ arr: [Int], _ k: Int) -> [Int] {
    if k == 0 { return [] }
    if arr.count <= k { return arr }
    var result = arr
    quickSort2(&result, 0, arr.count - 1, k)
    return Array(result[0...k-1])
}

/**
 原地快速排序
 */
func quickSort2<T: Comparable>(_ arr: inout [T], _ low: Int, _ high: Int, _ k: Int) {
    let res = partition(&arr, low: low, high: high)
    if res == k {
        return
    }
    else if res > k {
        quickSort2(&arr, low, res-1, k)
    }
    else {
        quickSort2(&arr, res+1, high, k)
    }
}

// 确定基准元素的下标
func partition<T: Comparable>(_ arr: inout [T], low: Int, high: Int) -> Int {
    let root = arr[high]
    var index = low
    for i in low...high {
        if arr[i] < root {
            if i != index {
                arr.swapAt(i, index)
            }
            index = index+1
        }
    }
    
    if high != index {
        arr.swapAt(high, index)
    }
    return index
}


// MARK: - 优先队列
/**
 优先队列
 */
func getLeastNumbers4(_ arr: [Int], _ k: Int) -> [Int] {
    var stack = SwiftPriorityQueue<Int>(hasHigherPriority: { $0 > $1 }, isEqual: { $0 == $1 })
    
    arr.forEach { item in
        stack.enqueue(item)
        if stack.count > k {
            stack.dequeue()// 最高优先级的出列（最大的出去）
        }
    }
    
    return stack.array()
}


//getLeastNumbers(arr, k)
//getLeastNumbers3(arr, k)
//getLeastNumbers4(arr, k)
getLeastNumbers5(arr, k)
//quickSort(arr)

//quickSort(data: arr)

/*:
 创建固定容量的容器
 遍历元素
 存满后冒泡排序
 
 继续插入到头
 遍历直到遇到大于等于自己的就停止
 移除最后一个元素
 
 */
func getLeastNumbers5(_ arr: [Int], _ k: Int) -> [Int] {
    var result: [Int] = []
    
    guard k > 0 else {
        return result
    }
    
    arr.forEach { item in
        if result.count == k, let min = result.first {
            
            if item <= min {
                result.insert(item, at: 0)
                result.removeLast()
            }
            else {
                result.insert(item, at: 0)
                
                for i in 0..<(result.count - 1) {
                    if result[i] > result[i+1] {
                        result.swapAt(i, i+1)
                    }
                    else {
                        break
                    }
                }
                
                result.removeLast()
            }
        }
        else {
            result.append(item)
            if result.count == k {
                result = result.sorted()
            }
        }
    }
    
    return result
}

//: [Next](@next)
