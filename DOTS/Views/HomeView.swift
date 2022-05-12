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
    @State var isInputViewShowing = false
    @State var isQuestionnaireViewShowing = false
    @State var selectedTimeRange: Int = 7

    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack {
                    NavigationLink(
                        destination: {
        
                            HRView(title: "Herzfrequenz", data: model.createArrayRhr(selectedTimeRange: selectedTimeRange), dataSuffix: " bpm", timestamps: model.createTimestamps(selectedTimeRange: selectedTimeRange), selectedTimeRange: selectedTimeRange, indicatorPointColor: Color.red, lineColor: Color.orange, lineSecondColor: Color.red, today: model.createTodayRhr(), av7days: model.calculateMeanRhr())
                            //         HRView(title: "Ruheherzfrequenz", HRData: createArray(), today: "48 bpm", av7days: "49 bpm", delta7days: "+2 bpm")
                        },
                        label: {
                            
                            ZStack {
                                
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .aspectRatio(CGSize(width: 335, height: 220), contentMode: .fit)
                                    .shadow(radius: 5)
                                    .padding(.horizontal, 12)
                                VStack {
                                    Text("Ruheherzfrequenz")
                                        .font(.title)
                                        .bold()
                                    
                                    HRChartView(data: model.createArrayRhr(selectedTimeRange: 7), timestamps: model.createTimestamps(selectedTimeRange: 7), height: 150, width: 335, dotsWidth: -1, dataSuffix: " bpm", indicatorPointColor: Color.red, lineColor: Color.orange, lineSecondColor: Color.red)
                                    
                                    
                                }
                                //LineChartView(data:48), title: "RHF 7 Tage", form: ChartForm.large, rateValue: 0)
                            }
                            
                        }
                    )
                    
                    NavigationLink(
                        destination: {
                            HRView(title: "Herzfrequenzvariabilität", data: model.createArrayHrv(selectedTimeRange: selectedTimeRange), dataSuffix: " ms", timestamps: model.createTimestamps(selectedTimeRange: selectedTimeRange), selectedTimeRange: selectedTimeRange ,indicatorPointColor: Color.blue, lineColor: Color.cyan, lineSecondColor: Color.blue, today: model.createTodayHrv(), av7days: model.calculateMeanHrv())
                            //         HRView(title: "Ruheherzfrequenz", HRData: createArray(), today: "48 bpm", av7days: "49 bpm", delta7days: "+2 bpm")
                        },
                        label: {
                            
                            ZStack {
                                
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .aspectRatio(CGSize(width: 335, height: 220), contentMode: .fit)
                                    .shadow(radius: 5)
                                    .padding(.horizontal, 12)
                                VStack {
                                    Text("Herzfrequenzvariabilität")
                                        .font(.title)
                                        .bold()
                                    
                                    HRChartView(data: model.createArrayHrv(selectedTimeRange: 7), timestamps: model.createTimestamps(selectedTimeRange: 7), height: 150, width: 335, dotsWidth: -1, dataSuffix: " ms", indicatorPointColor: Color.blue, lineColor: Color.cyan, lineSecondColor: Color.blue)
                                    
                                    
                                }
                                //LineChartView(data:48), title: "RHF 7 Tage", form: ChartForm.large, rateValue: 0)
                            }
                            
                        }
                    )
                    
                    
                    Button(action: {
                        self.isQuestionnaireViewShowing = true
                    }, label: {
                        ZStack {
                            
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .aspectRatio(CGSize(width: 335, height: 80), contentMode: .fit)
                                .shadow(radius: 5)
                                .padding(.horizontal, 12)
                                
                                Text("Fragebogen")
                                    .font(.largeTitle)
                                    .bold()
                        }
                    })
                        .sheet(isPresented: $isQuestionnaireViewShowing) {
                            
                            QuestionnaireView(isQuestionnaireViewShowing: $isQuestionnaireViewShowing)
                        }
                        .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        self.isInputViewShowing = true
                    }, label: {
                        ZStack {
                            
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .aspectRatio(CGSize(width: 335, height: 80), contentMode: .fit)
                                .shadow(radius: 5)
                                .padding(.horizontal, 12)
                                
                                Text("Eingeben")
                                    .font(.largeTitle)
                                    .bold()
                        }
                    })
                        .sheet(isPresented: $isInputViewShowing) {
                            
                            InputView(isInputViewShowing: $isInputViewShowing, model: model)
                        }
                        .buttonStyle(PlainButtonStyle())

                        
                    
                
                    ZStack {
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .aspectRatio(CGSize(width: 335, height: 250), contentMode: .fit)
                            .shadow(radius: 5)
                            .padding(.horizontal, 12)
                        VStack {
                            ProgressView(value: 0.75) {
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
                    }
                }
                .padding()
                .accentColor(.black)
                .navigationTitle("Home")
            }
        }
        
        
                
    }
        

        
}

    
