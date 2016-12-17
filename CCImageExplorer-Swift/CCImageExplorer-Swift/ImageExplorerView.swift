//
//  ImageExplorerView.swift
//		CCImageExplorer
//		Chen Chen @ November 13th, 2016
//

import UIKit

import Cartography

class ImageExplorerView: UIView {

    /// 图片视图
    var imageView = UIImageView()
    /// 计数器标签
    var numberLabel = UILabel()
    /// 标题标签
    var titleLabel = UILabel()
    /// 正文标签
    var textLabel = UILabel()
    /// 前一个按钮
    var previousButton = UIButton(type: .custom)
    /// 后一个按钮
    var nextButton = UIButton(type: .custom)
    
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
        
        addSubview(numberLabel)
        addSubview(titleLabel)
        addSubview(imageView)
        
        textLabel.numberOfLines = 0
        textLabel.font = .systemFont(ofSize: 12)
        addSubview(textLabel)
        
        previousButton.setBackgroundImage(UIImage(named: "left_normal"), for: .normal)
        previousButton.setBackgroundImage(UIImage(named: "left_highlighted"), for: .highlighted)
        previousButton.setBackgroundImage(UIImage(named: "left_disable"), for: .disabled)
        addSubview(previousButton)
        
        nextButton.setBackgroundImage(UIImage(named: "right_normal"), for: .normal)
        nextButton.setBackgroundImage(UIImage(named: "right_highlighted"), for: .highlighted)
        nextButton.setBackgroundImage(UIImage(named: "right_disable"), for: .disabled)
        addSubview(nextButton)
    }

    /**
     初始化约束方法
     */
    private func setupConstraints() {
        
        constrain(numberLabel, titleLabel) { numberLabel, titleLabel in
            numberLabel.centerX == numberLabel.superview!.centerX
            numberLabel.top == numberLabel.superview!.top + kViewBorder
            
            titleLabel.centerX == titleLabel.superview!.centerX
            titleLabel.top == numberLabel.bottom + kViewBorder
        }
        
        constrain(imageView, textLabel) { imageView, textLabel in
            imageView.width == 200
            imageView.height == 350
            imageView.centerX == imageView.superview!.centerX
            imageView.centerY == imageView.superview!.centerY
            
            textLabel.top == imageView.bottom + kViewBorder
            textLabel.left == textLabel.superview!.left + kViewBorder
            textLabel.bottom == textLabel.superview!.bottom - kViewBorder
            textLabel.right == textLabel.superview!.right - kViewBorder
        }
        
        constrain(previousButton, nextButton) { previousButton, nextButton in
            previousButton.width == kViewAdapter
            previousButton.height == kViewAdapter
            previousButton.centerY == previousButton.superview!.centerY
            previousButton.left == previousButton.superview!.left + kViewBorder
            
            nextButton.width == kViewAdapter
            nextButton.height == kViewAdapter
            nextButton.centerY == nextButton.superview!.centerY
            nextButton.right == nextButton.superview!.right - kViewBorder
        }
    }
    
}
