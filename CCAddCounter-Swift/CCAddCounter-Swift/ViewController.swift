//
//	ViewController.swift
//		CCAddCounter
//		Chen Chen @ August 15th, 2016
//

import UIKit

class ViewController: UIViewController {

    /// 加法计算视图
    var addCounterView = AddCounterView(frame: kScreenFrame)

    // MARK: - 系统方法

    /**
     视图已经加载方法
     */
    override func viewDidLoad() {

        super.viewDidLoad()

        view = addCounterView
        addCounterView.addButton.addTarget(self, action: #selector(addCounter), for: .touchUpInside)
    }

    // MARK: - 界面方法

    /**
     加法计算方法
     */
    @objc fileprivate func addCounter() {

        let a: Int = Int(addCounterView.numberA.text!) ?? 0
        let b: Int = Int(addCounterView.numberB.text!) ?? 0
        addCounterView.sumAnswer.text = String(a + b)

        view.endEditing(true)
    }

}
