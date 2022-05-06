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
//    var data: [Double]
//    var timestamps: [Date]
//    var height: CGFloat
    
    var body: some View {
        
        
        let chartParameters = LineChartParameters(data: data,
                                                  dataTimestamps: timestamps,
                                                  dataLabels: timestamps.map({ $0.formatted(date: .numeric, time: .omitted) }), dotsWidth: 10)
        LineChartView(lineChartParameters: chartParameters)
            .frame(width: width, height: height)
        
    }
}

