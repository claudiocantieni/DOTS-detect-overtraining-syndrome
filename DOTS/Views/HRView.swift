//
//  HRView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 07.04.22.
//

import SwiftUI
import SwiftUICharts
import LineChartView

struct HRView: View {
    
    
    var title: String
    
    var data: [Double]
    var dataSuffix: String
    var timestamps: [Date]
    @Binding var selectedTimeRange: Int
    var indicatorPointColor: Color
    var lineColor: Color
    var lineSecondColor: Color
    var today: Double
    var av7days: Double
//    var delta7days: String
    
    var body: some View {
        VStack {

            Picker("", selection: $selectedTimeRange)
            {
                Text("7 Tage").tag(7)
                Text("4 Wochen").tag(28)
                Text("1 Jahr").tag(365)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 40)
            .padding()
            
            
            HRChartView(data: data, timestamps: timestamps, height: 250, width: 350, dotsWidth: 10, dataSuffix: dataSuffix, indicatorPointColor: indicatorPointColor, lineColor: lineColor, lineSecondColor: lineSecondColor)
                    
               // LineView(data: ContentModel.getTimeData(selectedRange: selectedTimeRange, HRData: HRData))
                   // .padding(.horizontal)
                
                
            HStack {
                Text("Heute :")
                    .bold()
                Text(today>0 ? String(today)+String(dataSuffix): "-")
                    .bold()
            }
            .padding()

            HStack {
                Text("Ø 7 Tage :")
                    .bold()
                Text(String(av7days)+String(dataSuffix))
                    .bold()
            }
            .padding()

//                    HStack {
//                        Text("∆ letze 7 Tage:")
//                            .bold()
//                        Text(delta7days)
//                            .bold()
//                    }
//                    .padding()
                
                
            
            Spacer()
        }
        .navigationTitle(title)
    }
}
