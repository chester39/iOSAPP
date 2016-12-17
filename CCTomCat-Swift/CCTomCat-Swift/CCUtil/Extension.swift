//
//	Extension.swift
//      CCUtil
//		Chen Chen @ November 15th, 2016
//

import Foundation
import UIKit

extension Date {

    /**
     字符串创建日期方法
     */
    static func convertStringToDate(timeString: String, formatterString: String) -> Date  {

        let formatter = DateFormatter()
        formatter.dateFormat = formatterString
        formatter.locale = Locale(identifier: "en")

        return formatter.date(from: timeString)!
    }

    /**
     格式化字符串方法
     */
    static func formatDateToString(date: Date) -> String {

        let dateFormatter = DateFormatter()
        let nowDate = Date()
        let time = nowDate.timeIntervalSince(date)
        var dateString = ""

        switch time {
        case 0...60:
            dateString = "刚刚"

        case 61...(60 * 60):
            let minute = (Int)(time / 60)
            dateString = "\(minute)分钟前"

        case (60 * 60)...(60 * 60 * 24):
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let dateDayString = dateFormatter.string(from: date)
            let nowDayString = dateFormatter.string(from: nowDate)

            dateFormatter.dateFormat = "HH:mm"
            if dateDayString == nowDayString {
                dateString = "今天\(dateFormatter.string(from: date))"

            } else {
                dateString = "昨天\(dateFormatter.string(from: date))"
            }

        default:
            dateFormatter.dateFormat = "yyyy"
            let dateYearString = dateFormatter.string(from: date)
            let nowYearString = dateFormatter.string(from: nowDate)

            if dateYearString == nowYearString {
                dateFormatter.dateFormat = "MM-dd"
                dateString = dateFormatter.string(from: date)

            } else {
                dateFormatter.dateFormat = "yyyy/MM/dd"
                dateString = dateFormatter.string(from: date)
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

        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).appendingPathComponent(name)

        return filePath
    }

    /**
     获取文档目录方法
     */
    func acquireDocumentDirectory() -> String {

        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).appendingPathComponent(name)

        return filePath
    }

    /**
     获取临时目录方法
     */
    func acquireTemporaryDirectory() -> String {

        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).appendingPathComponent(name)

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
            setImage(UIImage(named: name), for: .normal)
            setImage(UIImage(named: name + "_highlighted"), for: .highlighted)
        }

        if let backgroundName = backgroundImageName {
            setBackgroundImage(UIImage(named: backgroundName), for: .normal)
            setBackgroundImage(UIImage(named: backgroundName + "_highlighted"), for: .highlighted)
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
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        button.sizeToFit()
        button.addTarget(target, action: action, for: .touchUpInside)

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

extension UIImage {

    /**
     图片染色方法
     */
    func tintImageWithColor(color: UIColor, alpha: CGFloat) -> UIImage {

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, scale)
        let context = UIGraphicsGetCurrentContext()
        draw(in: rect)

        context?.setFillColor(color.cgColor)
        context?.setAlpha(alpha)
        context?.setBlendMode(.sourceAtop)
        context?.fill(rect)

        let imageRef = context?.makeImage()!
        let newImage = UIImage(cgImage: imageRef!, scale: scale, orientation: imageOrientation)
        UIGraphicsEndImageContext()

        return newImage
    }

    /**
     重叠图片方法
     */
    func overlapImageWithColor(color: UIColor) -> UIImage {

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        UIGraphicsBeginImageContext(size)
        colorImage?.draw(in: rect)
        draw(in: rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

}

extension UILabel {

    /**
     文字和字号和行数便利初始化方法
     */
    convenience init(text: String, fontSize: CGFloat, lines: Int) {

        self.init()

        self.text = text
        font = UIFont.systemFont(ofSize: fontSize)
        numberOfLines = lines
    }

}

extension UIView {
    
    /**
     获取缓存大小方法
     */
    func acquireCachesSize() -> Float {
        
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
        let fileAttributes = FileManager.default.subpaths(atPath: cachePath)!
        var size = 0
        for fileName in fileAttributes {
            let path = cachePath + "/\(fileName)"
            let attributes = try! FileManager.default.attributesOfItem(atPath: path)
            for (numberA, numberB) in attributes {
                if numberA == FileAttributeKey.size {
                    size += numberB as! Int
                }
            }
        }
        
        let mb: Float = Float(size) / 1024 / 1024
        
        return mb
    }
    
    /**
     清除缓存方法
     */
    func clearCaches() {
        
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
        let fileAttributes = FileManager.default.subpaths(atPath: cachePath)!
        for fileName in fileAttributes {
            let path = cachePath + "/\(fileName)"
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                    
                } catch {
                    print("清除缓存失败")
                }
            }
        }
    }
    
}

extension UIWindow {

    /**
     判断是否浅色方法
     */
    class func isLightColor(string: String) -> Bool {

        let redString = (string as NSString).substring(with: NSRange(location: 1, length: 2))
        let greenString = (string as NSString).substring(with: NSRange(location: 3, length: 2))
        let blueString = (string as NSString).substring(with: NSRange(location: 5, length: 2))

        var scanner = Scanner(string: redString)
        var red: UInt32 = 0
        var green: UInt32 = 0
        var blue: UInt32 = 0
        scanner.scanHexInt32(&red)
        scanner = Scanner(string: greenString)
        scanner.scanHexInt32(&green)
        scanner = Scanner(string: blueString)
        scanner.scanHexInt32(&blue)

        if (red + blue + green) < 382 {
            return false

        } else {
            return true
        }
    }

}
