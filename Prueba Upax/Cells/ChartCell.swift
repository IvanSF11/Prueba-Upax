//
//  ChartCell.swift
//  Prueba Upax
//
//  Created by Ivan Soriano on 31/05/22.
//

import UIKit
import Charts

class ChartCell: UITableViewCell {
    
    static let identifier = "ChartCell"
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pieChart: PieChartView = {
        let chart = PieChartView()
        chart.holeRadiusPercent = 0.80
        chart.drawEntryLabelsEnabled = false
        chart.largeContentTitle = "Mi grafica"
        chart.usePercentValuesEnabled = true
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with data: PieChartData) {
        label.text = data.dataSets.first?.label
        data.setValueFormatter(PercentageValueFormatter())
        pieChart.data = data
        setConstraints()
    }
    
    private func setConstraints() {
        contentView.addSubview(label)
        contentView.addSubview(pieChart)
        let margins = contentView.layoutMarginsGuide
        let padding: CGFloat = 15.0
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            pieChart.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: padding),
            pieChart.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: padding),
            
            label.topAnchor.constraint(equalTo: margins.topAnchor, constant: padding),
            pieChart.topAnchor.constraint(equalTo: label.bottomAnchor, constant: padding),
            pieChart.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: padding)
        ])
    }

}
