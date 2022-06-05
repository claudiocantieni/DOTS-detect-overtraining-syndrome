//
//  LineChartView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 06.05.22.
//

import SwiftUI
import LineChartView

struct HRChartView: View {
    var data: [Double]
    var timestamps: [Date]
    var height: CGFloat
    var width: CGFloat
    var dotsWidth: CGFloat
    var dataSuffix: String
    var indicatorPointColor: Color
    var lineColor: Color
    var lineSecondColor: Color
//    var data: [Double]
//    var timestamps: [Date]
//    var height: CGFloat
    
    var body: some View {
        
        
        let chartParameters = LineChartParameters(data: data,
                                                  dataTimestamps: timestamps,
                                                  dataLabels: timestamps.map({ $0.formatted(date: .numeric, time: .omitted) }),dataPrecisionLength: 0, dataSuffix:dataSuffix,  indicatorPointColor: indicatorPointColor, lineColor: lineColor, lineSecondColor: lineSecondColor, dotsWidth: dotsWidth, hapticFeedback: true)
        LineChartView(lineChartParameters: chartParameters)
            .frame(width: width, height: height)
        
    }
}

