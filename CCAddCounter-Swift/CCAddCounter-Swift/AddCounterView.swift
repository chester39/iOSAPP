//
//	AddCounterView.swift
//		CCAddCounter
//		Chen Chen @ August 16th, 2016
//

import UIKit

import Cartography

class AddCounterView: UIView {
    
    /// 加数文本框
    var numberA = UITextField()
    /// 加号标签
    private var plusSign = UILabel(text: "+", fontSize: 17, lines: 1)
    /// 被加数文本框
    var numberB = UITextField()
    /// 等号标签
    private var equalSign = UILabel(text: "=", fontSize: 17, lines: 1)
    /// 加法和标签
    var sumAnswer = UILabel(text: "0", fontSize: 17, lines: 0)
    /// 加法按钮
    var addButton = UIButton()
    
    // MARK: - 初始化方法
    
    /**
     自定义初始化方法
     */
    override init(frame: CGRect) {
    
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    /**
     数据解码XIB初始化方法
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
        numberA.borderStyle = .RoundedRect
        numberA.adjustsFontSizeToFitWidth = true
        addSubview(numberA)
        
        addSubview(plusSign)
        
        numberB.placeholder = "数字B"
        numberB.borderStyle = .RoundedRect
        numberB.adjustsFontSizeToFitWidth = true
        addSubview(numberB)
        
        addSubview(equalSign)
        
        sumAnswer.textAlignment = .Center
        addSubview(sumAnswer)
        
        addButton.setTitle("计算", forState: .Normal)
        addButton.setTitleColor(MainColor, forState: .Normal)
        addSubview(addButton)
    }
    
    /**
     初始化约束方法
     */
    private func setupConstraints() {
        
        constrain(numberA, plusSign, numberB) { (numberA, plusSign, numberB) in
            numberA.width == kViewAdapter
            numberA.height == kViewMargin
            numberA.top == numberA.superview!.top + kViewStandard
            numberA.left == numberA.superview!.left + kViewBorder
            
            plusSign.width == kViewBorder
            plusSign.height == kViewBorder
            
            numberB.width == kViewAdapter
            numberB.height == kViewMargin
            
            align(centerY: numberA, plusSign, numberB)
            distribute(by: kViewBorder, leftToRight: numberA, plusSign, numberB)
        }
        
        constrain(sumAnswer, equalSign) { (sumAnswer, equalSign) in
            sumAnswer.width == kViewAdapter
            sumAnswer.height == kViewMargin
            sumAnswer.top == sumAnswer.superview!.top + kViewStandard
            sumAnswer.right == sumAnswer.superview!.right - kViewBorder
            
            equalSign.width == kViewBorder
            equalSign.height == kViewBorder
            
            align(centerY: sumAnswer, equalSign)
            distribute(by: kViewBorder, leftToRight: equalSign, sumAnswer)
        }
        
        constrain(addButton) { (addButton) in
            addButton.width == kViewStandard
            addButton.height == kViewAdapter
            addButton.center == addButton.superview!.center
        }
    }

}
