//
//  ViewController.swift
//  Easy
//
//  Created by Bart Simpson on 2018/10/31.
//  Copyright © 2018年 BartSimpson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        isBalanced()
//        maxProfit()
//        single()
        QuickSort.sort(items: nums)
    }
    var nums = [24, 69, 80, 57, 13, 99, 28, 3, 77]
    /// 遇到一些思路不清晰的，需要一遍看执行一边想。没错这就是传说中的看着答案也弄不明白
    func isBalanced(){
        let a = TreeNode.init(3)
        a.left = TreeNode.init(9)
        a.right = TreeNode.init(20)
        a.right?.left = TreeNode.init(15)
        a.right?.right = TreeNode.init(7)
        a.right?.right?.right = TreeNode.init(8)
        a.right?.right?.left = TreeNode.init(21)
        Solution().isBalanced(a)
    }
    
    
    let arr = [1,3,4,5,7,8,11,13,19,28,35,67,112,134,156,156,156]
    /// 二分查找
    func binarySearch(target:Int, in numArr:[Int]) -> Int{
        
        /// 如果有重复  要最后的位置
        func getLastTarget(_ target:Int) -> Int {
            var index = target
            if index == numArr.count - 1 {
                return index
            }
            while numArr[index] == numArr[index + 1] {
                index += 1
                if index == numArr.count - 1 {
                    return index
                }
            }
            return index
        }
        
        if numArr.count < 1 {
            return -1
        }
        
        var start = 0, end = numArr.count - 1, mid = 0
        while start < end - 1 {
            /// 有可能存在溢出
            mid = start + (end - start)/2
            if numArr[mid] == target {
                return getLastTarget(mid)
            }else if numArr[mid] > target {
                end = mid
            }else{
                start = mid
            }
        }
        
        if numArr[start] == target {
            return getLastTarget(start)
        }
        
        if numArr[end] == target {
            return getLastTarget(end)
        }
        
        return -1
    }
    
    /// 爬楼梯
    func climbStairs(_ n:Int) -> Int {
        if n <= 2 { return n }
        var f1 = 1, f2 = 2, sum = 0
        for _ in 3...n {
            sum = f1 + f2
            f1 = f2
            f2 = sum
        }
        return sum
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class QuickSort {
    
    class func sort(items: [Int]) -> [Int] {
        var list = items
        QuickSort().quickSort(&list, low: 0, high: list.count - 1)
        return list
    }
    
    /// 将数组以第一个值二分， 比它小的放在前面，比它大的放在后面
    ///
    /// - Parameters:
    ///   - array: 要二分的数组
    ///   - low:
    ///   - high:
    /// - Returns: 分界点
    func partition(_ array:inout [Int], low:Int, high:Int) -> Int {
        var low = low, high = high
        let temp = array[low]
        while low < high {
            
            while low < high && array[high] >= temp {
                high -= 1
            }
            array[low] = array[high]
            while low < high && array[low] <= temp {
                low += 1
            }
            array[high] = array[low]
        }
        array[low] = temp
        return low
    }
    
    func quickSort(_ array:inout [Int], low:Int, high:Int) {
        if low < high {
            let mid = partition(&array, low: low, high: high)
            quickSort(&array, low: low, high: mid - 1)
            quickSort(&array, low: mid + 1, high: high)
        }
        print(array)
    }
}
