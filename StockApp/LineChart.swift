//
//  LineChart.swift
//  StockApp
//
//  Created by Mostafa Hosseini on 10/13/24.
//

import SwiftUI

struct LineChart: Shape {
    var values: [Double]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let start = CGPoint(x: rect.minX, y: rect.maxY - (CGFloat(values[0]) * rect.maxY))

        path.move(to: start)
        
        for index in values.indices.dropFirst() {
            let value = CGFloat(values[index])
            let x = (CGFloat(index) / CGFloat(values.count - 2)) * rect.maxX
            let y = rect.maxY - (CGFloat(value) * rect.maxY)
            let point = CGPoint(x: x, y: y)
            
            path.addLine(to: point)
        }
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: start)
        
        return path
    }
}
