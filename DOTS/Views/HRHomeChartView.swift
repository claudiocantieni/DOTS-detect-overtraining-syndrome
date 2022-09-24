//
//  HRHomeChartView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 22.09.22.
//
/*
import SwiftUI
import Charts



struct HRHomeChartView: View {
    
    
    //var data: [Double]
    
    
    //var indicatorPointColor: Color
    //var lineColor: Color
    //var lineSecondColor: Color
    //var today: Int
    //var av7days: Double
    
    @EnvironmentObject var model:ContentModel
    
    @State var currentActiveItem: Hearts?
    
    var body: some View {
        
                
                    
        Chart(model.hearts7) { item in
                        if item.rhr != nil {
                            
                                LineMark(x: .value("Datum", item.timestamp,unit: .day),
                                         y: .value("Ruhe-HF", Int(round(item.rhr as! Double)))
                                )
                                .lineStyle(.init(lineWidth: 3, lineCap: .round, miterLimit: 3))
                                .foregroundStyle(Color(red: 0.14, green: 0.45, blue: 0.73).gradient)
                                .interpolationMethod(.monotone)
                                
                                 
                            
                        }
            if let currentActiveItem,currentActiveItem.timestamp == item.timestamp{
                if item.rhr != nil {
                    PointMark(x: .value("Datum", currentActiveItem.timestamp, unit: .day),
                              y: .value("Ruhe-HF", Int(round(item.rhr as! Double))))
                    .symbolSize(100)
                    .foregroundStyle(Color.yellow)
                    
                    
                    .annotation(position: .top){
                        VStack(alignment: .leading, spacing: 6) {
                            Text("\(Int(currentActiveItem.rhr!)) bpm")
                            //Text("\(currentActiveItem.timestamp)")
                        }
                        .font(.custom("Ubuntu-Regular", size: 18))
                        .foregroundColor(.black)
                        .padding(.horizontal,10)
                        .padding(.vertical, 4)
                        .background {
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(.yellow.shadow(.drop(radius:2)))
                        }
                        
                    }
                }
            }
                    }
                    .chartOverlay(content: { proxy in
                        GeometryReader{innerProxy in
                            Rectangle()
                                .fill(.clear).contentShape(Rectangle())
                                .gesture(
                                    DragGesture()
                                        .onChanged{ value in
                                            let location = value.location
                                            
                                            if let date: Date = proxy.value(atX: location.x){
                                                let calendar = Calendar.current
                                                let day = calendar.component(.day, from: date)
                                                if let currentItem = model.hearts7.first(where: { item in
                                                    calendar.component(.day, from: item.timestamp) == day
                                                }){
                                                    self.currentActiveItem = currentItem
                                                }
                                            }
                                        }.onEnded{value in
                                            self.currentActiveItem = nil
                                        }
                                )
                        }
                    })
                    .frame(width: 320, height: 130)
                
                .padding()
                
                
                
                 
                
            
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            
            
        
        
        /*
        HStack {
            Text("Heute :")
                .font(.custom("Ubuntu-Regular", size: 18))
            Text(today>0 ? String(today)+String(dataSuffix): "-")
                .font(.custom("Ubuntu-Regular", size: 18))
        }
        .padding()

        HStack {
            Text("Ø 7 Tage :")
                .font(.custom("Ubuntu-Regular", size: 18))
            Text(String(av7days)+String(dataSuffix))
                .font(.custom("Ubuntu-Regular", size: 18))
        }
        .padding()
         */
    }
}
*/
