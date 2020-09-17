//
//  LifeCollectionOneTime.swift
//  LifeCollectionOneTime
//
//  Created by gozap on 2020/9/17.
//  Copyright © 2020 com.longdai. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {

    func placeholder(in context: Context) -> SimpleEntry {
        let model = Model(image: UIImage(named: "38")!, title: "我的时间诞生",days: "90",time: "2020-09-17")
        return SimpleEntry(date: Date(), model: model)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let model = Model(image: UIImage(named: "38")!, title: "我的时间诞生",days: "90",time: "2020-09-17")
        let entry = SimpleEntry(date: Date(), model: model)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let userDefault = UserDefaults.init(suiteName: "group.com.xuzhou.LifeCollection")
        let dic = userDefault?.object(forKey: "widget") as! NSDictionary
        
        
        //标题
        let titleStr:String = dic["title"] as! String
        //背景图片
        let colorType = dic["colorType"]
        let imageArray = ["01","07","02","48","38","28","55"]
        let imageStr = imageArray[(colorType as! NSString).integerValue]
        
        let time = dic["time"]
        var days = "0"
        //类型
        let classType = dic["classType"]
        var classTypeStr = "目标日:"
        if classType as! String == "累计日" {
            classTypeStr = "起始日:"
            let timeInterval = DateFormatter.date(fromTimeStamp: (time as! String))
            if let timeInt = timeInterval?.timeIntervalSinceNow {
                if timeInt < 0 {
                    var temp = 0
                    var result = "0"
                    temp = Int(fabs(timeInt)/60)
                    if ((temp/60) < 24) {
                        result = "0"
                    }else if ((temp/60/24) < 10000){
                        result = "\(temp/60/24)"
                    }
                    days = result
                }else{
                    days = "0"
                }
            }
        }else{
            
        }
        //日期
        var targetDateStr = DateFormatter.string(fromBirthday: DateFormatter.date(fromTimeStamp: (dic["time"] as! String)))
        targetDateStr = classTypeStr + (targetDateStr ?? "")
        
        let model = Model(image: UIImage(named: imageStr)!, title: titleStr,days: days,time: targetDateStr ?? "")
        let entry =  SimpleEntry(date: Date(), model: model)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
        
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date

    let model:Model
}

@main
struct LifeCollectionOneTime: Widget {
    let kind: String = "LifeCollectionOneTime"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetView(model: entry.model)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct LifeCollectionOneTime_Previews: PreviewProvider {
    static var previews: some View {
        let model = Model(image: UIImage(named: "38")!, title: "占位",days: "90",time: "2020-09-17")
        WidgetView(model: model).previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


struct Model {
  
    let image: UIImage
    
    let title: String
    
    let days: String
    
    let time: String
}

struct WidgetView: View {
    
    let model: Model

    @ViewBuilder
    var body: some View {
        ZStack(alignment: .topLeading, content: {
            Image(uiImage: model.image).resizable()
            VStack {
                Text(model.title)
                    .padding(20)
                    .offset(x: 10, y: 20)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .frame(width: 150, height: 20, alignment: .center)
                
                
                Text(model.days)
                    .offset(x: 10, y: 10)
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .frame(width: 80, height: 80, alignment: .center)
                
                Text(model.time)
                    .offset(x: 10, y: 10)
                    .font(.system(size: 13))
                    .foregroundColor(.white)
                    .frame(width: 150, height: 20, alignment: .center)
                
            }
        })
    }
}
