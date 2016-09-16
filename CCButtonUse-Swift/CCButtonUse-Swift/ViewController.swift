//
//	ViewController.swift
//		CCButtonUse
//		Chen Chen @ August 16th, 2016
//

import UIKit

class ViewController: UIViewController {

    /// 加法计算视图
    var buttonUseView = ButtonUseView(frame: kScreenFrame)
    
    // MARK: - 系统方法
    
    /**
     视图已经加载方法
     */
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view = buttonUseView
    }
}

