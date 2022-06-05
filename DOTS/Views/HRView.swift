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
    
    var title: String
    
    var data: [Double]
    var dataSuffix: String
    var timestamps: [Date]
    @Binding var selectedTimeRange: Int
    var indicatorPointColor: Color
    var lineColor: Color
    var lineSecondColor: Color
    var today: Int
    var av7days: Double
//    var delta7days: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .bold()
                .lineLimit(1)
                .allowsTightening(true)
                .minimumScaleFactor(0.5)
                .padding()

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
                
                
            
            
            
            
            
            Button {
                tabSelection = 2
            } label: {
                
                    HStack {
                        Image(systemName: "plus")
                        Text("\(title) eingeben")
                            .foregroundColor(Color.blue)
                            .font(.title3)
                            .lineLimit(1)
                            .allowsTightening(true)
                            .minimumScaleFactor(0.5)
                            .padding(.horizontal)
                    
                }
                
            }
            .frame(alignment: .center)
            .padding()
            Spacer()

        }
        
        
    }
}
