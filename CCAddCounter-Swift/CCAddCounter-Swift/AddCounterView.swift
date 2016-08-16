//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ August 16th, 2016
//

import UIKit
import Cartography

class AddCounterView: UIView {
    
    // 加数文本框
    var numberA = UITextField()
    // 加号标签
    private var plusSign = UILabel()
    // 被加数文本框
    var numberB = UITextField()
    // 等号标签
    private var equalSign = UILabel()
    // 加法和标签
    var sumAnswer = UILabel()
    // 加法按钮
    var addButton = UIButton()
    
    // MARK: - 初始化方法
    
    /**
     自定义初始化方法
     */
    override init(frame: CGRect) {
    
        super.init(frame: frame)
        
        setupUI()
    }
    
    /**
     XIB初始化方法
     */
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 界面方法
    
    /**
     初始化界面方法
     */
    private func setupUI() {
        
        numberA.placeholder = "数字A"
        numberA.borderStyle = UITextBorderStyle.RoundedRect
        numberA.adjustsFontSizeToFitWidth = true
        addSubview(numberA)
        
        plusSign.text = "+"
        addSubview(plusSign)
        
        numberB.placeholder = "数字B"
        numberB.borderStyle = UITextBorderStyle.RoundedRect
        numberB.adjustsFontSizeToFitWidth = true
        addSubview(numberB)
        
        equalSign.text = "="
        addSubview(equalSign)
        
        sumAnswer.text = "0"
        sumAnswer.textAlignment = NSTextAlignment.Center
        addSubview(sumAnswer)
        
        addButton.setTitle("计算", forState: UIControlState.Normal)
        addButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        addSubview(addButton)
        
        constrain(numberA, plusSign, numberB) { (numberA, plusSign, numberB) in
            numberA.width == 60
            numberA.height == 30
            numberA.top == numberA.superview!.top + 100
            numberA.left == numberA.superview!.left + 20
            
            plusSign.width == 20
            plusSign.height == 20
            
            numberB.width == 60
            numberB.height == 30
            
            align(centerY: numberA, plusSign, numberB)
            distribute(by: 20, leftToRight: numberA, plusSign, numberB)
        }
        
        constrain(sumAnswer, equalSign) { (sumAnswer, equalSign) in
            sumAnswer.width == 50
            sumAnswer.height == 30
            sumAnswer.top == sumAnswer.superview!.top + 100
            sumAnswer.right == sumAnswer.superview!.right - 20
            
            equalSign.width == 20
            equalSign.height == 20
            
            align(centerY: sumAnswer, equalSign)
            distribute(by: 20, leftToRight: equalSign, sumAnswer)
        }
        
        constrain(addButton) { (addButton) in
            addButton.width == 100
            addButton.height == 50
            addButton.center == addButton.superview!.center
        }
    }

}
