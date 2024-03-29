//: [Previous](@previous)

import Darwin

/*:
如何得到一个数据流中的中位数？如果从数据流中读出奇数个数值，那么中位数就是所有数值排序之后位于中间的数值。如果从数据流中读出偶数个数值，那么中位数就是所有数值排序之后中间两个数的平均值。

例如，

[2,3,4] 的中位数是 3

[2,3] 的中位数是 (2 + 3) / 2 = 2.5

设计一个支持以下两种操作的数据结构：

void addNum(int num) - 从数据流中添加一个整数到数据结构中。
double findMedian() - 返回目前所有元素的中位数。
 
示例 1：

输入：
["MedianFinder","addNum","addNum","findMedian","addNum","findMedian"]
[[],[1],[2],[],[3],[]]
输出：[null,null,null,1.50000,null,2.00000]
 
 
示例 2：

输入：

["MedianFinder","addNum","findMedian","addNum","findMedian"]
[[],[2],[],[3],[]]
 
输出：[null,null,2.00000,null,2.50000]

限制：

最多会对 addNum、findMedian 进行 50000 次调用。
注意：本题与主站 295 题相同：https://leetcode-cn.com/problems/find-median-from-data-stream/

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/shu-ju-liu-zhong-de-zhong-wei-shu-lcof
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/


/**
 2023-02-09
 
 冒泡。超出限制，算了
 */
class MedianFinder2329 {
    var dataFlow: [Int] = []

    /** initialize your data structure here. */
    init() {

    }
    
    func addNum(_ num: Int) {
        guard dataFlow.isEmpty == false else {
            dataFlow.append(num)
            return
        }
        
        for i in 0..<dataFlow.count {
            if dataFlow[i] >= num {
                dataFlow.insert(num, at: i)
                return
            }
        }
        dataFlow.append(num)
    }
    
    func findMedian() -> Double {
        let count = dataFlow.count
        if count & 1 == 1 {
            return Double(dataFlow[count / 2])
        }
        else {
            return Double(dataFlow[count / 2 - 1] + dataFlow[count / 2]) / 2.0
        }
    }
}


// 大小堆法
class MedianFinder {
    
    var minStack = SwiftPriorityQueue<Int>(hasHigherPriority: { $0 > $1 }, isEqual: { $0 == $1 })
    var maxStack = SwiftPriorityQueue<Int>(hasHigherPriority: { $0 < $1 }, isEqual: { $0 == $1 })
    
    /** initialize your data structure here. */
    init() {

    }
    
    func addNum(_ num: Int) {
        if maxStack.count > minStack.count {
            minStack.enqueue(num)
        }
        else if minStack.count > maxStack.count {
            maxStack.enqueue(num)
        }
        else {
            if let minMax = minStack.array().first, minMax > num {
                minStack.enqueue(num)
            }
            else if let maxMin = maxStack.array().first, maxMin < num {
                maxStack.enqueue(num)
            }
            else {
                maxStack.enqueue(num)
            }
        }
        
        if let minMax = minStack.array().first, let maxMin = maxStack.array().first, minMax > maxMin {
            minStack.dequeue()
            minStack.enqueue(maxMin)
            
            maxStack.dequeue()
            maxStack.enqueue(minMax)
        }
        
//        print("大堆：\(maxStack)")
//        print("小堆：\(minStack)")
//        print("======")
    }

    func findMedian() -> Double {
        if minStack.count == maxStack.count, let a = minStack.peek(), let b = maxStack.peek() {
            return Double((a + b)) / 2.0
        }
        else if minStack.count > maxStack.count {
            return Double(minStack.peek() ?? 0)
        }
        else if maxStack.count > minStack.count {
            return Double(maxStack.peek() ?? 0)
        }
        return 0
    }
}

let obj = MedianFinder()
obj.addNum(-1)
obj.addNum(-2)
obj.addNum(-3)
obj.addNum(-4)
obj.addNum(-5)
obj.addNum(6)

let ret_2: Double = obj.findMedian()

//: [Next](@next)
