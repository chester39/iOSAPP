//
//  ViewController.swift
//		CCTomCat
//		Chen Chen @ December 17th, 2016
//

import UIKit

class ViewController: UIViewController {
    
    /// 汤姆猫视图
    private var tomCatView = TomCatView(frame: kScreenFrame)

    // MARK: - 系统方法
    
    /**
     视图已经加载方法
     */
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view = tomCatView
        tomCatView.eatButton.addTarget(self, action: #selector(eatButtonDidClick), for: .touchUpInside)
        tomCatView.cymbalButton.addTarget(self, action: #selector(cymbalButtonDidClick), for: .touchUpInside)
        tomCatView.drinkButton.addTarget(self, action: #selector(drinkButtonDidClick), for: .touchUpInside)

        tomCatView.fartButton.addTarget(self, action: #selector(fartButtonDidClick), for: .touchUpInside)
        tomCatView.pieButton.addTarget(self, action: #selector(pieButtonDidClick), for: .touchUpInside)
        tomCatView.scratchButton.addTarget(self, action: #selector(scratchButtonDidClick), for: .touchUpInside)

        tomCatView.headButton.addTarget(self, action: #selector(headButtonDidClick), for: .touchUpInside)
        tomCatView.angryButton.addTarget(self, action: #selector(angryButtonDidClick), for: .touchUpInside)
        tomCatView.stomachButton.addTarget(self, action: #selector(stomachButtonDidClick), for: .touchUpInside)
        tomCatView.leftFootButton.addTarget(self, action: #selector(leftFootButtonDidClick), for: .touchUpInside)
        tomCatView.rightFootButton.addTarget(self, action: #selector(rightFootButtonDidClick), for: .touchUpInside)

    }
    
    // MARK: - 按钮方法
    
    /**
     吃饭按钮点击方法
     */
    @objc private func eatButtonDidClick() {
        
        tomCatView.runAnimation(count: 39, name: "eat")
    }
    
    /**
     铜钹按钮点击方法
     */
    @objc private func cymbalButtonDidClick() {
        
        tomCatView.runAnimation(count: 12, name: "cymbal")
    }
    
    /**
     喝水按钮点击方法
     */
    @objc private func drinkButtonDidClick() {
        
        tomCatView.runAnimation(count: 80, name: "drink")
    }
    
    /**
     放屁按钮点击方法
     */
    @objc private func fartButtonDidClick() {
        
        tomCatView.runAnimation(count: 27, name: "fart")
    }
    
    /**
     扔饼按钮点击方法
     */
    @objc private func pieButtonDidClick() {
        
        tomCatView.runAnimation(count: 23, name: "pie")
    }
    
    /**
     抓屏按钮点击方法
     */
    @objc private func scratchButtonDidClick() {
        
        tomCatView.runAnimation(count: 55, name: "scratch")
    }
    
    /**
     打头按钮点击方法
     */
    @objc private func headButtonDidClick() {
        
        tomCatView.runAnimation(count: 80, name: "knockout")
    }
    
    /**
     生气按钮点击方法
     */
    @objc private func angryButtonDidClick() {
        
        tomCatView.runAnimation(count: 25, name: "angry")
    }
    
    /**
     打胃按钮点击方法
     */
    @objc private func stomachButtonDidClick() {
        
        tomCatView.runAnimation(count: 33, name: "stomach")
    }
    
    /**
     左脚按钮点击方法
     */
    @objc private func leftFootButtonDidClick() {
        
        tomCatView.runAnimation(count: 29, name: "footLeft")
    }
    
    /**
     右脚按钮点击方法
     */
    @objc private func rightFootButtonDidClick() {
        
        tomCatView.runAnimation(count: 29, name: "footRight")
    }
    
}
