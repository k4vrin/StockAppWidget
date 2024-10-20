//
//  StockService.swift
//  StockApp
//
//  Created by Mostafa Hosseini on 10/20/24.
//

import Foundation
import Combine

struct StockService {
    static func fetchStocks(for symbol: String) -> AnyPublisher<StockData, Error> {
        let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(symbol)&interval=5min&apikey=\(APIKEY)")!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: StockData.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
let APIKEY = "IacgrE6yzp5vKl64F7wiScVQ8v3Ms3mq"
