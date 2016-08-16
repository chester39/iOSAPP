//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ August 15th, 2016
//

import UIKit

class ViewController: UIViewController {

    // 加法计算视图
    var addCounterView = AddCounterView(frame: UIScreen.mainScreen().bounds)
    
    // MARK: - 系统方法
    
    /**
     视图已经加载方法
     */
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view = addCounterView
        addCounterView.addButton.addTarget(self, action: #selector(addCounter), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    // MARK: - 界面方法
    
    /**
     加法计算方法
     */
    func addCounter() {
        let a: Int = Int(addCounterView.numberA.text!) ?? 0
        let b: Int = Int(addCounterView.numberB.text!) ?? 0
        addCounterView.sumAnswer.text = String(a + b)
        
        view.endEditing(true)
    }
    
}