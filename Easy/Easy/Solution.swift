//
//  Solution.swift
//  Test
//
//  Created by Bart Simpson on 2018/10/11.
//  Copyright © 2018年 BartSimpson. All rights reserved.
//

import UIKit

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

/// 简单合集
class Solution {
    /// 1.两数之和
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        
        for i in 0..<nums.count{
            for j in i+1..<nums.count{
                if (target - nums[i] == nums[j]) {
                    return [i, j]
                }
            }
        }
        return [Int]()
    }
    
    /// 2.两数相加 中等难度乱入
    public func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        let dummyHead = ListNode.init(0)
        var p = l1, q = l2, curr = dummyHead
        var carry = 0
        while (p != nil || q != nil) {
            let x = p != nil ? p?.val : 0
            let y = q != nil ? q?.val : 0
            let sum = carry + x! + y!
            carry = sum / 10
            curr.next = ListNode.init(sum % 10)
            curr = curr.next!
            if p != nil { p = p?.next }
            if q != nil { q = q?.next }
        }
        if carry > 0 {
            curr.next = ListNode.init(carry)
        }
        print(dummyHead.val)
        return dummyHead.next
    }
    
    /// 7.反转整数
    public func reverse(_ x: Int) -> Int {
        
        var x = x
        var rev = 0
        while x != 0 {
            let p = x % 10
            x /= 10
            if (rev > Int32.max/10 || (rev == Int32.max/10 && p > 7)){
                return 0
            }
            if (rev < Int32.min/10 || (rev == Int32.min/10 && p < -8)){
                return 0
            }
            rev = rev * 10 + p
        }
        return rev
    }
    
    /// 9.回文数
    func isPalindrome(_ p: Int) -> Bool {
        
        if p < 0 || (p % 10 == 0 && p != 0){
            return false
        }
        var x = p
        var rev = 0
        while x > rev {
            rev = rev * 10 + x % 10
            x /= 10
        }
        return x == rev || x == rev/10
    }
    
    /// 13.罗马数字转整数
    func romanToInt(_ s: String) -> Int {
        
        var res = 0
        var dic:[String:Int] = ["I":1, "V":5, "X":10, "L":50, "C":100, "D":500, "M":1000]
        var arr = [String]()
        for str in s {
            arr.append(String.init(str))
        }
        for i in 0..<arr.count {
            /// 肯定有值，强转就好
            let val = dic[arr[i]]!
            if i == arr.count - 1 || (dic[arr[i+1]]! <= dic[arr[i]]!){
                res += val
            }else{
                res -= val
            }
        }
        return res
    }
    
    
    /// 14.最长公共前缀
    func longestCommonPrefix(_ strs: [String]) -> String {
        
        if strs.count == 0 { return "" }
        var prefix = strs[0]
        for i in 0..<strs.count {
            while !strs[i].hasPrefix(prefix){
                
                prefix.removeLast()
                if prefix.isEmpty { return "" }
            }
        }
        return prefix
    }
   
    /// 20.有效的括号
    func isValid(_ s: String) -> Bool {
        
        if  s == "" { return true }
        if s.count % 2 != 0 { return false }
        let closeMap = [")":"(", "}":"{", "]":"["]
        var charStack = [String]()
        for i in 0..<s.count {
            let curChar = s.subString(start: i, length: 1)
            var topElement = ""
            if closeMap[curChar] != nil{
                topElement = charStack.count == 0 ? "#" : charStack.removeLast()
                if topElement != closeMap[curChar] { return false }
            }else{
                charStack.append(curChar)
            }
        }
        return charStack.count == 0
    }
    
    func isValidForQucik(_ s:String) -> Bool {
        var arr = Array<String>()
        for i in s{
            if i == "(" || i == "[" || i == "{" {
                arr.append(String(i))
            }else{
                if arr.count == 0{
                    return false
                }
                let f = arr.last!
                if i == ")"{
                    if f != "("{
                        return false
                    }
                }
                if i == "]"{
                    if f != "["{
                        return false
                    }
                }
                if i == "}"{
                    if f != "{"{
                        return false
                    }
                }
                arr.removeLast()
            }
        }
        return arr.count == 0
    }
    
    /// 21.合并两个有序链表
    func mergeTwoListsForMe(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let out = ListNode.init(0)
        var cur:ListNode? = out
        var numArr = [Int]()
        var l1 = l1
        var l2 = l2
        while l1 != nil {
            numArr.append(l1!.val)
            l1 = l1?.next
        }
        while l2 != nil {
            numArr.append(l2!.val)
            l2 = l2?.next
        }
        numArr.sort()
        
        for i in 0..<numArr.count {
            
            cur?.next = ListNode.init(numArr[i])
            cur = cur?.next
        }
        return out.next
    }
    
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard let l1 = l1 else {
            return l2
        }
        guard let l2 = l2 else {
            return l1
        }
        if l1.val >= l2.val {
            l2.next = mergeTwoLists(l1, l2.next)
            return l2
        }else{
            l1.next = mergeTwoLists(l1.next, l2)
            return l1
        }
    }
    
    func mergeTwoLists2(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1 = l1
        var l2 = l2
        if l1 == nil {
            return l2
        }
        if l2 == nil {
            return l1
        }
        let res:ListNode = ListNode.init(0)
        var cur:ListNode? = res
        
        while l1 != nil && l2 != nil {
            /*
             输出结果要求从小到大排序
             如果l1的值小，把l1加入新的链表 并把l1的链表头去掉，再循环
             */
            if l1!.val <= l2!.val {
                cur?.next = l1
                
                l1 = l1?.next
            }else{
                cur?.next = l2
                l2 = l2?.next
            }
            /*
             cur拷贝了res的next属性地址，所以每次修改cur.nextd值，res.next也会改变
             同时cur = cur?.next，所以执行cur = cur?.next时  cur的指针指向了下一个
             */
            cur = cur?.next
        }
        cur?.next = l1 == nil ? l2 : l1
        return res.next
    }
    
    /// 26.删除排序数组中的重复项
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        
        guard nums.count > 0 else {
            return 0
        }
        var cou = 0
        for i in 1..<nums.count {
            
            if nums[i] != nums[cou] {
                cou += 1
                nums[cou] = nums[i]
            }
        }
        nums.removeSubrange(cou+1..<nums.count)
        return nums.count
    }
    
    
    /// 27.移除元素
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        
        if nums.count == 0 { return 0 }
        var countArr = [Int]()
        for (i, value) in nums.enumerated() {
            if value == val {
                countArr.append(i)
            }
        }
        for index in countArr.reversed() {
            nums.remove(at: index)
        }
        return nums.count
    }
    
    func removeElement2(_ nums: inout [Int], _ val: Int) -> Int {
        
        var i = 0
        for j in 0..<nums.count {
            if nums[j] != val {
                nums[i] = nums[j]
                i += 1
            }
        }
        nums.removeSubrange(i..<nums.count)
        return i
    }
    
    /// 28.实现strStr()    4484ms解答 for me =。=
    func strStrForMe(_ haystack: String, _ needle: String) -> Int {
        let num = needle.count
        if num == 0 {
            return 0
        }
        for i in 0..<haystack.count {
            if (i + num <= haystack.count) && (haystack.subString(start: i, length: num) == needle) {
                return i
            }
        }
        return -1
    }
    
    /// 16ms解答
    func strStr(_ haystack: String, _ needle: String) -> Int {
        let count1 = haystack.count
        let count2 = needle.count
        if count2 == 0 {
            return 0
        }
        
        if count1 < count2 {
            return -1
        }
        
        var haystackChars = haystack.cString(using: .utf8)!
        var needleChars = needle.cString(using: .utf8)!
        var i = 0
        var j = 0
        
        let maxi = count1 - count2
        let maxj = count2 - 1
        
        while i <= maxi && j <= maxj {
            var m = i
            while m <= count1 - 1 && j <= maxj {
                let mv = haystackChars[m]
                let jv = needleChars[j]
                if mv == jv {
                    m += 1
                    j += 1
                    continue
                }
                j = 0
                i += 1
                break
            }
        }
        j = j - 1
        if j == maxj{
            return i
        }
        
        return -1
    }
    
    /// 35.搜索插入位置
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        if target == 0 { return 0 }
        var i = 0
        for num in nums{
            if num == target {
                break
            }else if num > target{
                break
            }else{
                i += 1
            }
        }
        return i
    }
    
    /// 53.最大子序和
    func maxSubArray(_ nums: [Int]) -> Int {
        
        var max = Int.min, sum = 0
        for i in 0..<nums.count {
            
            if sum < 0 {
                sum = nums[i]
            }else{
                sum += nums[i]
            }
            if max < sum {
                max = sum
            }
        }
        return max
    }
    
    func maxSubArray2(_ nums: [Int]) -> Int {
        var cou = [Int].init(repeating: 0, count: nums.count)
        var sum = nums[0]
        cou[0] = nums[0]
        for i in 1..<nums.count {
            cou[i] = max(cou[i-1] + nums[i], nums[i])
            sum = max(sum, cou[i])
        }
        return sum
    }
    
    /// 58.最后一个单词的长度
    func lengthOfLastWord(_ s: String) -> Int {
        
        var len = 0
        for str in s.reversed() {
            if str != " "{
                len += 1
            }
            if str == " " && len != 0 {
                break
            }
        }
        return len
    }

    /// 66.加一
    func plusOne(_ digits: [Int]) -> [Int] {
        if digits.count == 0 { return [1] }
        var plus = digits
        let len = digits.count - 1
        
        if digits[len] != 9 {
            plus[len] = digits[len] + 1
            return plus
        }else{
            plus.removeLast()
            plus = plusOne(plus)
            plus.append(0)
            return plus
        }
    }
    
    func plusOne2(_ digits: [Int]) -> [Int] {
        var nums = digits
        let last = nums[nums.count - 1]
        if last != 9 {
            nums[nums.count - 1] = last + 1
            return nums
        }
        
        var index = nums.count - 1
        while index >= 0 {
            if nums[index] == 9 {
                nums[index] = 0
            } else {
                nums[index] = nums[index] + 1
                return nums
            }
            index -= 1
        }
        nums.insert(1, at: 0)
        return nums
    }
    
    /// 二进制求和
    func addBinary(_ a: String, _ b: String) -> String {
        var arr1 = [Int]()
        for c in a {
            arr1.append(Int(String.init(c))!)
        }
        var arr2 = [Int]()
        for c in b.unicodeScalars {
            arr2.append(Int(String.init(c))!)
        }
        if arr1.count > arr2.count {
            return addBinaryWithArr(arr1, short: arr2)
        }
        return addBinaryWithArr(arr2, short: arr1)
    }
    
    func addBinaryWithArr(_ long:[Int], short:[Int]) -> String {
        
        func toString(_ array:[Int]) -> String {
            var str = ""
            for num in array {
                str += "\(num)"
            }
            return str
        }
        
        var long = long
        var target = 0
        let initIndex = long.count - short.count
        var i = short.count-1
        while i >= 0 {
            let temp = long[initIndex + i] + short[i] + target
            if temp > 1 {
                /// 有进位
                long[initIndex + i] = temp - 2
                target = 1
            }else{
                /// 无进位
                long[initIndex + i] = temp
                target = 0
            }
            i -= 1
        }
        
        if target == 0 {
            return toString(long)
        }
        
        var j = initIndex - 1
        while j >= 0 {
            if long[j] == 0 {
                long[j] = 1
                return toString(long)
            }
            long[j] -= 1
            j -= 1
        }
        return "1" + toString(long)
    }

    /// 69.x的平方根  直接调用系统方法=。=
    func mySqrt(_ x: Int) -> Int {
        var num = Double(x)
        num = sqrt(num)
        return Int(num)
    }
    
    func mySqrt2(_ x: Int) -> Int {
        var left = 0
        var right = x / 2 + 1
        while left <= right {
            let mid = (left + right) / 2
            let val = mid * mid
            if val == x {
                return mid
            } else if val < x {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return right
    }
    
    /// 70.爬楼梯  递归  超级慢速不能过的解答
    func climbStairsTooSlow(_ n: Int) -> Int {
        if n == 1 || n <= 0{
            return 1
        }else if n == 2 {
            return 2
        }else{
            return climbStairs(n-1) + climbStairs(n)
        }
    }
    
    func climbStairs(_ n: Int) -> Int {
        /// 0竟然要输出1？？？ 特意写这个判断
        if n == 1 || n <= 0{
            return 1
        }else if n == 2 {
            return 2
        }else{
            var f1 = 1
            var f2 = 2
            var f3 = 0
            for _ in 2..<n {
                f3 = f1 + f2
                f1 = f2
                f2 = f3
            }
            return f3
        }
    }
    
    func climbStairs2(_ n: Int) -> Int {
        var f1 = 1, f2 = 2, sum = n
        if n <= f2 { return sum }
        for _ in 3...n {
            sum = f1 + f2
            f1 = f2
            f2 = sum
        }
        return sum
    }
    
    /// 83.删除排序链表中的重复元素
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        var last = head
        var current = head?.next
        while current != nil {
            if current?.val == last?.val {
                current = current?.next
            }else {
                /// 改变了head.next
                last?.next = current
                /// 只改变了last
                last = current
                current = current?.next
            }
        }
        /// 改变了head.next
        last?.next = nil
        return head
    }
    
    /// 88.合并两个有序数组
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        
        for i in m..<m+n {
            nums1[i] = nums2[i-m]
        }
        nums1 = nums1.sorted()
    }
    /**
     * 思路：从尾部开始合并，避免覆盖
     * 时间复杂度：O(n)，空间复杂度：O(1)
     */
    func merge2(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        
        var i = m - 1, j = n - 1
        while i >= 0 || j >= 0 {
            if j < 0 || (i >= 0 && nums1[i] > nums2[j]) {
                nums1[i + j + 1] = nums1[i]
                i -= 1
            } else {
                nums1[i + j + 1] = nums2[j]
                j -= 1
            }
        }
    }
    
    /// 100.相同的树
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p?.val != q?.val {
            return false
        }
        if p?.left == nil && q?.left == nil && p?.right == nil && q?.right == nil {
            return true
        }else{
            return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
        }
    }
    
    /// 101.对称二叉树
    func isSymmetric(_ root: TreeNode?) -> Bool {
        if root == nil || (root?.left == nil && root?.right == nil) {
            return true
        }
        return isSymmetric(root?.left, root?.right)
    }
    
    func isSymmetric(_ left: TreeNode?, _ right: TreeNode?) -> Bool {
        if left == nil && right == nil {
            return true
        }
        if left == nil || right == nil || left?.val != right?.val {
            return false
        }
        return isSymmetric(left?.left, right?.right) && isSymmetric(left?.right, right?.left)
    }
    
    /// 104.二叉树的最大深度
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        return max(maxDepth(root.left), maxDepth(root.right)) + 1
    }
    
    /// 107.二叉树的层次遍历 II
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        
        var list = [[Int]]()
        guard let root = root else { return list }
        var queue = [TreeNode]()
        queue.append(root)
        while true {
            var temp = [TreeNode]()
            var tempList = [Int]()
            while !queue.isEmpty {
                let t = queue.removeFirst()
                tempList.append(t.val)
                if let l = t.left {
                    temp.append(l)
                }
                if let r = t.right {
                    temp.append(r)
                }
            }
            list.insert(tempList, at: 0)
            if temp.isEmpty { break }
            queue = temp
        }
        return list
    }
    
    /// 108.将有序数组转换为二叉搜索树
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        if nums.count == 0 { return nil }
        let mid = nums.count/2
        let root = TreeNode.init(nums[mid])
        let leftArr = [Int](nums[0..<mid])
        let rightArr = [Int].init(nums[mid+1..<nums.count])
        root.left = sortedArrayToBST(leftArr)
        root.right = sortedArrayToBST(rightArr)
        return root
    }
    
    /// 110.平衡二叉树 高度差啊！！
    func isBalanced(_ root: TreeNode?) -> Bool {
        
        func getDepth(_ root: TreeNode?) -> Int {
            guard let root = root else {
                return 0
            }
            return max(getDepth(root.left), getDepth(root.right)) + 1
        }
        
        guard let root = root else {
            return true
        }
        /// 大方向 |left-right| > 1 则不合格
        if abs(getDepth(root.left) - getDepth(root.right)) > 1 {
            return false
        }
        /// 下一步 每个节点判断是否合格
        return isBalanced(root.left) && isBalanced(root.right)
    }
    
    /// 111.二叉树的最小深度
    func minDepth(_ root: TreeNode?) -> Int {
     
        guard let root = root else {
            return 0
        }
        if root.left == nil {
            return minDepth(root.right) + 1
        }
        if root.right == nil {
            return minDepth(root.left) + 1
        }
        return min(minDepth(root.left), minDepth(root.right)) + 1
    }
    /// 112.路径总和
    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
        
        guard let root = root else {
            return false
        }
        let flag = sum - root.val
        if root.left == nil && root.right == nil {
            return flag == 0 ? true : false
        }
        return hasPathSum(root.left, flag) || hasPathSum(root.right, flag)
    }
    
    /// 118.杨辉三角
    func generate(_ numRows: Int) -> [[Int]] {
        var out = [[Int]]()
        if numRows == 0 {
            return out
        }
        for i in 0..<numRows {
            
            var arr = [Int].init(repeating: 1, count: i + 1)
            if i > 1 {
                for index in 1..<i {
                    arr[index] = out[i-1][index-1] + out[i-1][index]
                }
            }
            out.append(arr)
        }
        return out
    }
    
    /// 119.杨辉三角 II
    func getRow(_ rowIndex: Int) -> [Int] {
        if rowIndex == 0 { return [1] }
        var r = [Int](repeating: 0,count:rowIndex+1)
        r[0] = 1
        for i in 1...rowIndex {
            var j = i
            while j>=1 {
                r[j] += r[j-1]
                j -= 1
            }
        }
        return r
    }
    
    /// 121.买卖股票的最佳时机
    func maxProfit(_ prices: [Int]) -> Int {
        
        var money = 0
        for i in 0..<prices.count {
            for j in i+1..<prices.count {
                let sub = prices[i] - prices[j]
                if sub < money{
                    money = sub
                }
            }
        }
        return -money
    }
    
    func maxProfitBest(_ prices: [Int]) -> Int {
        if prices.count == 0 {
            return 0
        }
        
        var profit = 0
        var buyPrice = prices[0]
        
        for i in 0..<prices.count {
            let soldPrice = prices[i]
            profit = max(profit, soldPrice - buyPrice)
            buyPrice = min(buyPrice, soldPrice)
        }
        return profit
    }
    
    /// 122.买卖股票的最佳时机 II
    func maxProfitOften(_ prices: [Int]) -> Int {
        
        if prices.count == 0 {
            return 0
        }
        var money = 0
        var buyPrice = prices[0]
        for i in 1..<prices.count {
            let soldPrice = prices[i]
            if soldPrice > buyPrice {
                money += soldPrice - buyPrice
            }
            buyPrice = soldPrice
        }
        return money
    }
    
    func maxProfitOftenBest(_ prices: [Int]) -> Int {
        var money = 0
        guard prices.count > 1 else {
            return money
        }
        for i in 1..<prices.count where prices[i] > prices[i-1] {
            money += prices[i] - prices[i - 1]
        }
        return money
    }
    
    /// 125.验证回文串
    func isPalindrome(_ s: String) -> Bool {
        
        var res = s.lowercased()
        var res1 = ""
        for cha in res.unicodeScalars {
            if cha.value >= 48 && cha.value <= 57 || cha.value >= 97 && cha.value <= 122{
            
                res1 += String.init(cha)
            }
        }
        res = String.init(res1.reversed())
        return res == res1
    }
    
    /// 136.只出现一次的数字
    func singleNumber(_ nums: [Int]) -> Int {
        var only = Dictionary<Int,Int>()
        for num in nums {
            if let _ = only[num] {
                only.removeValue(forKey: num)
            }else{
                only[num] = num
            }
        }
        return only.first!.value
    }
    
    
    /*
     我们先了解一下位异或的运算法则吧：
     
     1、a^b = b^a。
     
     2、(a^b)^c = a^(b^c)。
     
     3、a^b^a = b。
     
     对于一个任意一个数n，它有几个特殊的性质：
     
     1、0^n = n。
     
     2、n^n = 0。
     
     3、1^n = !n。（即n==0时，则所得的值为真，当 n != 0，所得值为0，即为假）

     */
    func singleNumberBest(_ nums: [Int]) -> Int {
        var result = 0
        for i in nums {
            result = result ^ i
        }
        return result
    }
    
    /// 167.两数之和 II - 输入有序数组
    func twoSum167(_ numbers: [Int], _ target: Int) -> [Int] {
        var result = [Int]()
        if numbers.count == 0 { return result }
        for i in 0..<numbers.count {
            var sub = target - numbers[i]
            for j in i+1..<numbers.count {
                if numbers[j] == sub {
                    result = [i+1, j+1]
                }
            }
        }
        return result
    }
    
    /// 169.求众数
    func majorityElement(_ nums: [Int]) -> Int {
        
        var result = 0
        var dic = [Int:Int]()
        for num in nums {
            if let count = dic[num] {
                dic[num] = count + 1
            }else{
                dic[num] = 1
            }
            if dic[num]! > nums.count/2 {
                result = num
            }
        }
        return result
    }
    
    func majorityElementBest(_ nums: [Int]) -> Int {
        
        var curNum = nums[0]
        var majority = 0;
        for num in 0..<nums.count {
            let val = nums[num]
            if curNum != val {
                majority -= 1
                if majority < 1 {
                    curNum = val
                    majority = 1
                }
            } else {
                majority += 1
            }
        }
        return curNum;
    }
    
    ///暂歇一日
    
    /// 168.Excel表列名称 16ms 击败83.3%
    func convertToTitle(_ n: Int) -> String {
        
        var n = n
        var r = ""
        while n != 0 {
            let c:Int = (n-1) % 26
            let t = UnicodeScalar.init(c+65)
            r = r + String.init(t!)
            n = (n-1)/26
        }
        return String.init(r.reversed())
    }
    
    /// 169.Excel表列序号 16ms Swift提交中击败了100.00% 的用户
    func titleToNumber(_ s: String) -> Int {
        
        var s = s
        var result = 0
        for i in 0..<s.count {
            
            let last = s.removeLast()
            let a = (last.unicodeScalars.first?.value)! - 64
            let r = pow(26, Double(i)) * Double(a)
            result += Int(r)
        }
        return result
    }
    
    /// 172.阶乘后的零
    func trailingZeroes(_ n: Int) -> Int {
        
        var n = n
        var count:Int = 0
        while n != 0{
            n /= 5
            count += n
        }
        return count
    }
    
    
    
    
    /* 这是底线 */
}

extension String {
    //根据开始位置和长度截取字符串
    func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
}
