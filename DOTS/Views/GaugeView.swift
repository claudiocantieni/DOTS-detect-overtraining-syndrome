//
//  GaugeView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 29.05.22.
//

import SwiftUI
import LineChartView

struct GaugeView: View {
    
    @EnvironmentObject var model:ContentModel

    
    @Binding var selectedTimeRange: Int
    
//    var delta7days: String
    
    var body: some View {
        VStack {
            Text("Belastungszustand")
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
            
            
            let chartParameters = LineChartParameters(data: model.createArrayLoad(selectedTimeRange: selectedTimeRange) ,
                                                      dataTimestamps: model.createTimestampsLoad(selectedTimeRange: selectedTimeRange),
                                                      dataLabels: model.createTimestampsLoad(selectedTimeRange: selectedTimeRange).map({ $0.formatted(date: .numeric, time: .omitted) }),  indicatorPointColor: .black, lineColor: .black, dotsWidth: 10, hapticFeedback: true)
            LineChartView(lineChartParameters: chartParameters)
                .frame(width: 350, height: 250)
                    

            Spacer()
                
            
        }
        
        
    }
}
