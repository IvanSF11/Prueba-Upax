//
//  PercentageValueFormatter.swift
//  Prueba Upax
//
//  Created by Ivan Soriano on 31/05/22.
//

import Charts

final class PercentageValueFormatter: IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        "\(Int(value))%"
    }
}
