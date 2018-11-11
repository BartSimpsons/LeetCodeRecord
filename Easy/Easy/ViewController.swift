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
        single()
    }

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
    
    /// 121.
    func maxProfit(){
        
        Solution().maxProfit([7,1,5,3,6,4])
    }
    
    /// 136
    func single(){
        Solution().singleNumberBest([5,3,3,4,5])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

