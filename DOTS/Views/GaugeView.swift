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
    
    @State private var showingPopover = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var chartColor: Color
//    var delta7days: String
    var colorScheme: Color
    
    var PopoverButton: some View {
        Button {
            showingPopover = true
        } label: {
            Image(systemName: "info.circle")
                .foregroundColor(Color(red: 0.14, green: 0.45, blue: 0.73))
                
                
        
        }
        
        .popover(isPresented: $showingPopover) {
            Text("""
                Der Formszustand wird
                wie folgt berechnet...
                Erklärung folgt
                """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
            HStack {
                VStack(alignment: .leading) {
                    Text("0 - 24 % :")
                        .font(.custom("Ubuntu-Regular", size: 16))
                    Text("25 - 49 % :")
                        .font(.custom("Ubuntu-Regular", size: 16))
                    Text("50 - 74 % :")
                        .font(.custom("Ubuntu-Regular", size: 16))
                    Text("75 - 100 % : ")
                        .font(.custom("Ubuntu-Regular", size: 16))
                }
                
                VStack(alignment: .leading) {
                    Text("loaded")
                            .foregroundColor(Color.red)
                            .font(.custom("Ubuntu-Regular", size: 16))
                    Text("slightly loaded")
                        .foregroundColor(Color.orange)
                        .font(.custom("Ubuntu-Regular", size: 16))
                    Text("rather recovered")
                        .foregroundColor(Color.init(cgColor: .init(red: 0.55, green: 0.8, blue: 0.3, alpha: 1)))
                        .font(.custom("Ubuntu-Regular", size: 16))
                    Text("recovered")
                        .foregroundColor(Color.green)
                        .font(.custom("Ubuntu-Regular", size: 16))
                }
            }
        }
    }
    var body: some View {
        VStack {
            
            
            if model.firstInputRhr() as Date > NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! || model.firstInputHrv() as Date > NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! {
                
                Button {
                    tabSelection = 2
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Text("Not enough reference data")
                        .foregroundColor(Color(red: 0.14, green: 0.45, blue: 0.73))
                        .font(.custom("Ubuntu-Regular", size: 18))
                        .lineLimit(1)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal)
                }
                        

            }
            else {
                if #available(iOS 16, *) {
                    GaugeIOS16View(colorScheme: colorScheme, loads: model.loads7, weekLoads: model.weekLoads)
                }
                else {
                    Picker("", selection: $selectedTimeRange)
                    {
                        Text("7 days").tag(7)
                        Text("4 weeks").tag(28)
                        Text("1 year").tag(365)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 40)
                    .padding()
                    
                    
                    
                    let chartParameters = LineChartParameters(data: model.createArrayLoad(selectedTimeRange: selectedTimeRange) ,
                                                              dataTimestamps: model.createTimestampsLoad(selectedTimeRange: selectedTimeRange),
                                                              dataLabels: model.createTimestampsLoad(selectedTimeRange: selectedTimeRange).map({ $0.formatted(date: .numeric, time: .omitted) }), dataPrecisionLength: 0, dataSuffix: " %", indicatorPointColor: chartColor, lineColor: chartColor , dotsWidth: 10, hapticFeedback: true)
                    LineChartView(lineChartParameters: chartParameters)
                        .frame(width: 350, height: 250)
                }
                
                
                
            
                
            }
                
            
        }
        .navigationTitle("Shape")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                PopoverButton
            }
        }
        
    }
}
