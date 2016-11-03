//
//  ViewController.swift
//		CCButtonUse
//		Chen Chen @ November 2nd, 2016
//

import UIKit

/// 按钮功能枚举数组
enum kButtonType: Int {
    /// 上移按钮
    case top = 10
    /// 下移按钮
    case bottom
    /// 左移按钮
    case left
    /// 右移按钮
    case right
    /// 放大按钮
    case plus
    /// 缩小按钮
    case minus
    /// 左转按钮
    case leftRotate
    /// 右转按钮
    case rightRotate
}

class ViewController: UIViewController {

    /// 按钮使用视图
    var buttonUseView = ButtonUseView(frame: kScreenFrame)
    
    // MARK: - 系统方法
    
    /**
     视图已经加载方法
     */
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view = buttonUseView
        buttonUseView.topButton.addTarget(self, action: #selector(moveButtonDidClick(button:)), for: .touchUpInside)
        buttonUseView.bottomButton.addTarget(self, action: #selector(moveButtonDidClick(button:)), for: .touchUpInside)
        buttonUseView.leftButton.addTarget(self, action: #selector(moveButtonDidClick(button:)), for: .touchUpInside)
        buttonUseView.rightButton.addTarget(self, action: #selector(moveButtonDidClick(button:)), for: .touchUpInside)
        
        buttonUseView.leftRotateButton.addTarget(self, action: #selector(rotateButtonDidClick(button:)), for: .touchUpInside)
        buttonUseView.rightRotateButton.addTarget(self, action: #selector(rotateButtonDidClick(button:)), for: .touchUpInside)
        
        buttonUseView.plusButton.addTarget(self, action: #selector(scalingButtonDidClick(button:)), for: .touchUpInside)
        buttonUseView.minusButton.addTarget(self, action: #selector(scalingButtonDidClick(button:)), for: .touchUpInside)
    }
    
    // MARK: - 界面方法
    
    /**
     移动按钮点击方法
     */
    func moveButtonDidClick(button: UIButton) {
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.0)
        switch button.tag {
        case kButtonType.top.rawValue:
            buttonUseView.imageButton.frame.origin.y -= kViewPadding
        case kButtonType.bottom.rawValue:
            buttonUseView.imageButton.frame.origin.y += kViewPadding
        case kButtonType.left.rawValue:
            buttonUseView.imageButton.frame.origin.x -= kViewPadding
        case kButtonType.right.rawValue:
            buttonUseView.imageButton.frame.origin.x += kViewPadding
        default:
            break
        }
        
        UIView.commitAnimations()
    }
    
    /**
     旋转按钮点击方法
     */
    func rotateButtonDidClick(button: UIButton) {
        
        UIView.animate(withDuration: 2.0) {
            switch button.tag {
            case kButtonType.leftRotate.rawValue:
                self.buttonUseView.imageButton.transform = self.buttonUseView.imageButton.transform.rotated(by: (CGFloat)(-M_PI_4))
            case kButtonType.rightRotate.rawValue:
                self.buttonUseView.imageButton.transform = self.buttonUseView.imageButton.transform.rotated(by: CGFloat(M_PI_4))
            default:
                break
            }
        }
    }
    
    /**
     改变按钮点击方法
     */
    func scalingButtonDidClick(button: UIButton) {
        
        UIView.animate(withDuration: 1.0, animations: {
            switch button.tag {
            case kButtonType.plus.rawValue:
                self.buttonUseView.imageButton.transform = self.buttonUseView.imageButton.transform.scaledBy(x: 1.2, y: 1.2)
            case kButtonType.minus.rawValue:
                self.buttonUseView.imageButton.transform = self.buttonUseView.imageButton.transform.scaledBy(x: 0.8, y: 0.8)
            default:
                break
            }
        }) { (result) in
            print(result)
        }
    }
    
}
