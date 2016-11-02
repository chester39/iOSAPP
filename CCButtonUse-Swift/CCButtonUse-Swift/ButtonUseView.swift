//
//  ButtonUseView.swift
//		CCButtonUse
//		Chen Chen @ November 2nd, 2016
//

import UIKit

import Cartography

class ButtonUseView: UIView {

    /// 图片按钮
    var imageButton = UIButton(type: .custom)
    /// 上移按钮
    var topButton = UIButton(type: .custom)
    /// 下移按钮
    var bottomButton = UIButton(type: .custom)
    /// 左移按钮
    var leftButton = UIButton(type: .custom)
    /// 右移按钮
    var rightButton = UIButton(type: .custom)
    /// 左转按钮
    var leftRotateButton = UIButton(type: .custom)
    /// 右转按钮
    var rightRotateButton = UIButton(type: .custom)
    /// 放大按钮
    var plusButton = UIButton(type: .custom)
    /// 缩小按钮
    var minusButton = UIButton(type: .custom)
    
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
    fileprivate func setupUI() {
        
        imageButton.setBackgroundImage(UIImage(named: "Image_front"), for: .normal)
        imageButton.setBackgroundImage(UIImage(named: "Image_back"), for: .highlighted)
        imageButton.setTitle("Touch Me!", for: .normal)
        imageButton.setTitle("OK, You Touch!", for: .highlighted)
        imageButton.setTitleColor(.red, for: .normal)
        imageButton.setTitleColor(.blue, for: .highlighted)
        addSubview(imageButton)
        
        topButton.setBackgroundImage(UIImage(named: "top_normal"), for: .normal)
        topButton.setBackgroundImage(UIImage(named: "top_highlighted"), for: .highlighted)
        topButton.setBackgroundImage(UIImage(named: "top_disable"), for: .disabled)
        topButton.tag = kButtonType.top.rawValue
        addSubview(topButton)
        
        bottomButton.setBackgroundImage(UIImage(named: "bottom_normal"), for: .normal)
        bottomButton.setBackgroundImage(UIImage(named: "bottom_highlighted"), for: .highlighted)
        bottomButton.setBackgroundImage(UIImage(named: "bottom_disable"), for: .disabled)
        bottomButton.tag = kButtonType.bottom.rawValue
        addSubview(bottomButton)
        
        leftButton.setBackgroundImage(UIImage(named: "left_normal"), for: .normal)
        leftButton.setBackgroundImage(UIImage(named: "left_highlighted"), for: .highlighted)
        leftButton.setBackgroundImage(UIImage(named: "tleft_disable"), for: .disabled)
        leftButton.tag = kButtonType.left.rawValue
        addSubview(leftButton)
        
        rightButton.setBackgroundImage(UIImage(named: "right_normal"), for: .normal)
        rightButton.setBackgroundImage(UIImage(named: "right_highlighted"), for: .highlighted)
        rightButton.setBackgroundImage(UIImage(named: "right_disable"), for: .disabled)
        rightButton.tag = kButtonType.right.rawValue
        addSubview(rightButton)
        
        leftRotateButton.setBackgroundImage(UIImage(named: "left_rotate_normal"), for: .normal)
        leftRotateButton.setBackgroundImage(UIImage(named: "left_rotate_highlighted"), for: .highlighted)
        leftRotateButton.tag = kButtonType.leftRotate.rawValue
        addSubview(leftRotateButton)
        
        rightRotateButton.setBackgroundImage(UIImage(named: "right_rotate_normal"), for: .normal)
        rightRotateButton.setBackgroundImage(UIImage(named: "right_rotate_highlighted"), for: .highlighted)
        rightRotateButton.tag = kButtonType.rightRotate.rawValue
        addSubview(rightRotateButton)
        
        plusButton.setBackgroundImage(UIImage(named: "plus_normal"), for: .normal)
        plusButton.setBackgroundImage(UIImage(named: "plus_highlighted"), for: .highlighted)
        plusButton.tag = kButtonType.plus.rawValue
        addSubview(plusButton)
        
        minusButton.setBackgroundImage(UIImage(named: "minus_normal"), for: .normal)
        minusButton.setBackgroundImage(UIImage(named: "minus_highlighted"), for: .highlighted)
        minusButton.tag = kButtonType.minus.rawValue
        addSubview(minusButton)
    }
    
    /**
     初始化约束方法
     */
    fileprivate func setupConstraints() {
        
        let buttonWidth: CGFloat = 300
        let buttonHeight: CGFloat = 200
        let buttonX: CGFloat = (kScreenWidth - buttonWidth) / 2
        let buttonY: CGFloat = kViewAdapter
        imageButton.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        
        constrain(topButton, bottomButton, leftButton, rightButton) { (topButton, bottomButton, leftButton, rightButton) in
            topButton.width == kViewAdapter
            topButton.height == kViewAdapter
            topButton.top == topButton.superview!.top + 300
            topButton.left == leftButton.right
            
            bottomButton.width == topButton.width
            bottomButton.height == topButton.height
            bottomButton.centerX == topButton.centerX
            bottomButton.top == leftButton.bottom
            
            leftButton.width == bottomButton.width
            leftButton.height == bottomButton.height
            leftButton.left == leftButton.superview!.left + kViewBorder
            leftButton.top == topButton.bottom
            
            rightButton.width == leftButton.width
            rightButton.height == leftButton.height
            rightButton.centerY == leftButton.centerY
            rightButton.left == topButton.right
        }
        
        constrain(leftRotateButton, rightRotateButton) { (leftRotateButton, rightRotateButton) in
            leftRotateButton.width == kViewAdapter
            leftRotateButton.height == kViewAdapter
            leftRotateButton.top == leftRotateButton.superview!.top + 300
            leftRotateButton.left == leftRotateButton.superview!.right - kViewDistance
            
            rightRotateButton.width == leftRotateButton.width
            rightRotateButton.height == leftRotateButton.height
            rightRotateButton.centerY == leftRotateButton.centerY
            rightRotateButton.left == leftRotateButton.right + kViewBorder
        }
        
        constrain(plusButton, minusButton) { (plusButton, minusButton) in
            plusButton.width == kViewAdapter
            plusButton.height == kViewAdapter
            plusButton.top == plusButton.superview!.top + 400
            plusButton.left == plusButton.superview!.right - kViewDistance
            
            minusButton.width == plusButton.width
            minusButton.height == plusButton.height
            minusButton.centerY == plusButton.centerY
            minusButton.left == plusButton.right + kViewBorder
        }
    }

}
