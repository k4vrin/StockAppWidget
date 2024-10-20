//
//  StockWidgetEntryView.swift
//  StockApp
//
//  Created by Mostafa Hosseini on 10/20/24.
//

import SwiftUI
import WidgetKit

struct StockWidgetEntryView: View {
    var entry: SimpleTimelineProvider.Entry

    var body: some View {
        VStack {
            Text("Symbol:")
            Text(entry.configuration.symbol)
            Text(entry.stockData?.latestClose ?? "default")
            
            if let closeValues = entry.stockData?.closeValues {
                LineChart(values: closeValues)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    .green.opacity(0.7),
                                    .green.opacity(0.2),
                                    .green.opacity(0.0),
                                ]
                            ),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 150, height: 50)
            }
            
            
        }
    }
}


#Preview(as: .systemMedium) {
    StockWidget()
} timeline: {
    SimpleTimelineEntry(date: .now, configuration: .ibm, stockData: nil)
    SimpleTimelineEntry(date: .now, configuration: .tesla, stockData: nil)
}
