//
//  ContentViewModel.swift
//  StockApp
//
//  Created by Mostafa Hosseini on 10/5/24.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {
    
    private let context = PersistenceController.shared.container.viewContext
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var stockData: [StockData] = []
    @Published var symbol: String = ""
    @Published var symbolValid: Bool = false
    
    @Published var stockEntities: [StockEntity] = []
    
    init() {
        loadFromCoreData()
        loadAllSymbols()
        
        validateSymbolField()
    }
    
    func loadFromCoreData() {
        do {
            stockEntities = try context.fetch(StockEntity.fetchRequest())
        } catch {
            print("Error fetching data from Core Data: \(error)")
        }
    }
    
    func addStock() {
        let newStock = StockEntity(context: context)
        newStock.symbol = symbol
        
        do {
            try context.save()
        } catch {
            print("Error saving data to Core Data: \(error)")
        }
        
        fetchStockData(symbol: symbol)
        stockEntities.append(newStock)
        symbol.removeAll()
    }
    
    func loadAllSymbols() {
        
        stockData.removeAll()
        for stockEntity in stockEntities {
            if let symbol = stockEntity.symbol {
                fetchStockData(symbol: symbol)
            }
        }
    }
    
    func fetchStockData(symbol: String) {
        
        StockService
            .fetchStocks(for: symbol)
            .sink { completion in
                
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("Error: \(error)")
                    break
                }
            } receiveValue: { [weak self] stockData in
                guard let self else { return }
                
                DispatchQueue.main.async {
                    self.stockData.append(stockData)
                }
            }
            .store(in: &cancellables)
            
    }
    
    func deleteStockData(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        
        stockData.remove(at: index)
        let element = stockEntities.remove(at: index)
        context.delete(element)
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    func validateSymbolField() {
        $symbol
            .sink { [weak self] newValue in
                guard let self else { return }
                self.symbolValid = !newValue.isEmpty
            }
            .store(in: &cancellables)
    }
}



