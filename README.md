# WidgetDemo


iOS14 Widget

# [简书链接](https://www.jianshu.com/p/84c180963ac6)

### 这个是用户不可配置的，没有编辑选项的 widget。稍后会上传可编辑动态的 widget

![效果图](https://upload-images.jianshu.io/upload_images/2331323-126d13797dd4e2de.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 代码如下
```


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

    ///根据时间线提供需要展示的状态
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        print("时间线刷新了" + "\(Date())")
        
        var entrys: [XXXSimpleEntry] = []
        let currentData = Date()
        
        /// 提供当前时间后 1个小时内  每一秒的状态 (已经提供了3600个状态，太多会不展示卡死)
        for i in 0...60*60 {
            guard let entryDate = Calendar.current.date(byAdding: .second, value: i, to: currentData) else {
                return
            }
            entrys.append(XXXSimpleEntry(date: entryDate, displayTime: XXXData.displayData(entryDate)))
        }
        let timeline = Timeline(entries: entrys, policy: .atEnd)
        completion(timeline)
    }
}

/// 每一个时间线的实体
struct XXXSimpleEntry: TimelineEntry {
    ///展示该状态的时间
    let date: Date
    /// 自己配置的数据
    let displayTime: String
}


/// widget 展示 view
struct XXXWidgetEntryView : View {
    var entry: XXXProvider.Entry
    /// 返回在这个时间 (entry.date)    你想要展示的widegt样式
    var body: some View {
        ZStack {
            
            Color.orange.edgesIgnoringSafeArea(.all)
            VStack {
                Text(entry.displayTime)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.blue)
                    ///配置点击链接会在主工程收到拉起事件
                    .widgetURL(URL(string: "widgetDemo://789"))
            }
        }
    }
}


///widget
struct XXXWidget: Widget {
    let kind: String = "XXXWidget"

    var body: some WidgetConfiguration {
        /// StaticConfiguration 是静态的，用户不可配置的 长按不会出现编辑
        StaticConfiguration(kind: kind, provider: XXXProvider()) { entry in
            XXXWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("添加时的标题")
        .description("添加时的描述")
    }
}

///提供预览状态
struct XXXWidget_Previews: PreviewProvider {
    
    static var previews: some View {
        XXXWidgetEntryView(entry: XXXSimpleEntry(date: Date(), displayTime: XXXData.displayData()))
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


```


### 部分操作的详细截图

![File -> New -> Target](https://upload-images.jianshu.io/upload_images/2331323-d4e70bcacfcacc7d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![这个是用户不可配置的widget，勾选的是用户可配置的。我们先来做不可配置的](https://upload-images.jianshu.io/upload_images/2331323-b19a4ce4f064179c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![调整最低运行系统](https://upload-images.jianshu.io/upload_images/2331323-786376718471b3c5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![关联主工程数据](https://upload-images.jianshu.io/upload_images/2331323-5fcaf3ede4232577.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

