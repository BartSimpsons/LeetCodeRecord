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
        
        /// 二分法来做  暂歇一天
        return 0
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
}
