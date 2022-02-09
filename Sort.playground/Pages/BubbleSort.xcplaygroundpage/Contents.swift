//: [Previous](@previous)


/*:
 ## 常规冒泡
 */
func bubbleSortA(nums: [Int]) -> [Int] {
    var nums = nums
    let count = nums.count
    
    for i in 0..<count {
        print("<")
        for j in (i + 1)..<count {
            if nums[i] > nums[j] {
                nums.swapAt(i, j)
            }
            print(nums)
        }
        print(">\n")
    }
    
    return nums
}

/*:
 ## 外层优化
 
 当发现在某一趟排序中没有发生交换，则说明排序已经完成，所以可以在此趟排序后结束排序，在每趟排序前设置flag，当其未发生变化时，终止算法
 */
func bubbleSortB(nums: [Int]) -> [Int] {
    print("bubbleSortB")
    
    var nums = nums
    let count = nums.count
    
    for i in 0..<count {
        var swapFlag = true
        print("<")
        for j in (i + 1)..<count {
            if nums[i] > nums[j] {
                nums.swapAt(i, j)
                swapFlag = false
            }
            print(nums)
        }
        print(">\n")
        if swapFlag {
            break
        }
    }
    
    return nums
}

/*:
 ## 内层优化
 
 在每趟排序中，右面的许多元素已经是有序的结果了，可算法还是进行后面数值的排序，因此进行第二次优化：
 */
func bubbleSortC(nums: [Int]) -> [Int] {
    print("bubbleSortC")
    
    var nums = nums
    var boundary = nums.count - 1
    var lastSwapIdx = 0
    
    for _ in 0..<nums.count {
        var swapFlag = true
        print("<")
        for j in 0..<boundary {
            if nums[j] > nums[j+1] {
                nums.swapAt(j, j+1)
                swapFlag = false
                lastSwapIdx = j
            }
            print(nums)
        }
        print(">\n")
        boundary = lastSwapIdx
        if swapFlag {
            break
        }
    }
    
    return nums
}

//let numbers: [Int] = [3, 8, 7, 6, 5, 2, 4, 1, 11, 12]

let numbers: [Int] = [3, 5, 1, 11, 2, 4, 12]

//let numbers: [Int] = [6, 8, 7, 6, 5, 4, 1, 2, 3]

bubbleSortA(nums: numbers)
bubbleSortB(nums: numbers)
bubbleSortC(nums: numbers)

//: [Next](@next)
