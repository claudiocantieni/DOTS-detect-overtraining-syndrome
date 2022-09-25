//
//  HRChartsIOS16HrvView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 21.09.22.
//

import SwiftUI
import Charts



struct HRChartIOS16HrvView: View {
    
    
    
    
    @State var currentTab: Int = 7
    
    var title: String
    @State var hearts: [Hearts]
    //var data: [Double]
    var colorScheme: Color
    
    //var indicatorPointColor: Color
    //var lineColor: Color
    //var lineSecondColor: Color
    //var today: Int
    //var av7days: Double
    
    @EnvironmentObject var model:ContentModel
    
    @State var currentActiveItem: Hearts?
    
    var body: some View {
        if #available(iOS 16, *) {
            
                
                VStack(alignment: .leading, spacing: 12) {
                    Picker("", selection: $currentTab)
                    {
                        Text("7 Tage").tag(7)
                        Text("4 Wochen").tag(28)
                        Text("1 Jahr").tag(365)
                    }
                    .pickerStyle(.segmented)
                    .padding(.leading, 80)
                    
                    
                        
                    if isAnyHrv() == true {
                        let totalValue = hearts.reduce(0.0) { partialResult, item in
                            
                            item.hrv != nil ? item.hrv as! Double + partialResult : partialResult
                            
                        }
                        
                        let nonNilCount = hearts.reduce(0) { count, item in
                            item.hrv != nil ? 1 + count : count
                        }
                        
                        let mean = Double(totalValue) / Double(nonNilCount)
                        let meanRound = Int(round(mean))
                        
                        Text("Ø \(meanRound) ms")
                            .font(.custom("Ubuntu-Medium", size: 26))
                    }
                        
                        
                    
                    
                    Chart(hearts) { item in
                        if item.hrv != nil {
                            LineMark(x: .value("Datum", item.timestamp,unit: .hour),
                                     y: .value("HRV", Int(round(item.hrv as! Double)))
                            )
                            .lineStyle(.init(lineWidth: 3, lineCap: .round, miterLimit: 3))
                            .foregroundStyle(Color(red: 0.14, green: 0.45, blue: 0.73).gradient)
                            .interpolationMethod(.monotone)
                            
                            AreaMark(x: .value("Datum", item.timestamp,unit: .hour),
                                     y: .value("HRV", Int(round(item.hrv as! Double)))
                            )
                            .foregroundStyle(Color(red: 0.14, green: 0.45, blue: 0.73).opacity(0.2).gradient)
                            .interpolationMethod(.monotone)
                            
                            if let currentActiveItem,currentActiveItem.timestamp == item.timestamp{
                                PointMark(x: .value("Datum", currentActiveItem.timestamp, unit: .hour),
                                          y: .value("HRV", Int(round(item.hrv as! Double)))
                                )
                                //.lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2], dashPhase: 5))
                                .foregroundStyle(Color.yellow)
                                .symbolSize(250)
                                .annotation(position: .top){
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("\(Int(currentActiveItem.hrv ?? 152)) ms")
                                            .foregroundColor(.black)
                                            .font(.custom("Ubuntu-Regular", size: 18))
                                        Text("\(currentActiveItem.timestamp.formatted(date: .numeric, time: .omitted))")
                                            .font(.custom("Ubuntu-Regular", size: 12))
                                            .foregroundColor(.black.opacity(0.8))
                                    }
                                    
                                    
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
                    .chartXAxis {
                        if hearts == model.hearts7 {
                            AxisMarks(values: .stride(by: .day)) { value in
                                AxisGridLine()
                                AxisValueLabel(format: .dateTime.day(.defaultDigits).month(.defaultDigits))
                            }
                        }
                        else {
                            AxisMarks() { value in
                                AxisGridLine()
                                AxisValueLabel()
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
                                                if let currentItem = hearts.first(where: { item in
                                                    
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
                    .frame(height: 300)
                }
                .padding()
                .background {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(Color.yellow, lineWidth: 2)
                        Rectangle()
                            .foregroundColor(colorScheme)
                            .cornerRadius(10)
                    }
                    
                        
                }
                
                
                .navigationTitle(title)
                .lineLimit(1)
                .allowsTightening(true)
                .minimumScaleFactor(0.5)
                
            
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            .onAppear(perform: {
                hearts = model.hearts7
            })
            .onChange(of: currentTab) { newValue in
                if newValue == 7 {
                    hearts = model.hearts7
                }
                if newValue == 28 {
                    hearts = model.hearts28
                }
                if newValue == 365 {
                    hearts = model.hearts365
                }
            }
            .navigationBarItems(trailing: NavigationLink(destination: {
                DeleteListHrvView()
            }, label: {
                Image(systemName: "ellipsis.circle")
            }))
        }
        
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
    func isAnyHrv() -> Bool {
        var isHrv = false
        for i in hearts {
            
            if i.hrv != nil {
               isHrv = true
            }
        }
        return isHrv
    }
}
