//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ August 15th, 2016
//

import UIKit
import Cartography

class ViewController: UIViewController {

    // 加数文本框
    var numberA = UITextField()
    // 加号标签
    var plusSign = UILabel()
    // 被加数文本框
    var numberB = UITextField()
    // 等号标签
    var equalSign = UILabel()
    // 加法和标签
    var sumAnswer = UILabel()
    // 加法按钮
    var addButton = UIButton()
    
    // MARK: - 系统方法
    
    /**
     视图已经加载方法
     */
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - 初始化方法
    
    /**
     初始化界面方法
     */
    func setupUI() {
        
        numberA.placeholder = "数字A"
        numberA.textAlignment = NSTextAlignment.Center
        view.addSubview(numberA)
        
        plusSign.text = "+"
        view.addSubview(plusSign)
        
        numberB.placeholder = "数字B"
        numberB.textAlignment = NSTextAlignment.Center
        view.addSubview(numberB)
        
        equalSign.text = "="
        view.addSubview(equalSign)
        
        sumAnswer.text = "0"
        view.addSubview(sumAnswer)
        
        addButton.setTitle("计算", forState: UIControlState.Normal)
        addButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        addButton.addTarget(self, action: #selector(addCounter), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(addButton)
        
        constrain(numberA, plusSign) { (numberA, plusSign) in
            numberA.width == 50
            numberA.height == 20
            numberA.top == numberA.superview!.top + 100
            numberA.left == numberA.superview!.left + 20
            
            plusSign.width == 20
            plusSign.height == 20
            plusSign.centerY == numberA.centerY
            plusSign.left == numberA.right + 20
        }
        
        constrain(numberB, plusSign) { (numberB, plusSign) in
            numberB.width == 50
            numberB.height == 20
            numberB.top == numberB.superview!.top + 100
            numberB.left == plusSign.right + 20
            
        }
        
        constrain(sumAnswer, equalSign) { (sumAnswer, equalSign) in
            sumAnswer.width == 50
            sumAnswer.height == 20
            sumAnswer.top == sumAnswer.superview!.top + 100
            sumAnswer.right == sumAnswer.superview!.right - 20
            
            equalSign.width == 20
            equalSign.height == 20
            equalSign.centerY == sumAnswer.centerY
            equalSign.right == sumAnswer.left - 20
        }
        
        constrain(addButton) { (addButton) in
            addButton.width == 100
            addButton.height == 50
            addButton.center == addButton.superview!.center
        }
    }
    
    /**
     加法计算器
     */
    func addCounter() {
        let a: Int = Int(numberA.text!) ?? 0
        let b: Int = Int(numberB.text!) ?? 0
        sumAnswer.text = String(a + b)
        view.endEditing(true)
    }
    
}