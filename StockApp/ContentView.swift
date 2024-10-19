//
//  ContentView.swift
//  StockApp
//
//  Created by Mostafa Hosseini on 10/5/24.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ContentViewModel = .init()

    var body: some View {
        NavigationView {
            List {
                HStack {
                    TextField("Symbol", text: $viewModel.symbol)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: viewModel.symbol) { newValue in
                            viewModel.symbol = newValue.uppercased() 
                        }

                    Button("Add") {
                        viewModel.addStock()
                    }
                    .disabled(!viewModel.symbolValid)
                }
                if !viewModel.stockData.isEmpty {
                    ForEach(viewModel.stockData) { stock in
                        HStack {
                            Text(stock.metaData.the2Symbol)

                            Spacer()

                            LineChart(values: stock.closeValues)
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

                            VStack(alignment: .trailing) {
                                Text(stock.latestClose)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.deleteStockData(at: indexSet)
                    }
                }
            }
            .navigationTitle("Stock App")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
