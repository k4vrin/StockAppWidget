//
//  AppIntent.swift
//  StockWidget
//
//  Created by Mostafa Hosseini on 10/19/24.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "This is an example widget." }
    
    @Parameter(title: "Symbol", description: "The symbol of the stock to display.", default: "IBM", inputOptions: String.IntentInputOptions(capitalizationType: .allCharacters))
    var symbol: String
}

extension ConfigurationAppIntent {
    static var ibm: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.symbol = "IBM"
        return intent
    }

    static var tesla: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.symbol = "TSLA"
        return intent
    }
}
