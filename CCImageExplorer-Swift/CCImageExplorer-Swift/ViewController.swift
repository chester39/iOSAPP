//
//  ViewController.swift
//		CCImageExplorer
//		Chen Chen @ November 13th, 2016
//

import UIKit

import SwiftyJSON

class ViewController: UIViewController {

    /// 图片浏览视图
    private var imageExplorerView = ImageExplorerView(frame: kScreenFrame)
    /// 图片下标
    private var index: Int = 0
    /// 图片数组
    private var imageArray: [[String: Any]] = {
        var array = [[String: Any]]()
        do {
            if let data = try String(contentsOfFile: Bundle.main.path(forResource: "ImageData", ofType: "json")!).data(using: .utf8) {
                let json = JSON(data: data)
                if let jsonArray = json.arrayObject {
                    for dict in jsonArray {
                        array.append(dict as! [String: Any])
                    }
                }
            }

        } catch {
            print("读取失败")
        }
    
        return array
    }()
    
    // MARK: - 系统方法
    
    /**
     视图已经加载方法
     */
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view = imageExplorerView
        imageExplorerView.previousButton.addTarget(self, action: #selector(moveButtonDidClick(button:)), for: .touchUpInside)
        imageExplorerView.nextButton.addTarget(self, action: #selector(moveButtonDidClick(button:)), for: .touchUpInside)
        changeImage()
    }
    
    // MARK: - 图片方法
    
    /**
     改变图片方法
     */
    private func changeImage() {
        
        imageExplorerView.numberLabel.text = String(format: "%d/%d", index + 1, imageArray.count)
        let imageDict = imageArray[index]
        imageExplorerView.imageView.image = UIImage(named: imageDict["no"] as! String)
        imageExplorerView.titleLabel.text = imageDict["title"] as? String
        imageExplorerView.textLabel.text = imageDict["text"] as? String
        
        imageExplorerView.previousButton.isEnabled = (index != 0)
        imageExplorerView.nextButton.isEnabled = (index != imageArray.count - 1)
    }
    
    /**
     移动按钮点击方法
     */
    @objc private func moveButtonDidClick(button: UIButton) {
        
        if button == imageExplorerView.previousButton {
            index -= 1
            
        } else if button == imageExplorerView.nextButton {
            index += 1
        }
        
        changeImage()
    }
    
}
