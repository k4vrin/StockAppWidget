//
//  StockWidget.swift
//  StockWidget
//
//  Created by Mostafa Hosseini on 10/19/24.
//

import SwiftUI
import WidgetKit

// MARK: - Widget entry point

struct StockWidget: Widget {
    // Unique identifier for widget
    let kind: String = "StockWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ConfigurationAppIntent.self,
            // Refresh widget in intervals
            provider: SimpleTimelineProvider()
        ) { entry in
            // entry -> timeline entry
            StockWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Stock Widget")
        // Widget size
        .supportedFamilies([.systemMedium])
    }
} 

#Preview(as: .systemMedium) {
    StockWidget()
} timeline: {
    SimpleTimelineEntry(date: .now, configuration: .ibm, stockData: nil)
    SimpleTimelineEntry(date: .now, configuration: .tesla, stockData: nil)
}
