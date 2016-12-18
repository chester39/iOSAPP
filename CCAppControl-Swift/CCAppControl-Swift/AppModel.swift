//
//  AppModel.swift
//		CCAppControl
//		Chen Chen @ December 18th, 2016
//

import UIKit

class AppModel: NSObject {

    /// 图标
    var icon: String?
    /// 名称
    var name: String?
    
    // MARK: - 初始化方法
    
    /**
     字典初始化方法
     */
    init(dict: [String: Any]) {
        
        super.init()
        
        setValuesForKeys(dict)
    }

}
