//
//  ViewController.swift
//		CCAppControl
//		Chen Chen @ December 17th, 2016
//

import UIKit

import Cartography
import SwiftyJSON

class ViewController: UIViewController {

    /// Cell重用标识符
    fileprivate let reuseIdentifier = "AppCell"
    
    /// 提示标签
    fileprivate lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .gray
        label.textAlignment = .center
        label.alpha = 0.0
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        
        return label
    }()
    
    /// 应用集合视图
    fileprivate lazy var appView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: AppLayout())
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: kViewBorder, left: kViewBorder, bottom: kViewBorder, right: kViewBorder)
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    /// 应用数组
    fileprivate lazy var appArray: [AppModel] = {
        var array = [AppModel]()
        do {
            if let data = try String(contentsOfFile: Bundle.main.path(forResource: "AppList", ofType: "json")!).data(using: .utf8) {
                let json = JSON(data: data)
                if let jsonArray = json.arrayObject {
                    for dict in jsonArray {
                        let app = AppModel(dict: dict as! [String: Any])
                        array.append(app)
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
        
        setupUI()
        setupConstraints()
    }
    
    // MARK: - 界面方法
    
    /**
     初始化界面方法
     */
    private func setupUI() {
        
        appView.register(AppCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        view.addSubview(appView)
        view.addSubview(tipLabel)
    }
    
    /**
     初始化约束方法
     */
    private func setupConstraints() {
        
        constrain(appView, tipLabel) { appView, tipLabel in
            appView.edges == inset(appView.superview!.edges, 0)
            
            tipLabel.width == 200
            tipLabel.height == 44
            tipLabel.centerX == tipLabel.superview!.centerX
            tipLabel.bottom == tipLabel.superview!.bottom - kViewDistance
        }
    }

}

extension ViewController: UICollectionViewDataSource {
    
    /**
     共有组数方法
     */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    /**
     每组集数方法
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return appArray.count
    }
    
    /**
     每集内容方法
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AppCell
        cell.appModel = appArray[indexPath.item]
        cell.delegate = self
        return cell
    }
    
}

extension ViewController: AppCellDelegate {
    
    /**
     下载按钮点击方法
     */
    func appCellDidClickDownloadButton(cell: AppCell) {
        
        tipLabel.text = String(format: "成功下载%@", cell.appModel?.name ?? "")
        UIView.animate(withDuration: 1.0, animations: { 
            self.tipLabel.alpha = 0.5
            
        }) { finished in
            UIView.animate(withDuration: 1.0, delay: 2.0, options: .curveLinear, animations: { 
                self.tipLabel.alpha = 0.0
                
            }, completion: { bool in
                print(bool)
            })
        }
    }
    
}

class AppLayout: UICollectionViewFlowLayout {
    
    /**
     准备布局方法
     */
    override func prepare() {
        
        super.prepare()
        
        let totalColumns = 3
        let appWidth = 85
        let appHeight = 90
        itemSize = CGSize(width: appWidth, height: appHeight)
        minimumInteritemSpacing = kViewMargin
        minimumLineSpacing = (kScreenWidth - CGFloat(totalColumns * appWidth)) / CGFloat(totalColumns + 1)
        
        collectionView?.bounces = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
    }
    
}
