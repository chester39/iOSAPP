//
//  AppCell.swift
//		CCAppControl
//		Chen Chen @ December 18th, 2016
//

import UIKit

import Cartography

@objc protocol AppCellDelegate: NSObjectProtocol {
    
    /**
     下载按钮点击方法
     */
    @objc optional func appCellDidClickDownloadButton(cell: AppCell)
    
}

class AppCell: UICollectionViewCell {
    
    /// 图标图片视图
    private var iconImageView = UIImageView()
    /// 名称标签
    private var nameLabel = UILabel(text: "", fontSize: 13, lines: 1)
    /// 下载按钮
    private var downloadButton = UIButton(imageName: nil, backgroundImageName: "buttongreen")
    /// AppCellDelegate代理
    weak var delegate: AppCellDelegate?
    
    /// 应用模型
    var appModel: AppModel? {
        didSet {
            if appModel != nil {
                iconImageView.image = UIImage(named: appModel!.icon ?? "")
                nameLabel.text = appModel!.name
            }
        }
    }
    
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
        
        addSubview(iconImageView)
        
        nameLabel.textAlignment = .center
        addSubview(nameLabel)
        
        downloadButton.setTitle("下载", for: .normal)
        downloadButton.titleLabel?.font = .systemFont(ofSize: 13)
        downloadButton.addTarget(self, action: #selector(downloadButtonDidClick(button:)), for: .touchUpInside)
        addSubview(downloadButton)
    }
    
    /**
     初始化约束方法
     */
    private func setupConstraints() {
        
        constrain(iconImageView, nameLabel, downloadButton) { iconImageView, nameLabel, downloadButton in
            iconImageView.width == 50
            iconImageView.height == 50
            iconImageView.top == iconImageView.superview!.top
            
            nameLabel.top == iconImageView.bottom
            
            downloadButton.width == kViewAdapter
            downloadButton.height == kViewBorder
            downloadButton.top == nameLabel.bottom
            
            align(centerX: iconImageView, nameLabel, downloadButton, iconImageView.superview!)
        }
    }
    
    // MARK: - 按钮方法
    
    /**
     下载按钮点击方法
     */
    @objc private func downloadButtonDidClick(button: UIButton) {
        
        button.setTitle("已下载", for: .normal)
        button.isEnabled = false
        if let tempDelegate = delegate {
            if tempDelegate.responds(to: #selector(AppCellDelegate.appCellDidClickDownloadButton(cell:))) {
                tempDelegate.appCellDidClickDownloadButton!(cell: self)
            }
        }
    }
    
}
