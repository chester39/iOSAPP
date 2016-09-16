//
//	Extension.swift
//		CCButtonUse
//		Chen Chen @ July 25th, 2016
//

import Foundation
import UIKit

extension NSDate {
    
    /**
     字符串创建日期方法
     */
    class func convertStringToDate(timeString: String, formatterString: String) -> NSDate  {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = formatterString
        formatter.locale = NSLocale(localeIdentifier: "en")
        
        return formatter.dateFromString(timeString)!
    }
    
    /**
     格式化字符串方法
     */
    class func formatDateToString(date: NSDate) -> String {
        
        let dateFormatter = NSDateFormatter()
        let nowDate = NSDate()
        let time = nowDate.timeIntervalSinceDate(date)
        var dateString = ""
        
        switch time {
        case 0...60:
            dateString = "刚刚"
            
        case 61...(60 * 60):
            let minute = (Int)(time / 60)
            dateString = "\(minute)分钟前"
            
        case (60 * 60)...(60 * 60 * 24):
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let dateDayString = dateFormatter.stringFromDate(date)
            let nowDayString = dateFormatter.stringFromDate(nowDate)
            
            dateFormatter.dateFormat = "HH:mm"
            if dateDayString == nowDayString {
                dateString = "今天\(dateFormatter.stringFromDate(date))"
            } else {
                dateString = "昨天\(dateFormatter.stringFromDate(date))"
            }
            
        default:
            dateFormatter.dateFormat = "yyyy"
            let dateYearString = dateFormatter.stringFromDate(date)
            let nowYearString = dateFormatter.stringFromDate(nowDate)
            
            if dateYearString == nowYearString {
                dateFormatter.dateFormat = "MM-dd"
                dateString = dateFormatter.stringFromDate(date)
            } else {
                dateFormatter.dateFormat = "yyyy/MM/dd"
                dateString = dateFormatter.stringFromDate(date)
            }
        }
        
        return dateString
    }
    
}

extension String {
    
    /**
     获取缓存目录方法
     */
    func acquireCachesDirectory() -> String {
        
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).stringByAppendingPathComponent(name)
        
        return filePath
    }
    
    /**
     获取文档目录方法
     */
    func acquireDocumentDirectory() -> String {
        
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).stringByAppendingPathComponent(name)
        
        return filePath
    }
    
    /**
     获取临时目录方法
     */
    func acquireTemporaryDirectory() -> String {
        
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).stringByAppendingPathComponent(name)
        
        return filePath
    }
    
}

extension UIButton {
    
    /**
     图片和背景图片便利初始化方法
     */
    convenience init(imageName: String?, backgroundImageName: String?) {
        
        self.init()
        
        if let name = imageName {
            setImage(UIImage(named: name), forState: .Normal)
            setImage(UIImage(named: name + "_highlighted"), forState: .Highlighted)
        }
        
        if let backgroundName = backgroundImageName {
            setBackgroundImage(UIImage(named: backgroundName), forState: .Normal)
            setBackgroundImage(UIImage(named: backgroundName + "_highlighted"), forState: .Highlighted)
        }
        
        sizeToFit()
    }
    
}

extension UIBarButtonItem {
    
    /**
     指定图片和目标便利初始化方法
     */
    convenience init(imageName: String, target: AnyObject?, action: Selector) {
        
        let button = UIButton()
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        button.sizeToFit()
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        
        self.init(customView: button)
    }
    
}

extension UIColor {
    
    /**
     十六进制颜色便利初始化方法
     */
    convenience init(hex: Int) {
        
        self.init(hex: hex, alpha: 1.0)
    }
    
    /**
     十六进制透明度颜色便利初始化方法
     */
    convenience init(hex: Int, alpha: CGFloat) {
        
        self.init(red: (CGFloat)((hex & 0xFF0000) >> 16) / 255.0, green: (CGFloat)((hex & 0x00FF00) >> 8) / 255.0, blue: (CGFloat)((hex & 0x0000FF) >> 0) / 255.0, alpha: alpha)
    }
    
}

extension UILabel {
    
    /**
     文字和字号和行数便利初始化方法
     */
    convenience init(text: String, fontSize: CGFloat, lines: Int) {
        
        self.init()
        
        self.text = text
        self.font = UIFont.systemFontOfSize(fontSize)
        self.numberOfLines = lines
    }
}
