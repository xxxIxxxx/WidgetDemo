//
//  IntentHandler.swift
//  WidgetDemo
//
//  Created by Z on 2020/9/27.
//

import Intents

/// 自己创建的文件
class IntentHandler: INExtension, AnimalWidgetConfigurationIntentHandling { // AnimalWidgetConfigurationIntentHandling 是第二步的名字 加上 IntentHandling 后缀
    /// 配置给用户可选的列表                    AnimalWidgetConfigurationIntent 是第二步的名字 加上 Intent 后缀
    func provideAnimalOptionsCollection(for intent: AnimalWidgetConfigurationIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<Animal>?, Error?) -> Void) {
        /// 这里可以去请求网络拿数据

        /// 搜索词 searchTerm 搜索cat
        if searchTerm == "cat" {
            completion(INObjectCollection(items: [Animal(identifier: "cat", display: "cat")]), nil)
        }

        let animals: [Animal] = XXXAnimal.zoo.map { xxxAnimal in
            Animal(identifier: xxxAnimal.id, display: xxxAnimal.name)
        }
        completion(INObjectCollection(items: animals), nil)
    }

    override func handler(for intent: INIntent) -> Any {
        return self
    }
}
