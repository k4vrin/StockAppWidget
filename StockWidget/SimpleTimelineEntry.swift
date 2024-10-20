//
//  SimpleEntry.swift
//  StockApp
//
//  Created by Mostafa Hosseini on 10/20/24.
//

import WidgetKit

struct SimpleTimelineEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let stockData: StockData?
}
