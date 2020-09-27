//
//  XXXData.swift
//  WidgetDemo
//
//  Created by Z on 2020/9/27.
//

import Foundation


struct XXXData {
    
///注意要添加到 WidgetExtension      (option + command + 0 点击文件夹    在 Target Membership 勾选)
    
    static func displayData(_ date: Date = Date()) -> String {
        
        let dateFoematter = DateFormatter()
        dateFoematter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let displayTime = dateFoematter.string(from: date)
        return "🐼🐼🐼\n\(displayTime)"
        
    }
    
}



