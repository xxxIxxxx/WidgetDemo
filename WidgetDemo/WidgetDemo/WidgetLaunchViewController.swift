//
//  WidgetLaunchViewController.swift
//  WidgetDemo
//
//  Created by Z on 2020/9/27.
//

import UIKit

class WidgetLaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .cyan
        
        let tipLab = UILabel()
        tipLab.text = "点击 widget 启动"
        view.addSubview(tipLab)
        tipLab.frame = CGRect(x: 20, y: 100, width: 300, height: 20)
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
