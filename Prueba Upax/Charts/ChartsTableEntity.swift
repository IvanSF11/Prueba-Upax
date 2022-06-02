//
//  ChartsTableEntity.swift
//  Prueba Upax
//
//  Created by Ivan Soriano on 31/05/22.
//

import Foundation
import Charts

struct ResponseData: Decodable {
    let data: [ResponseChar]
}

struct ResponseChar: Decodable {
    let pregunta: String
    let values: [Question]
}

struct Question: Decodable, Hashable {
    let label: String
    let value: Int
}

struct ChartData: Decodable, Hashable {
    let text: String
    let percetnage: Int
}

extension ResponseData {
    var chartData: [PieChartData] {
        return data.map { question in
            chartSet(using: question)
        }
    }

    private func chartSet(using question: ResponseChar) -> PieChartData {
        let entries = question.values.map { data in
            PieChartDataEntry(value: Double(data.value), label: data.label)
        }
        
        let set = PieChartDataSet(entries: entries, label: question.pregunta)
        
        var color = [UIColor]()
        for _ in question.values{
            color.append(UIColor.random)
        }
        
        set.colors = color
        
        return PieChartData(dataSet: set)
    }
}


extension UIColor {
    static var random: UIColor {
        return .init(hue: .random(in: 0...1), saturation: 1, brightness: 1, alpha: 0.5)
    }
}
