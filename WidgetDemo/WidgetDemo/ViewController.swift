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
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ///主动刷新所有的widget
        WidgetCenter.shared.reloadAllTimelines()
    }
    
}



