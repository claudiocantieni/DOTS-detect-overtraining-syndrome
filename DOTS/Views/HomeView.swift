//
//  HomeView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 03.04.22.
//

import SwiftUI
import SwiftUICharts

struct HomeView: View {
    
    var module:Model
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack {
                    
                    NavigationLink(
                        destination: {
                            HRView(title: "Ruheherzfrequenz", HRData: module.RHRData, today: "48 bpm", av7days: "49 bpm", delta7days: "+2 bpm")
                        },
                        label: {
                        
                            LineChartView(data:  ContentModel.getTimeData(selectedRange: 7, HRData: module.RHRData), title: "RHF 7 Tage", form: ChartForm.large, rateValue: 0)
                        }
                    )
                    NavigationLink(
                        destination: {
                            HRView(title: "Herzfrequenzvariabilität", HRData: module.HRVData, today: "166.64 ms", av7days: "203.21 ms", delta7days: "+20 ms")
                        },
                        label: {
                        
                            LineChartView(data:ContentModel.getTimeData(selectedRange: 7, HRData: module.HRVData), title: "HRV 7 Tage", form: ChartForm.large, rateValue: 0)
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
                            .aspectRatio(CGSize(width: 335, height: 100), contentMode: .fit)
                            .shadow(radius: 5)
                            .padding(.horizontal, 12)
                        VStack {
                            Image("tacho")
                                .resizable()
                                .frame(width: 172, height: 65, alignment: .top)
                                
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
    
        HomeView(module: Model())
    }
}
