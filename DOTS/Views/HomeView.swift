//
//  HomeView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 03.04.22.
//

import SwiftUI
import SwiftUICharts

struct HomeView: View {
    var HRData: [Double] = [48, 50, 52, 51, 49, 50, 48]
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack {
                    
                    NavigationLink(
                        destination: {
                        HRView()
                        },
                        label: {
                        
                            LineChartView(data: HRData, title: "RHF 7 Tage", form: ChartForm.extraLarge, rateValue: 0)
                        }
                    )
                        LineChartView(data: HRData, title: "HRV 7 Tage", form: ChartForm.large, rateValue: 0)
                        
                    ZStack {
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .aspectRatio(CGSize(width: 335, height: 80), contentMode: .fit)
                            .shadow(radius: 5)
                        VStack {
                            
                            Text("EBF")
                                .font(.largeTitle)
                                .bold()
                        }
                    }
                    ZStack {
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .aspectRatio(CGSize(width: 335, height: 100), contentMode: .fit)
                            .shadow(radius: 5)
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
        HomeView()
    }
}
