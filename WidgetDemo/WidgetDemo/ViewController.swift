//
//  ViewController.swift
//  WidgetDemo
//
//  Created by Z on 2020/9/24.
//

import UIKit
import WidgetKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .green
        
        let tipLab = UILabel()
        tipLab.text = "点击屏幕主动刷新   widget"
        view.addSubview(tipLab)
        tipLab.frame = CGRect(x: 20, y: 100, width: 300, height: 20)
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ///主动刷新所有的widget
        WidgetCenter.shared.reloadAllTimelines()
    }
    
}



