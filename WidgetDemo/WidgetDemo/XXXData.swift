//
//  XXXData.swift
//  WidgetDemo
//
//  Created by Z on 2020/9/27.
//

import Foundation
import SwiftUI

struct XXXData {
    
///注意要添加到 WidgetExtension      (option + command + 0 点击文件夹    在 Target Membership 勾选)
    
    static func displayData(_ date: Date = Date()) -> String {
        
        let dateFoematter = DateFormatter()
        dateFoematter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let displayTime = dateFoematter.string(from: date)
        return "🐼🐼🐼\n\(displayTime)"
        
    }
    
}


struct XXXAnimal {
    
    let id: String
    let name: String
    let avatar: String
    var color: Color = .white
    
    
    static let panda = XXXAnimal(id: "panda", name: "panda", avatar: "🐼")
    static let lion = XXXAnimal(id: "lion", name: "lion", avatar: "🦁️")
    static let tiger = XXXAnimal(id: "tiger", name: "tiger", avatar: "🐯")
    
    static let zoo = [panda, lion, tiger]
    
    static func animal(_ id: String, color: AnimalColor) -> XXXAnimal {
        var animal: XXXAnimal
        
        switch id {
        case "panda":
            animal = .panda
        case "lion":
            animal = .lion
        case "tiger":
            animal = .tiger
        default:
            animal = XXXAnimal(id: "cat", name: "cat", avatar: "🐱")
        }
        
        
        switch color {
        case .black:
            animal.color = .black
        case .blue:
            animal.color = .blue
        case .red:
            animal.color = .red
        default:
            animal.color = .orange
        }
        return animal
    }
    
    
}

