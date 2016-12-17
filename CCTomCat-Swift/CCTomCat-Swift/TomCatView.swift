//
//  TomCatView.swift
//		CCTomCat
//		Chen Chen @ December 17th, 2016
//

import UIKit

import Cartography

class TomCatView: UIView {

    /// 汤姆图片视图
    private var tomCatImageView = UIImageView()
    /// 吃饭按钮
    var eatButton = UIButton(type: .custom)
    /// 铜钹按钮
    var cymbalButton = UIButton(type: .custom)
    /// 喝水按钮
    var drinkButton = UIButton(type: .custom)
    /// 放屁按钮
    var fartButton = UIButton(type: .custom)
    /// 扔饼按钮
    var pieButton = UIButton(type: .custom)
    /// 抓屏按钮
    var scratchButton = UIButton(type: .custom)
    /// 打头按钮
    var headButton = UIButton(type: .custom)
    /// 生气按钮
    var angryButton = UIButton(type: .custom)
    /// 打胃按钮
    var stomachButton = UIButton(type: .custom)
    /// 左脚按钮
    var leftFootButton = UIButton(type: .custom)
    /// 右脚按钮
    var rightFootButton = UIButton(type: .custom)
    
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

        tomCatImageView.image = UIImage(named: "angry_00.jpg")
        addSubview(tomCatImageView)
        
        eatButton.setBackgroundImage(UIImage(named: "eat"), for: .normal)
        addSubview(eatButton)
        
        cymbalButton.setBackgroundImage(UIImage(named: "cymbal"), for: .normal)
        addSubview(cymbalButton)
        
        drinkButton.setBackgroundImage(UIImage(named: "drink"), for: .normal)
        addSubview(drinkButton)
        
        fartButton.setBackgroundImage(UIImage(named: "fart"), for: .normal)
        addSubview(fartButton)
        
        pieButton.setBackgroundImage(UIImage(named: "pie"), for: .normal)
        addSubview(pieButton)
        
        scratchButton.setBackgroundImage(UIImage(named: "scratch"), for: .normal)
        addSubview(scratchButton)
        
        addSubview(headButton)
        addSubview(angryButton)
        addSubview(stomachButton)
        addSubview(leftFootButton)
        addSubview(rightFootButton)
    }
    
    /**
     初始化约束方法
     */
    private func setupConstraints() {
        
        constrain(tomCatImageView) { tomCatImageView in
            tomCatImageView.edges == inset(tomCatImageView.superview!.edges, 0)
        }
        
        constrain(eatButton, cymbalButton, drinkButton) { eatButton, cymbalButton, drinkButton in
            eatButton.width == 50
            eatButton.height == 50
            eatButton.bottom == cymbalButton.top - kViewMargin
            eatButton.left == eatButton.superview!.left + kViewPadding
            
            cymbalButton.width == eatButton.width
            cymbalButton.height == eatButton.height
            cymbalButton.bottom == drinkButton.top - kViewMargin
            
            drinkButton.width == eatButton.width
            drinkButton.height == eatButton.height
            drinkButton.top == drinkButton.superview!.bottom - kViewAdapter
            
            align(left: eatButton, cymbalButton, drinkButton)
        }
        
        constrain(fartButton, pieButton, scratchButton) { fartButton, pieButton, scratchButton in
            fartButton.width == 50
            fartButton.height == 50
            fartButton.bottom == pieButton.top - kViewMargin
            fartButton.right == fartButton.superview!.right - kViewPadding
            
            pieButton.width == fartButton.width
            pieButton.height == fartButton.height
            pieButton.bottom == scratchButton.top - kViewMargin
            
            scratchButton.width == fartButton.width
            scratchButton.height == fartButton.height
            scratchButton.top == scratchButton.superview!.bottom - kViewAdapter
            
            align(right: fartButton, pieButton, scratchButton)
        }
        
        constrain([headButton, angryButton, stomachButton, leftFootButton, rightFootButton]) { buttons in
            buttons[0].width == 250
            buttons[0].height == 250
            buttons[0].top == buttons[0].superview!.top + 75
            
            buttons[1].width == kViewStandard
            buttons[1].height == kViewAdapter
            buttons[1].top == buttons[0].bottom + kViewPadding

            buttons[2].width == 120
            buttons[2].height == kViewDistance
            buttons[2].top == buttons[1].bottom + kViewPadding
            
            buttons[3].width == kViewAdapter
            buttons[3].height == kViewAdapter
            buttons[3].bottom == buttons[4].bottom
            buttons[3].left == buttons[4].right
            
            buttons[4].width == kViewAdapter
            buttons[4].height == kViewAdapter
            buttons[4].bottom == buttons[4].superview!.bottom - kViewPadding
            buttons[4].left == buttons[4].superview!.centerX - kViewAdapter
            
            
            align(centerX: buttons[0], buttons[1], buttons[2], buttons[0].superview!)
        }
    }
    
    // MARK: - 动作方法
    
    /**
     连续帧动画方法
     */
    func runAnimation(count: Int, name: String) {
        
        if tomCatImageView.isAnimating {
            return
        }
        
        var imageArray = [UIImage]()
        for i in 0...count {
            let fileName = String(format: "%@_%02d", name, i)
            let path = Bundle.main.path(forResource: fileName, ofType: "jpg")
            let image = UIImage(contentsOfFile: path!)
            imageArray.append(image!)
        }
        
        tomCatImageView.animationImages = imageArray
        tomCatImageView.animationRepeatCount = 1
        tomCatImageView.animationDuration = Double(imageArray.count) * 0.05
        tomCatImageView.startAnimating()
        
        let delay = DispatchTime.now() + tomCatImageView.animationDuration + 1.0
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.tomCatImageView.animationImages = nil
            self.tomCatImageView.stopAnimating()
        }
    }

}
