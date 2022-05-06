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
//    @State var selectedTimeRange:Int = 7
//    var HRData:[Float]
//    var today: String
//    var av7days: String
//    var delta7days: String
    
//    var data: [Double]
//    var timestamps: [Date]
//    var height: CGFloat
    var body: some View {
        VStack {
            
            Text(title)
                .font(.largeTitle)
                .bold()
            
//            Picker("", selection: $selectedTimeRange)
//            {
//                Text("7 Tage").tag(HRData.count < 7 ? HRData.count : 7 )
//                Text("4 Wochen").tag(HRData.count < 28 ? HRData.count : 28 )
//                Text("1 Jahr").tag(HRData.count < 365 ? HRData.count : 365 )
//            }
//            .pickerStyle(SegmentedPickerStyle())
//            .padding(.horizontal, 40)
//            .padding()
            
            ZStack {
//                let chartParameters = LineChartParameters(data: data,
//                                                                  dataTimestamps: timestamps,
//                                                                  dataLabels: timestamps.map({ $0.formatted(date: .numeric, time: .standard) }), dotsWidth: 10)
//                        LineChartView(lineChartParameters: chartParameters)
//                            .frame(height: height)
                    
               // LineView(data: ContentModel.getTimeData(selectedRange: selectedTimeRange, HRData: HRData))
                   // .padding(.horizontal)
                
//                VStack {
//                    HStack {
//                        Text("Heute :")
//                            .bold()
//                        Text(today)
//                            .bold()
//                    }
//                    .padding()
//
//                    HStack {
//                        Text("Ø 7 Tage :")
//                            .bold()
//                        Text(av7days)
//                            .bold()
//                    }
//                    .padding()
//
//                    HStack {
//                        Text("∆ letze 7 Tage:")
//                            .bold()
//                        Text(delta7days)
//                            .bold()
//                    }
//                    .padding()
//                }
//                .padding(.top, 200)
            }
        }
    }
}
