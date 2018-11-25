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
    
}
