//
//	ButtonUseView.swift
//		CCButtonUse
//		Chen Chen @ August 16th, 2016
//

import UIKit

import Cartography

class ButtonUseView: UIView {
    
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
        
        
    }
    
    /**
     初始化约束方法
     */
    private func setupConstraints() {
        
    }

}
