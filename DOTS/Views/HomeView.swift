//
//  HomeView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 03.04.22.
//

import SwiftUI
import SwiftUICharts
import GaugeProgressViewStyle
struct HomeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [])
    private var datasets: FetchedResults<Datasets>
    
    //var module:Model
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack {
                    // module.rhrData to be replaced by datasets.rhrData
                    if datasets.rhrData.count > 2 {
                        NavigationLink(
                            destination: {
                                HRView(title: "Ruheherzfrequenz", HRData: datasets.rhrData, today: "48 bpm", av7days: "49 bpm", delta7days: "+2 bpm")
                            },
                            label: {
                            
                                LineChartView(data:  ContentModel.getTimeData(selectedRange: 7, HRData: datasets.rhrData), title: "RHF 7 Tage", form: ChartForm.large, rateValue: 0)
                            }
                        )
                    }
                        
                    NavigationLink(
                        destination: {
                            HRView(title: "Herzfrequenzvariabilität", HRData: datasets.hrvData, today: "166.64 ms", av7days: "203.21 ms", delta7days: "+20 ms")
                        },
                        label: {
                        
                            LineChartView(data:ContentModel.getTimeData(selectedRange: 7, HRData: datasets.hrvData), title: "HRV 7 Tage", form: ChartForm.large, rateValue: 0)
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
                .padding()
                .accentColor(.black)
                    .navigationTitle("Home")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
    
        HomeView()
    }
}
