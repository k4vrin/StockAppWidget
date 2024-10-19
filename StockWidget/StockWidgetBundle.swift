//
//  StockWidgetBundle.swift
//  StockWidget
//
//  Created by Mostafa Hosseini on 10/19/24.
//

import WidgetKit
import SwiftUI

@main
struct StockWidgetBundle: WidgetBundle {
    var body: some Widget {
        StockWidget()
        StockWidgetControl()
        StockWidgetLiveActivity()
    }
}
