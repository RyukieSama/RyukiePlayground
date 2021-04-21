//: [Previous](@previous)

import Foundation

/*:
 
 给你一个整数数组 nums 和两个整数 k 和 t 。请你判断是否存在 两个不同下标 i 和 j，使得 abs(nums[i] - nums[j]) <= t ，同时又满足 abs(i - j) <= k 。
 
 如果存在则返回 true，不存在返回 false。
 
 示例 1：
 
 输入：nums = [1,2,3,1], k = 3, t = 0
 输出：true
 示例 2：
 
 输入：nums = [1,0,1,1], k = 1, t = 2
 输出：true
 示例 3：
 
 输入：nums = [1,5,9,1,5,9], k = 2, t = 3
 输出：false
  
 
 提示：
 
 0 <= nums.length <= 2 * 104
 -231 <= nums[i] <= 231 - 1
 0 <= k <= 104
 0 <= t <= 231 - 1
 
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/contains-duplicate-iii
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */

func containsNearbyAlmostDuplicateTimeOut(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
    // abs(nums[i] - nums[j]) <= t ，同时又满足 abs(i - j) <= k
    
    // abs(i - j) <= k 这个是一个偏移量的条件
    // 每次遍历的下标就有限制
    
    // abs(nums[i] - nums[j]) <= t 数值的条件
    
    var i = 0
    
    while i < nums.count {
        var j = 0
        while j < nums.count {
            if abs(nums[i] - nums[j]) <= t, abs(i - j) <= k, i != j {
                return true
            }
            j += 1
        }
        i += 1
    }
    
    return false
}

// O(nk) 超时
func containsNearbyAlmostDuplicateTimeOut2(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
    // abs(nums[i] - nums[j]) <= t ，同时又满足 abs(i - j) <= k
    if k == 0 {
        return false
    }
    // abs(i - j) <= k 决定了每次需要遍历的下标范围
    var i = 0
    while i < nums.count {
        let start = (i - k) >= 0 ? (i - k) : 0
        let end = ((i + k) < (nums.count - 1)) ? (i + k) : (nums.count - 1)
        print("\(start) ~ \(end)")
        for j in start...end {
            if (abs(nums[i] - nums[j]) <= t), i != j {
                print("\(nums[i]) - \(nums[j])")
                return true
            }
        }
        i += 1
    }
    return false
}

func containsNearbyAlmostDuplicateWrong(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
    // key-取值范围 value-数组下标
    var records: [String : Int] = [ : ]
    
    struct TreeSet {
        
    }
    
    /// 返回一个数值做配对的值的范围 作为Key
    /// - Parameters:
    ///   - num: 数字
    ///   - deta: 差值
    /// - Returns: Key
    func getKey(num: Int, deta: Int) -> String {
        return "\(num-deta)-\(num+deta)"
    }
    
    for (index, n) in nums.enumerated() {
        let currentK = getKey(num: n, deta: t)
        print(currentK + "=Index=\(index)")
        if let ix = records[currentK] {
            if abs(index - ix) <= k {
                return true
            }
        }
        records[currentK] = index
    }
    
    return false
}

func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
    var map = [Int:Int]()
    
    func getID(_ x: Int, _ w: Int) -> Int{
        if x >= 0 {
            return x/w
        }
        return (x+1)/w - 1
    }
    
    for (index,num) in nums.enumerated() {
        let id = getID(num, t + 1)
        if map.keys.contains(id) {
            return true
        }
        if let x = map[id-1] , abs(num - x) <= t {
            return true
        }
        if let y = map[id+1] , abs(num - y) <= t {
            return true
        }
        map.updateValue(num, forKey: id)
        if index >= k {
            map.removeValue(forKey: getID(nums[index-k], t+1))
        }
    }
    return false
}

let nums = [8,7,15,1,6,1,9,15]
containsNearbyAlmostDuplicate(nums, 1, 3)

//: [Next](@next)
