//
//  HomeView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 03.04.22.
//

import SwiftUI
import GaugeProgressViewStyle
struct HomeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var model:ContentModel
    
    
    @State var selectedTimeRange: Int = 7

    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack {
                    NavigationLink(
                        destination: {
        
                            HRView(title: "Ruheherzfrequenz", data: model.createArrayRhr(selectedTimeRange: selectedTimeRange), dataSuffix: " bpm", timestamps: model.createTimestampsRhr(selectedTimeRange: selectedTimeRange), selectedTimeRange: selectedTimeRange, indicatorPointColor: Color.red, lineColor: Color.orange, lineSecondColor: Color.red, today: model.createTodayRhr(), av7days: model.calculateMeanRhr())
                            //         HRView(title: "Ruheherzfrequenz", HRData: createArray(), today: "48 bpm", av7days: "49 bpm", delta7days: "+2 bpm")
                        },
                        label: {
                            
                            ZStack {
                                
                                Rectangle()
                                    .colorInvert()
                                    .cornerRadius(20)
                                    .aspectRatio(CGSize(width: 335, height: 220), contentMode: .fit)
                                    .shadow(color: .gray, radius: 5)
                                    .padding(.horizontal, 12)
                                VStack {
                                    Text("Ruheherzfrequenz")
                                        .font(.title)
                                        .bold()
                                        
                                    
                                    HRChartView(data: model.createArrayRhr(selectedTimeRange: 7), timestamps: model.createTimestampsRhr(selectedTimeRange: 7), height: 150, width: 335, dotsWidth: -1, dataSuffix: " bpm", indicatorPointColor: Color.red, lineColor: Color.orange, lineSecondColor: Color.red)
                                    
                                    
                                }
                                //LineChartView(data:48), title: "RHF 7 Tage", form: ChartForm.large, rateValue: 0)
                            }
                            
                        }
                    )
                    
                    NavigationLink(
                        destination: {
                            HRView(title: "Herzfrequenzvariabilität", data: model.createArrayHrv(selectedTimeRange: selectedTimeRange), dataSuffix: " ms", timestamps: model.createTimestampsHrv(selectedTimeRange: selectedTimeRange), selectedTimeRange: selectedTimeRange ,indicatorPointColor: Color.blue, lineColor: Color.cyan, lineSecondColor: Color.blue, today: model.createTodayHrv(), av7days: model.calculateMeanHrv())
                            //         HRView(title: "Ruheherzfrequenz", HRData: createArray(), today: "48 bpm", av7days: "49 bpm", delta7days: "+2 bpm")
                        },
                        label: {
                            
                            ZStack {
                                
                                Rectangle()
                                    .colorInvert()
                                    .cornerRadius(20)
                                    .aspectRatio(CGSize(width: 335, height: 220), contentMode: .fit)
                                    .shadow(color: .gray, radius: 5)
                                    .padding(.horizontal, 12)
                                VStack {
                                    Text("Herzfrequenzvariabilität")
                                        .font(.title)
                                        .bold()
                                    
                                    HRChartView(data: model.createArrayHrv(selectedTimeRange: 7), timestamps: model.createTimestampsHrv(selectedTimeRange: 7), height: 150, width: 335, dotsWidth: -1, dataSuffix: " ms", indicatorPointColor: Color.blue, lineColor: Color.cyan, lineSecondColor: Color.blue)
                                    
                                    
                                }
                                //LineChartView(data:48), title: "RHF 7 Tage", form: ChartForm.large, rateValue: 0)
                            }
                            
                        }
                    )
                    
                    
                    
                        
                    
                    
                    ZStack {
                        
                        Rectangle()
                            .colorInvert()
                            .cornerRadius(20)
                            .aspectRatio(CGSize(width: 335, height: 250), contentMode: .fit)
                            .shadow(color: .gray, radius: 5)
                            .padding(.horizontal, 12)
                        VStack {
                            ProgressView(value: model.calculateLoad()) {
                                Text("Belastungszustand")
                                    .bold()
                            }
                            .progressViewStyle(
                                .gauge(thickness: 25, lowerLabel: {
                                    Text("belastet")
                                }, upperLabel: {
                                    Text("erholt")
                                })
                            )
                            .padding(.top)
                            
                        }
                        VStack {
                            
                            if model.firstInputRhr() as Date >= NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! && model.firstInputHrv() as Date >= NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! {
                                Text("Noch keine Referenzdaten")
                                    .font(.title)
                                    .padding()
                                    
                        }
                            Spacer()
                        
                                
                        }
                        
                        
                    }
                }
                .padding()
                .accentColor(.black)
                .navigationTitle("Home")
            }
        }
        
        
                
    }
        

        
}

    
