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
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)]) var hearts: FetchedResults<Hearts>
    
    @State var isInputViewShowing = false
    //  var module:Model
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack {
                    // module.rhrData to be replaced by datasets.rhrData
                    NavigationLink(
                        destination: {
                            HRChartView(data: createArrayRhr(), timestamps: createTimestamps(), height: 250, width: 350)
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
                                        .font(.largeTitle)
                                        .bold()
                                    
                                    HRChartView(data: createArrayRhr(), timestamps: createTimestamps(), height: 150, width: 335)
                                    
                                    
                                }
                                //LineChartView(data:48), title: "RHF 7 Tage", form: ChartForm.large, rateValue: 0)
                            }
                            
                        }
                    )
                    
                    
                    NavigationLink(
                        destination: {
                            HRChartView(data: createArrayHrv(), timestamps: createTimestamps(), height: 250, width: 350)
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
                                        .font(.largeTitle)
                                        .bold()
                                    
                                    HRChartView(data: createArrayHrv(), timestamps: createTimestamps(), height: 150, width: 335)
                                    
                                    
                                }
                                //LineChartView(data:48), title: "RHF 7 Tage", form: ChartForm.large, rateValue: 0)
                            }
                            
                        }
                    )
                    
                    ZStack {
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .aspectRatio(CGSize(width: 335, height: 80), contentMode: .fit)
                            .shadow(radius: 5)
                            .padding(.horizontal, 12)
                        VStack {
                            
                            Text("EBF")
                                .font(.largeTitle)
                                .bold()
                        }
                    }
                    
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
                            
                            InputView()
                        }
                        .buttonStyle(PlainButtonStyle())

                        
                    }
                    ZStack {
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .aspectRatio(CGSize(width: 335, height: 250), contentMode: .fit)
                            .shadow(radius: 5)
                            .padding(.horizontal, 12)
                        VStack {
                            ProgressView(value: 0.75) {
                                Text("Form-Zustand")
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
            }
                .padding()
                .accentColor(.black)
                .navigationTitle("Home")
    }
        
        
        
        
        
        func createArrayRhr() -> [Double]{
            var hrArray:[Double] = []
            if hearts.count >= 1 {
                for f in hearts {
                    hrArray.append(f.rhr)
                }
            }
            return hrArray
        }
        func createArrayHrv() -> [Double]{
            var hrArray:[Double] = []
            if hearts.count >= 1 {
                for f in hearts {
                    hrArray.append(f.hrv)
                }
            }
            return hrArray
        }
        func createTimestamps() -> [Date]{
            var timestamps:[Date] = []
            if hearts.count >= 1 {
                for t in hearts {
                    timestamps.append(t.timestamp)
                }
            
            }
            return timestamps
        }
        
    }
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            
            HomeView()
        }
    }
    
