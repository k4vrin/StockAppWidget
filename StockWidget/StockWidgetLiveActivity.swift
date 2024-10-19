//
//  StockWidgetLiveActivity.swift
//  StockWidget
//
//  Created by Mostafa Hosseini on 10/19/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct StockWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct StockWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: StockWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension StockWidgetAttributes {
    fileprivate static var preview: StockWidgetAttributes {
        StockWidgetAttributes(name: "World")
    }
}

extension StockWidgetAttributes.ContentState {
    fileprivate static var smiley: StockWidgetAttributes.ContentState {
        StockWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: StockWidgetAttributes.ContentState {
         StockWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: StockWidgetAttributes.preview) {
   StockWidgetLiveActivity()
} contentStates: {
    StockWidgetAttributes.ContentState.smiley
    StockWidgetAttributes.ContentState.starEyes
}
