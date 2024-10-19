//
//  StockData.swift
//  StockApp
//
//  Created by Mostafa Hosseini on 10/5/24.
//

import Foundation


struct StockData: Codable, Identifiable {
    let id = UUID()
    
    let metaData: MetaData
    let timeSeries5Min: [String: StockDataEntry]
    var latestClose: String {
        timeSeries5Min.first?.value.the4Close ?? ""
    }
    var closeValues: [Double] {
        let rawValues = timeSeries5Min.values.map { Double($0.the4Close)! }
        let max = rawValues.max()!
        let min = rawValues.min()!
        return rawValues.map {
            ($0 - min * 0.95) / (max - min * 0.95)
        }
    }

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries5Min = "Time Series (5min)"
    }

    // MARK: - MetaData
    struct MetaData: Codable {
        let the1Information, the2Symbol, the3LastRefreshed, the4Interval: String
        let the5OutputSize, the6TimeZone: String

        enum CodingKeys: String, CodingKey {
            case the1Information = "1. Information"
            case the2Symbol = "2. Symbol"
            case the3LastRefreshed = "3. Last Refreshed"
            case the4Interval = "4. Interval"
            case the5OutputSize = "5. Output Size"
            case the6TimeZone = "6. Time Zone"
        }
    }

    // MARK: - TimeSeries5Min
    struct StockDataEntry: Codable {
        let the1Open, the2High, the3Low, the4Close: String
        let the5Volume: String

        enum CodingKeys: String, CodingKey {
            case the1Open = "1. open"
            case the2High = "2. high"
            case the3Low = "3. low"
            case the4Close = "4. close"
            case the5Volume = "5. volume"
        }
    }
}
