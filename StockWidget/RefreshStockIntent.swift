//
//  RefreshStockIntent.swift
//  StockApp
//
//  Created by Mostafa Hosseini on 10/20/24.
//

import AppIntents
import WidgetKit

struct RefreshStocksIntent: AppIntent {
    static var title: LocalizedStringResource = "Refresh Stocks"
    
    func perform() async throws -> some IntentResult {
        // Trigger a widget reload for your widget kind
        WidgetCenter.shared.reloadTimelines(ofKind: "StockWidget")
        return .result()
    }
}
