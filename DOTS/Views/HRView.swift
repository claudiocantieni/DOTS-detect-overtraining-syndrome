//
//  HRView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 07.04.22.
//

import SwiftUI
import LineChartView

struct HRView: View {
    
    @Binding var tabSelection: Int
    @Binding var selectedTimeRange: Int
    
    var title: String
    var data: [Double]
    var dataSuffix: String
    var timestamps: [Date]
    var indicatorPointColor: Color
    var lineColor: Color
    var lineSecondColor: Color
    var today: Int
    var av7days: Double
    
    var body: some View {
        
        VStack {
            
            Text(title)
                .font(.custom("Ubuntu-Medium", size: 24))
                .lineLimit(1)
                .allowsTightening(true)
                .minimumScaleFactor(0.5)
                .padding()

            Picker("", selection: $selectedTimeRange)
            {
                Text("7 days").tag(7)
                Text("4 weeks").tag(28)
                Text("1 year").tag(365)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 40)
            .padding()
            
            HRChartView(data: data, timestamps: timestamps, height: 250, width: 350, dotsWidth: 10, dataSuffix: dataSuffix, indicatorPointColor: indicatorPointColor, lineColor: lineColor, lineSecondColor: lineSecondColor)
                    
            HStack {
                Text("Today :")
                    .font(.custom("Ubuntu-Regular", size: 18))
                Text(today>0 ? String(today)+String(dataSuffix): "-")
                    .font(.custom("Ubuntu-Regular", size: 18))
            }
            .padding()

            HStack {
                Text("Ø 7 days :")
                    .font(.custom("Ubuntu-Regular", size: 18))
                Text(String(av7days)+String(dataSuffix))
                    .font(.custom("Ubuntu-Regular", size: 18))
            }
            .padding()
            
//            Button {
//                tabSelection = 2
//            } label: {
//
//                    HStack {
//                        Image(systemName: "plus")
//                        Text("\(title) eingeben")
//                            .foregroundColor(Color.blue)
//                            .font(.title3)
//                            .lineLimit(1)
//                            .allowsTightening(true)
//                            .minimumScaleFactor(0.5)
//                            .padding(.horizontal)
//                }
//            }
            .frame(alignment: .center)
            .padding()
            Spacer()
        }
    }
}






