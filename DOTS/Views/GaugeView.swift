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

    @Binding var tabSelection: Int
    
    @Binding var selectedTimeRange: Int
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var chartColor: Color
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
            
            if model.firstInputRhr() as Date > NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! && model.firstInputHrv() as Date > NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! {
                
                Button {
                    tabSelection = 2
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Text("Nicht genügend Referenzdaten")
                        .foregroundColor(Color.blue)
                        .font(.title3)
                        .lineLimit(1)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal)
                }
                        

            }
            else {
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
                                                          dataLabels: model.createTimestampsLoad(selectedTimeRange: selectedTimeRange).map({ $0.formatted(date: .numeric, time: .omitted) }), dataPrecisionLength: 0, indicatorPointColor: chartColor, lineColor: chartColor , dotsWidth: 10, hapticFeedback: true)
                LineChartView(lineChartParameters: chartParameters)
                    .frame(width: 350, height: 250)
                Spacer()
                
                    HStack {
                        Text("Heute: ")
                            .bold()
                        
                        if model.createTodayLoad() >= 0.75 {
                            Text("erholt")
                                .foregroundColor(Color.green)
                                .bold()
                        }
                        else if model.createTodayLoad() >= 0.5 {
                            Text("ziemlich erholt")
                                .foregroundColor(Color.init(cgColor: .init(red: 0.8, green: 1, blue: 0, alpha: 1)))
                                .bold()
                        }
                        else if model.createTodayLoad() >= 0.25 {
                            Text("etwas belastet")
                                .foregroundColor(Color.orange)
                                .bold()
                        }
                            else if model.createTodayLoad() < 0.25 {
                            Text("belastet")
                                    .foregroundColor(Color.red)
                                    .bold()
                        }
                        
                    }
                    .padding()
                HStack {
                    Text("Ø 7 Tage : ")
                        .bold()
                    
                    if model.calculateMeanLoad() >= 0.75 {
                        Text("erholt")
                            .foregroundColor(Color.green)
                            .bold()
                    }
                    else if model.calculateMeanLoad() >= 0.5 {
                        Text("ziemlich erholt")
                            .foregroundColor(Color.init(cgColor: .init(red: 0.8, green: 1, blue: 0, alpha: 1)))
                            .bold()
                    }
                    else if model.calculateMeanLoad() >= 0.25 {
                        Text("etwas belastet")
                            .foregroundColor(Color.orange)
                            .bold()
                    }
                        else if model.calculateMeanLoad() < 0.25 {
                        Text("belastet")
                                .foregroundColor(Color.red)
                                .bold()
                    }
                    
                }
                
                

                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("0 - 24:")
                        Text("25 - 49:")
                        Text("50 - 74:")
                        Text("75 - 100: ")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("belastet")
                                .foregroundColor(Color.red)
                        Text("etwas belastet")
                            .foregroundColor(Color.orange)
                        Text("ziemlich erholt")
                            .foregroundColor(Color.init(cgColor: .init(red: 0.8, green: 1, blue: 0, alpha: 1)))
                        Text("erholt")
                            .foregroundColor(Color.green)
                    }
                }

                Spacer()
            }
                
            
        }
        
        
    }
}
