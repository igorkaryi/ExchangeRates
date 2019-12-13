//
//  ChartView.swift
//  ExchangeRates
//
//  Created by Igor Karyi on 12.12.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import Foundation
import UIKit
import Charts

class ChartView: UIView {
    
    @IBOutlet fileprivate weak var chartView: LineChartView!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

extension ChartView {
    
    func setModel(_ model: History?) {
        let items = model?.rates?.items
        let values: [Double] = items?.compactMap({ $0.first?.value?.rounded(toPlaces: 3) }) ?? []
        let dates: [String] = items?.compactMap({ $0.first?.date ?? "" }) ?? []

        var yValues : [ChartDataEntry] = [ChartDataEntry]()

        for i in 0 ..< values.count {
            yValues.append(ChartDataEntry(x: Double(i + 1), y: values[i]))
        }

        let data = LineChartData()
        
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)

        let line = LineChartDataSet(entries: yValues, label: "\(model?.base ?? "") (\(model?.startAt ?? "")-\(model?.endAt ?? ""))")

        line.lineWidth = 4.0
        line.circleRadius = 2.0
        line.setColor(#colorLiteral(red: 0.5176677108, green: 0.1954577863, blue: 0.3542500138, alpha: 1))
        
        let gradientColors = [#colorLiteral(red: 0.7424456296, green: 0.2792778161, blue: 0.5123409493, alpha: 1).cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations:[CGFloat] = [1.0, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        line.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        line.drawFilledEnabled = true
            
        data.addDataSet(line)

        chartView.data = data

        chartView.legend.textColor = #colorLiteral(red: 0.2006070614, green: 0.2007901967, blue: 0.2006354332, alpha: 1)

        chartView.backgroundColor = #colorLiteral(red: 0.9691373706, green: 0.9698447585, blue: 0.9760435224, alpha: 1)
    }
    
}
