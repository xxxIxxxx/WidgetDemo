//
//  XXXWidget.swift
//  XXXWidget
//
//  Created by Z on 2020/9/24.
//

import WidgetKit
import SwiftUI


struct XXXData {
    
    ///快速获取一个展示状态
    static var oneDisplayDate:XXXSimpleEntry {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let displayTime = dateFormatter.string(from: Date())
            let entry = XXXSimpleEntry(date: Date(), displayTime: displayTime)
            return entry
        }
    }
    
    ///准备当前时间后1个小时的 展示状态
    static func displayData() ->[XXXSimpleEntry] {
        var entries: [XXXSimpleEntry] = []
        let currentDate = Date()
        for i in 0...60*60 {
            guard let entryDate = Calendar.current.date(byAdding: .second, value: i, to: currentDate) else { return entries }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let displayTime = dateFormatter.string(from: entryDate)
            let entry = XXXSimpleEntry(date: entryDate, displayTime: displayTime)
            entries.append(entry)
        }
        return entries
    }
    
}

struct XXXProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> XXXSimpleEntry {
        XXXData.oneDisplayDate
    }
    
    func getSnapshot(in context: Context, completion: @escaping (XXXSimpleEntry) -> ()) {
        let entry = XXXData.oneDisplayDate
        completion(entry)
    }

    ///根据时间线提供需要展示的状态
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        print("刷新了" + "\(Date())")
        let timeline = Timeline(entries: XXXData.displayData(), policy: .atEnd)
        completion(timeline)
    }
}


struct XXXSimpleEntry: TimelineEntry {
    
    let date: Date
    /// 自己配置的数据
    let displayTime: String
}

struct XXXWidgetEntryView : View {
    var entry: XXXProvider.Entry
    /// 返回在这个时间 entry.date   你想要展示的widegt样式
    var body: some View {
        ZStack {
            
            Color.orange.edgesIgnoringSafeArea(.all)
            VStack {
                Text("🐼\n" + "\(entry.displayTime)")
                    .foregroundColor(.blue)
                    ///配置点击连接 会在主工程收到拉起事件
                    .widgetURL(URL(string: "widgetDemo://789"))
            }
        }
    }
}


struct XXXWidget: Widget {
    let kind: String = "XXXWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: XXXProvider()) { entry in
            XXXWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("添加时的标题")
        .description("添加时的描述")
    }
}

struct XXXWidget_Previews: PreviewProvider {
    
    static var previews: some View {
        XXXWidgetEntryView(entry: XXXData.oneDisplayDate)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


///主入口
@main
struct AllWidget: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        XXXWidget()
    }
}


