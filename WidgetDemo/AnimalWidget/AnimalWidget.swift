//
//  AnimalWidget.swift
//  AnimalWidget
//
//  Created by Z on 2020/9/27.
//

import WidgetKit
import SwiftUI
import Intents



struct AnimalProvider: IntentTimelineProvider {
    
    typealias Entry = AnimalSimpleEntry
    typealias Intent = AnimalWidgetConfigurationIntent
    
    
    func placeholder(in context: Context) -> AnimalSimpleEntry {
        AnimalSimpleEntry(date: Date(), animal: .lion)
    }

    func getSnapshot(for configuration: AnimalWidgetConfigurationIntent, in context: Context, completion: @escaping (AnimalSimpleEntry) -> ()) {
        let entry = AnimalSimpleEntry(date: Date(), animal: .lion)
        completion(entry)
    }

    
    func getTimeline(for configuration: AnimalWidgetConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let currentDate = Date()
        
        guard let id = configuration.animal?.identifier, let entryDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate) else {
            let timeline = Timeline(entries: [AnimalSimpleEntry(date: currentDate, animal: .lion)], policy: .atEnd)
            completion(timeline)
            return
        }
        
        let entry = AnimalSimpleEntry(date: entryDate, animal: XXXAnimal.animal(id, color: configuration.color))
        
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct AnimalSimpleEntry: TimelineEntry {
    let date: Date
    /// 新加自己需要的参数
    let animal: XXXAnimal
}

struct AnimalWidgetEntryView : View {
    var entry: AnimalProvider.Entry

    @Environment(\.widgetFamily) var family
    
    var body: some View {
        
        switch family {
        case .systemSmall :
            ZStack {
                entry.animal.color.edgesIgnoringSafeArea(.all)
                VStack{
                    
                    Text(entry.animal.avatar)
                        .font(.largeTitle)
                    
                    Text(entry.animal.name)
                        .foregroundColor(.green)
                    
                    Text("这个是小的")
                }
            }///配置点击链接会在主工程收到拉起事件
            .widgetURL(URL(string: "widgetDemo://789"))
        default:
            ZStack {
                entry.animal.color.edgesIgnoringSafeArea(.all)
                VStack{
                    
                    Text(entry.animal.avatar)
                        .font(.largeTitle)
                    
                    Text(entry.animal.name)
                        .foregroundColor(.green)
                }
            }///配置点击链接会在主工程收到拉起事件
            .widgetURL(URL(string: "widgetDemo://789"))
        }
        
        
    }
}


struct AnimalWidget: Widget {
    let kind: String = "AnimalWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: AnimalWidgetConfigurationIntent.self, provider: AnimalProvider()) { entry in
            AnimalWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("名字")
        .description("描述")
    }
}

struct AnimalWidget_Previews: PreviewProvider {
    static var previews: some View {
        AnimalWidgetEntryView(entry: AnimalSimpleEntry(date: Date(), animal: .lion))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}