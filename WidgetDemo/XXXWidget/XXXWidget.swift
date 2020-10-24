//
//  XXXWidget.swift
//  XXXWidget
//
//  Created by Z on 2020/9/24.
//

import SwiftUI
import WidgetKit

/// 时间线
struct XXXProvider: TimelineProvider {
    /// 占位的展示
    func placeholder(in context: Context) -> XXXSimpleEntry {
        XXXSimpleEntry(date: Date(), displayTime: XXXData.displayData())
    }

    /// 快照
    func getSnapshot(in context: Context, completion: @escaping (XXXSimpleEntry) -> ()) {
        let entry = XXXSimpleEntry(date: Date(), displayTime: XXXData.displayData())
        completion(entry)
    }

    /// 根据时间线提供需要展示的状态
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        // 这个刷新并不是每秒刷新
        // 1. 下面提供的 300 个状态展示完了，可能会刷新
        // 2. 系统发生变化 会自动刷新，你可以尝试改下手机时间看看
        print("时间线刷新了" + "\(Date())" + "\("""
                这个刷新并不是每秒刷新
                 1. 下面提供的 300 个状态展示完了，可能会刷新
                 2. 系统发生变化会自动刷新，你可以尝试改下手机时间看看
                 3. 调用了 WidgetCenter.shared.reloadAllTimelines() 会刷新
        """)")

        var entrys: [XXXSimpleEntry] = []
        let currentData = Date()

        /// 提供当前时间后 5分钟内   每一秒的状态 (已经提供了 300 个状态，太多会不展示卡死)
        for i in 0 ... 60 * 5 {
            guard let entryDate = Calendar.current.date(byAdding: .second, value: i, to: currentData) else {
                return
            }
            entrys.append(XXXSimpleEntry(date: entryDate, displayTime: XXXData.displayData(entryDate)))
        }
        let timeline = Timeline(entries: entrys, policy: .atEnd)
        completion(timeline)

        /// 也可以在这里做网络请求去拿数据  然后把 completion(timeline) 下载你的网络回调里 就是数据处理完后准备好了刷新状态 在去调用 completion(timeline)
    }
}

/// 每一个时间线的实体
struct XXXSimpleEntry: TimelineEntry {
    /// 展示该状态的时间
    let date: Date
    /// 自己配置的数据
    let displayTime: String
}

/// widget 展示 view
struct XXXWidgetEntryView: View {
    var entry: XXXProvider.Entry

    /// 当前展示 widget 的大小
    @Environment(\.widgetFamily) var family

    /// 返回在这个时间 (entry.date)    你想要展示的 widegt 样式
    var body: some View {
        ZStack {
            Color.orange.edgesIgnoringSafeArea(.all)

            switch family {
            case .systemSmall:
                VStack {
                    Text(entry.displayTime)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.blue)
                } /// 配置点击链接会在主工程收到拉起事件
                .widgetURL(URL(string: "widgetDemo://789"))

            default:
                VStack {
                    Text(entry.displayTime)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.blue)
                        .font(Font.largeTitle)
                } /// 配置点击链接会在主工程收到拉起事件
                .widgetURL(URL(string: "widgetDemo://789"))
            }
        }
    }
}

/// widget
struct XXXWidget: Widget {
    let kind: String = "XXXWidget"

    var body: some WidgetConfiguration {
        /// StaticConfiguration 是静态的，用户不可配置的 长按不会出现编辑
        StaticConfiguration(kind: kind, provider: XXXProvider()) { entry in
            XXXWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("添加时的标题")
        .description("添加时的描述")
        .supportedFamilies([.systemLarge, .systemMedium, .systemSmall]) // 支持大小类型
    }
}

/// 提供预览状态
struct XXXWidget_Previews: PreviewProvider {
    static var previews: some View {
        XXXWidgetEntryView(entry: XXXSimpleEntry(date: Date(), displayTime: XXXData.displayData()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

/// 主入口
@main
struct AllWidget: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        XXXWidget()
        AnimalWidget()
    }
}
