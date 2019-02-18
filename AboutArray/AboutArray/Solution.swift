//
//  Solution.swift
//  AboutArray
//
//  Created by Bart Simpson on 2018/11/23.
//  Copyright © 2018年 BartSimpson. All rights reserved.
//

import UIKit

class Solution: NSObject {

    /// 4. 寻找两个有序数组的中位数
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        
        var mid = 0.0
        var nums = [Int].init(nums1)
        nums.append(contentsOf: [Int].init(nums2))
        nums = nums.sorted()
        let len = nums.count
        if len % 2 == 0 {
            
            mid = Double(nums[len/2] + nums[len/2 - 1])/2.0
        }else{
            mid = Double(nums[len/2])
        }
        return mid
    }
    
    /// 11. 盛最多水的容器
    func maxArea(_ height: [Int]) -> Int {
     
        var maxArea = 0, l = 0, r = height.count - 1
        while l < r {
            
            maxArea = max(maxArea, min(height[l], height[r]) * (r - l))
            if height[l] < height[r] {
                l += 1
            }else {
                r -= 1
            }
        }
        return maxArea
    }
    
    /// 15.三数之和
    func threeSum(_ nums: [Int]) -> [[Int]] {
        
        var nums = nums.sorted()
        var result = [[Int]]()
        
        for i in 0..<nums.count {
            /// 因为已经从小到大排序，i大于0则后面的数相加肯定大于0
            if nums[i] > 0 { break }
            /// 去重
            if i > 0 && nums[i] == nums[i-1] { continue }
            var low = i + 1
            var high = nums.count - 1
            
            while low < high {
                
                if nums[low] + nums[high] + nums[i] == 0 {
                    
                    result.append([nums[i], nums[low], nums[high]])
                    
                    while low < high && nums[low] == nums[low+1]{
                        low += 1
                    }
                    while low < high && nums[high] == nums[high-1] {
                        high -= 1
                    }
                    low += 1
                    high -= 1
                }else if nums[low] + nums[high] + nums[i] > 0 {
                    high -= 1
                }else {
                    low += 1
                }
            }
        }
        return result
    }
    
    /// 16.最接近的三数之和
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        
        let nums = nums.sorted()
        var close = nums[0] + nums[1] + nums[2]
        
        for i in 0..<nums.count {
            
            if i != 0 && nums[i] > target { break }
            if i > 0 && nums[i] == nums[i-1] { continue }
            var left = i + 1
            var right = nums.count - 1
            while left < right {
                let current = nums[i] + nums[left] + nums[right]
                if abs(close - target) > abs(current - target) {
                    close = current
                }
                if current < target {
                    left += 1
                }else{
                    right -= 1
                }
            }
        }
        return close
    }
    
    /// 18.四数之和
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        var result = [[Int]]()
        if nums.count < 4 {
            return result
        }
        var nums = nums.sorted()
        for i in 0..<nums.count-1 {
            if target > 0 && nums[i] > target { break }
            if target < 0 && nums[i] > 0 { break }
            if i > 0 && nums[i] == nums[i-1] { continue }
            
            for j in i+1..<nums.count {
                
                if target > 0 && nums[i] + nums[j] > target { break }
                if target < 0 && nums[i] + nums[j] > 0 { break }
                if j > i+1 && nums[j] == nums[j-1] { continue }
                
                var l = j + 1, r = nums.count - 1
                while l < r {
                    
                    let sum = nums[i] + nums[j] + nums[l] + nums[r]
                    if sum == target {
                        result.append([nums[i], nums[j], nums[l], nums[r]])
                        while l < r && nums[l] == nums[l+1] { l += 1 }
                        while l < r && nums[r] == nums[r-1] { r -= 1 }
                        l += 1
                        r -= 1
                    }else if sum < target {
                        l += 1
                    }else{
                        r -= 1
                    }
                }
            }
        }
        return result
    }
    
    /// 33.搜索旋转排序数组
    func search(_ nums: [Int], _ target: Int) -> Int {
        /// 二分法来做
        if nums.count < 1 { return -1 }
        var left = 0
        var right = nums.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if nums[mid] == target { return mid }
            
            if nums[mid] >= nums[left] {
                if target < nums[mid] && target >= nums[left] {
                    right = mid - 1
                }else {
                    left = mid + 1
                }
            }
            
            if nums[mid] <= nums[right] {
                if target > nums[mid] && target <= nums[right] {
                    left = mid + 1
                }else {
                    right = mid - 1
                }
            }
        }
        return -1
    }
    
    /// 34. 在排序数组中查找元素的第一个和最后一个位置
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        
        var left = 0, right = nums.count
        var mid = (left + right) / 2
        
        var p = -1
        while left < right {
            if nums[mid] == target {
                p = mid
                break
            }
            
            if nums[mid] > target {
                if right == mid { break }
                right = mid
                mid = (left + right) / 2
            }else{
                if left == mid { break }
                left = mid
                mid = (left + right) / 2
            }
        }
        
        if p == -1 {
            return [-1, -1]
        }else{
            var fisrt = p, last = p
            while fisrt > 0 && nums[fisrt - 1] == target {
                fisrt -= 1
            }
            while last < nums.count - 1 && nums[last + 1] == target {
                last += 1
            }
            return [fisrt, last]
        }
    }
    
    /// 39. 组合总和
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        
        func helper(_ tmp:inout [Int], res:inout [[Int]], index:Int, candidatesCopy:[Int], target:Int){
            
            if target == 0 {
                res.append(tmp)
                return
            }else if index == candidatesCopy.count {
                return
            }
            
            for i in index..<candidatesCopy.count {
                if candidatesCopy[i] > target{
                    return
                }else if i != index && candidatesCopy[i] == candidatesCopy[i - 1] {
                    continue
                }
                tmp.append(candidatesCopy[i])
                helper(&tmp, res: &res, index: i, candidatesCopy: candidatesCopy, target: target - candidatesCopy[i])
                tmp.removeLast()
            }
        }
        
        let can = candidates.sorted()
        var tmp = [Int]()
        var res = [[Int]]()
        let index = 0
        helper(&tmp, res: &res, index: index, candidatesCopy: can, target: target)
        return res
    }
    
    /// 48. 旋转图像 12ms
    func rotate(_ matrix: inout [[Int]]) {
        let n = matrix.count
        
        for layer in 0..<n/2 {
            let start = layer, end = n - layer - 1
            for i in start..<end {
                let offset = i - start
                
                (matrix[start][i], matrix[i][end], matrix[end][end - offset], matrix[end - offset][start]) = (matrix[end - offset][start], matrix[start][i], matrix[i][end], matrix[end][end - offset])
            }
        }
    }
    
    /// 傻子解法
    func rotateForIdiot(_ matrix: inout [[Int]]) {
        var out = [[Int]]()
        while matrix[0].count != 0 {
            
            var res = [Int]()
            for i in 0..<matrix.count {
                res.insert(matrix[i].removeFirst(), at: 0)
            }
            out.append(res)
        }
        matrix = out
    }
    
    /// 54.螺旋矩阵
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var res = [Int]()
        if (matrix.count == 0) {
            return res
        }
        var startX = 0
        var endX = matrix.count - 1
        var startY = 0
        var endY = matrix[0].count - 1
        
        while(true) {
            for i in startY...endY {
                res.append(matrix[startX][i])
            }
            startX += 1
            if (startX > endX) {
                break
            }
            
            for i in startX...endX {
                res.append(matrix[i][endY])
            }
            endY -= 1
            if (endY < startY) {
                break
            }
            
            /// stride 函数返回一个任意可变步长 类型值的序列
            /// from，through，最后一个值将会小(大)于等于through的值
            for i in stride(from: endY, through:startY, by:-1) {
                res.append(matrix[endX][i])
            }
            endX -= 1
            if (endX < startX) {
                break
            }
            for i in stride(from:endX, through:startX, by:-1) {
                res.append(matrix[i][startY])
            }
            startY += 1
            if (startY > endY) {
                break
            }
        }
        return res
    }
    
    /// 55.跳跃游戏
    func canJump(_ nums: [Int]) -> Bool {
        var maxreach = 0
        for i in 0..<nums.count {
            if i > maxreach {
                return false
            }
            maxreach = max(maxreach, i + nums[i])
            if maxreach >= nums.count {
                return true
            }
        }
        return true
    }
    
    /// 59.螺旋矩阵II
    func generateMatrix(_ n: Int) -> [[Int]] {
        guard n > 0 else { return [[Int]]() }
        
        var num = 1
        var result = [[Int]].init(repeating: [Int].init(repeating: 0, count: n), count: n)
        
        for layer in 0..<n/2 {
            let start = layer
            let end = n - layer - 1
            
            // top 不包含右上角
            for i in start..<end {
                result[start][i] = num
                num += 1
            }
            
            // right 不包含右下角
            for i in start..<end {
                result[i][end] = num
                num += 1
            }
            
            // bottom 不包含左下角 stride(from: 2, to: 0, by: -1) to语法 2..>0 不包括0
            for i in stride(from: end, to: start, by: -1) {
                result[end][i] = num
                num += 1
            }
            
            // left 不包左上角
            for i in stride(from: end, to: start, by: -1) {
                result[i][start] = num
                num += 1
            }
        }
        
        // handle the center one
        if n % 2 != 0 {
            result[n/2][n/2] = n * n
        }
        
        return result
    }
    
    /// 268.缺失数字
    func missingNumber(_ nums: [Int]) -> Int {
        
        let nums = nums.sorted()
        for (index,num) in nums.enumerated() {
            if index != num {
                return index
            }
        }
        return nums.count
    }
    
    func missingNumberBest(_ nums: [Int]) -> Int {
        
        var lost = 0
        /// 序列相加 0+1+2+...n  - 所有的数相加 = 漏掉的数
        for i in 0...nums.count {
            
            lost += i
            if i < nums.count {
                lost -= nums[i]
            }
        }
        return lost
    }
    
    /*这是底线*/
}
