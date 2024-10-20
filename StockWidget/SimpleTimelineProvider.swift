//
//  Provider.swift
//  StockApp
//
//  Created by Mostafa Hosseini on 10/20/24.
//

import WidgetKit
import Combine

class SimpleTimelineProvider: AppIntentTimelineProvider {
    
    var cancelables: Set<AnyCancellable> = []
    
    func placeholder(in context: Context) -> SimpleTimelineEntry {
        SimpleTimelineEntry(date: Date(), configuration: ConfigurationAppIntent(), stockData: nil)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleTimelineEntry {
        await createTimelineEntry(date: Date(), conf: configuration)
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleTimelineEntry> {
        await createTimeline(date: Date(), conf: configuration)
    }


    func createTimelineEntry(date: Date, conf: ConfigurationAppIntent) async -> SimpleTimelineEntry {
        await withCheckedContinuation { continuation in
            StockService
                .fetchStocks(for: conf.symbol)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        // Resume the continuation in case of failure
                        print("createTimelineEntry Failed to fetch stock data: \(error)")
                        continuation.resume(returning: SimpleTimelineEntry(date: date, configuration: conf, stockData: nil))
                    case .finished:
                        break
                    }
                    
                } receiveValue: { stockData in
                    let entry = SimpleTimelineEntry(date: date, configuration: conf, stockData: stockData)
                    continuation.resume(returning: entry)
                    return
                }
                .store(in: &cancelables)
        }

    }
    
    func createTimeline(date: Date, conf: ConfigurationAppIntent) async -> Timeline<SimpleTimelineEntry> {
        await withCheckedContinuation { continuation in
            StockService
                .fetchStocks(for: conf.symbol)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        // Resume the continuation in case of failure
                        print("createTimeline Failed to fetch stock data: \(error)")
                        let entry = SimpleTimelineEntry(date: date, configuration: conf, stockData: nil)
                        let timelien = Timeline(entries: [entry], policy: .atEnd)
                        continuation.resume(returning: timelien)
                    case .finished:
                        break
                    }
                } receiveValue: { stockData in
                    let entry = SimpleTimelineEntry(date: date, configuration: conf, stockData: stockData)
                    
                    
//                    let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: date) ?? Date().addingTimeInterval(3600)
                    
//                    let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
                    let timeline = Timeline(entries: [entry], policy: .atEnd)
                    
                    continuation.resume(returning: timeline)
                    return
                }
                .store(in: &cancelables)
        }

    }
}
