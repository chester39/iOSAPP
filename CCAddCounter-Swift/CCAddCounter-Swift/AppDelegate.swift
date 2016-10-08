//
//	AppDelegate.swift
//		CCAddCounter
//		Chen Chen @ August 15th, 2016
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// 应用窗口
    var window: UIWindow?
    
    // MARK: - 系统代理方法
    
    /**
     应用启动方法
     */
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: kScreenFrame)
        window?.backgroundColor = CommonLightColor
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    /**
     应用将要失去焦点方法
     */
    func applicationWillResignActive(application: UIApplication) {
        
        print(#function)
    }
    
    /**
     应用已经进入后台方法
     */
    func applicationDidEnterBackground(application: UIApplication) {
        
        print(#function)
    }
    
    /**
     应用将要进入前台方法
     */
    func applicationWillEnterForeground(application: UIApplication) {
        
        print(#function)
    }
    
    /**
     应用已经成为焦点方法
     */
    func applicationDidBecomeActive(application: UIApplication) {
        
        print(#function)
    }
    
    /**
     应用将要终止方法
     */
    func applicationWillTerminate(application: UIApplication) {
        
        print(#function)
    }
    
}
