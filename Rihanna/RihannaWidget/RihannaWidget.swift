//
//  RihannaWidget.swift
//  RihannaWidget
//
//  Created by Gabriel Lee on 2/3/26.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
        
        
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
    //Add weather entry
}

struct RihannaWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack{
            ContainerRelativeShape()
                .fill(.gray.gradient)
            HStack{
                VStack{
                    Text("Hello")
                    Image("cat_umbrella")
                        .resizable()
                        .scaledToFit()
                }
                VStack{
                    Text("🌧")
                    Text("🌧")
                    Text("🌧")
                }
            }
        }
    }
}

struct RihannaWidget: Widget {
    let kind: String = "RihannaWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                RihannaWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                RihannaWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([
            .systemSmall,
            .accessoryInline,
            .accessoryCircular,
            .accessoryRectangular
        ])
    }
}

//Previews

#Preview("Rectangular", as: .accessoryRectangular) {
    RihannaWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
}

#Preview("SystemSmall", as: .systemSmall) {
    RihannaWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
}

#Preview("Circular", as: .accessoryCircular) {
    RihannaWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
}
