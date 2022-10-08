//
//  GaugeIOS16View.swift
//  DOTS
//
//  Created by Claudio Cantieni on 21.09.22.
//

import SwiftUI

import SwiftUI
import Charts



struct GaugeIOS16View: View {
    
    var colorScheme: Color
    
    
    @State var currentTab: Int = 7
    
    
    @State var loads: [Loads]
    //var data: [Double]
    @State var weekLoads: [WeekLoads]
    
    //var indicatorPointColor: Color
    //var lineColor: Color
    //var lineSecondColor: Color
    //var today: Int
    //var av7days: Double
    
    @EnvironmentObject var model:ContentModel
    
    @State var currentActiveItem: Loads?
    @State var currentActiveItem2: WeekLoads?
    var body: some View {
        if #available(iOS 16, *) {
            VStack(alignment: .leading) {
                if currentTab == 28 || currentTab == 7 {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            if model.calculateMeanLoad14() < 0.2 || model.calculateMeanLoad28() < 0.4 {
                                AttentionPopoverView()
                            }
                            
                            
                            Picker("", selection: $currentTab)
                            {
                                Text("7 days").tag(7)
                                Text("4 weeks").tag(28)
                                Text("1 year").tag(365)
                            }
                            .pickerStyle(.segmented)
                            .padding(.leading, 80)
                            
                        }
                        
                        let totalValue = loads.reduce(0.0) { partialResult, item in
                            
                            item.load*100 + partialResult
                            
                        }
                        
                        let nonNilCount = loads.reduce(0) { count, item in
                            1 + count
                        }
                        
                        let mean = Double(totalValue) / Double(nonNilCount)
                        let meanRound = Int(round(mean))
                        HStack() {
                            VStack(alignment: .leading) {
                                Text("Ø \(meanRound) %")
                                    .font(.custom("Ubuntu-Medium", size: 26))
                                if meanRound >= 75 {
                                    Text("recovered")
                                        .foregroundColor(Color.green)
                                        .font(.custom("Ubuntu-Regular", size: 18))
                                }
                                else if meanRound >= 50 {
                                    Text("rather recovered")
                                        .foregroundColor(Color.init(cgColor: .init(red: 0.55, green: 0.8, blue: 0.3, alpha: 1)))
                                        .font(.custom("Ubuntu-Regular", size: 18))
                                }
                                else if meanRound >= 25 {
                                    Text("slightly loaded")
                                        .foregroundColor(Color.orange)
                                        .font(.custom("Ubuntu-Regular", size: 18))
                                }
                                else if meanRound < 25 {
                                    Text("loaded")
                                        .foregroundColor(Color.red)
                                        .font(.custom("Ubuntu-Regular", size: 18))
                                }
                            }
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Today")
                                    .font(.custom("Ubuntu-Medium", size: 26))
                                if  model.createTodayLoad() >= 0.75 {
                                    Text("recovered")
                                        .foregroundColor(Color.green)
                                        .font(.custom("Ubuntu-Regular", size: 18))
                                }
                                else if model.createTodayLoad() >= 0.50 {
                                    Text("rather recovered")
                                        .foregroundColor(Color.init(cgColor: .init(red: 0.55, green: 0.8, blue: 0.3, alpha: 1)))
                                        .font(.custom("Ubuntu-Regular", size: 18))
                                }
                                else if model.createTodayLoad() >= 0.25 {
                                    Text("slightly loaded")
                                        .foregroundColor(Color.orange)
                                        .font(.custom("Ubuntu-Regular", size: 18))
                                }
                                else if model.createTodayLoad() < 0.25 {
                                    Text("loaded")
                                        .foregroundColor(Color.red)
                                        .font(.custom("Ubuntu-Regular", size: 18))
                                }
                            }
                            .padding(.trailing)
                            
                        }
                        
                        
                        
                        
                        Chart(loads) { item in
                            
                            LineMark(x: .value("Date", item.timestamp,unit: .hour),
                                     y: .value("Stare", Int(round(item.load*100)))
                            )
                            .lineStyle(.init(lineWidth: 3, lineCap: .round, miterLimit: 3))
                            .foregroundStyle(Color(red: 0.14, green: 0.45, blue: 0.73))
                            .interpolationMethod(.monotone)
                            
                            AreaMark(x: .value("Date", item.timestamp,unit: .hour),
                                     y: .value("State", Int(round(item.load*100)))
                            )
                            .foregroundStyle(.linearGradient(colors: [
                                Color(red: 0.14, green: 0.45, blue: 0.73).opacity(0.6),
                                Color(red: 0.14, green: 0.45, blue: 0.73).opacity(0.5),
                                Color(red: 0.14, green: 0.45, blue: 0.73).opacity(0.3),
                                Color(red: 0.14, green: 0.45, blue: 0.73).opacity(0.1),
                                .clear
                            ], startPoint: .top, endPoint: .bottom))
                                                            
                            .interpolationMethod(.monotone)
                            
                            if let currentActiveItem,currentActiveItem.timestamp == item.timestamp{
                                PointMark(x: .value("Date", currentActiveItem.timestamp, unit: .hour),
                                          y: .value("State", Int(round(item.load*100)))
                                )
                                .foregroundStyle(Color.yellow)
                                .symbolSize(250)
                                //.lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2], dashPhase: 5))
                                
                                
                                .annotation(position: .top){
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("\(Int(currentActiveItem.load*100)) %")
                                            .foregroundColor(.black)
                                            .font(.custom("Ubuntu-Regular", size: 18))
                                        Text("\(currentActiveItem.timestamp, format: Date.FormatStyle().year(.twoDigits).month(.defaultDigits).day().weekday())")
                                            .font(.custom("Ubuntu-Regular", size: 12))
                                            .foregroundColor(.black.opacity(0.8))
                                    }
                                    .padding(.horizontal,5)
                                    .padding(.vertical, 4)
                                    .background {
                                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                                            .fill(.yellow.shadow(.drop(radius:2)))
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        .chartXAxis {
                            if loads == model.loads7 {
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
                        .chartYScale(domain: 0...100)
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
                                                    if let currentItem = loads.first(where: { item in
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
                }
                else {
                    VStack(alignment: .leading, spacing: 12) {
                        Picker("", selection: $currentTab)
                        {
                            Text("7 days").tag(7)
                            Text("4 weeks").tag(28)
                            Text("1 year").tag(365)
                        }
                        .pickerStyle(.segmented)
                        .padding(.leading, 80)
                        
                        
                        let totalValue = weekLoads.reduce(0.0) { partialResult, item in
                            
                            item.load*100 + partialResult
                            
                        }
                        
                        let nonNilCount = weekLoads.reduce(0) { count, item in
                            1 + count
                        }
                        
                        let mean = Double(totalValue) / Double(nonNilCount)
                        let meanRound = Int(round(mean))
                        HStack() {
                            VStack(alignment: .leading) {
                                Text("Ø \(meanRound) %")
                                    .font(.custom("Ubuntu-Medium", size: 26))
                                if meanRound >= 75 {
                                    Text("recovered")
                                        .foregroundColor(Color.green)
                                        .font(.custom("Ubuntu-Regular", size: 18))
                                }
                                else if meanRound >= 50 {
                                    Text("rather recovered")
                                        .foregroundColor(Color.init(cgColor: .init(red: 0.55, green: 0.8, blue: 0.3, alpha: 1)))
                                        .font(.custom("Ubuntu-Regular", size: 18))
                                }
                                else if meanRound >= 25 {
                                    Text("slightly loaded")
                                        .foregroundColor(Color.orange)
                                        .font(.custom("Ubuntu-Regular", size: 18))
                                }
                                else if meanRound < 25 {
                                    Text("loaded")
                                        .foregroundColor(Color.red)
                                        .font(.custom("Ubuntu-Regular", size: 18))
                                }
                            }
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Today")
                                    .font(.custom("Ubuntu-Medium", size: 26))
                                if  model.createTodayLoad() >= 0.75 {
                                    Text("recovered")
                                        .foregroundColor(Color.green)
                                        .font(.custom("Ubuntu-Regular", size: 18))
                                }
                                else if model.createTodayLoad() >= 0.50 {
                                    Text("rather recovered")
                                        .foregroundColor(Color.init(cgColor: .init(red: 0.55, green: 0.8, blue: 0.3, alpha: 1)))
                                        .font(.custom("Ubuntu-Regular", size: 18))
                                }
                                else if model.createTodayLoad() >= 0.25 {
                                    Text("slightly loaded")
                                        .foregroundColor(Color.orange)
                                        .font(.custom("Ubuntu-Regular", size: 18))
                                }
                                else if model.createTodayLoad() < 0.25 {
                                    Text("loaded")
                                        .foregroundColor(Color.red)
                                        .font(.custom("Ubuntu-Regular", size: 18))
                                }
                            }
                            .padding(.trailing)
                            
                        }
                        
                       
                        
                        
                        Chart(weekLoads) { item in
                            
                            LineMark(x: .value("Date", item.timestamp,unit: .hour),
                                     y: .value("Stare", Int(round(item.load*100)))
                            )
                            .lineStyle(.init(lineWidth: 3, lineCap: .round, miterLimit: 3))
                            .foregroundStyle(Color(red: 0.14, green: 0.45, blue: 0.73))
                            .interpolationMethod(.monotone)
                            
                            AreaMark(x: .value("Date", item.timestamp,unit: .hour),
                                     y: .value("State", Int(round(item.load*100)))
                            )
                            .foregroundStyle(.linearGradient(colors: [
                                Color(red: 0.14, green: 0.45, blue: 0.73).opacity(0.6),
                                Color(red: 0.14, green: 0.45, blue: 0.73).opacity(0.5),
                                Color(red: 0.14, green: 0.45, blue: 0.73).opacity(0.3),
                                Color(red: 0.14, green: 0.45, blue: 0.73).opacity(0.1),
                                .clear
                            ], startPoint: .top, endPoint: .bottom))
                            .interpolationMethod(.monotone)
                            
                            
                            if let currentActiveItem2,currentActiveItem2.timestamp == item.timestamp{
                                PointMark(x: .value("Date", currentActiveItem2.timestamp, unit: .hour),
                                          y: .value("State", Int(round(item.load*100)))
                                )
                                .foregroundStyle(Color.yellow)
                                .symbolSize(250)
                                //.lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2], dashPhase: 5))
                                
                                
                                .annotation(position: .top){
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("\(Int(currentActiveItem2.load*100)) %")
                                            .foregroundColor(.black)
                                            .font(.custom("Ubuntu-Regular", size: 18))
                                        VStack() {
                                            Text("\(NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -6, to: currentActiveItem2.timestamp)!), format: Date.FormatStyle().year(.twoDigits).month(.defaultDigits) .day()) -")
                                            Text("\(currentActiveItem2.timestamp, format: Date.FormatStyle().year(.twoDigits).month(.defaultDigits).day())")
                                        }
                                        
                                            .font(.custom("Ubuntu-Regular", size: 12))
                                            .foregroundColor(.black.opacity(0.8))
                                    }
                                    .padding(.horizontal,5)
                                    .padding(.vertical, 4)
                                    .background {
                                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                                            .fill(.yellow.shadow(.drop(radius:2)))
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                        .chartYScale(domain: 0...100)
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
                                                    let day = calendar.component(.weekOfYear, from: date)
                                                    if let currentItem2 = weekLoads.first(where: { item in
                                                        calendar.component(.weekOfYear, from: item.timestamp) == day
                                                    }){
                                                        self.currentActiveItem2 = currentItem2
                                                        
                                                    }
                                                }
                                            }.onEnded{value in
                                                self.currentActiveItem2 = nil
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
                }
                
                
                
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            .onAppear(perform: {
                loads = model.loads7
            })
            .onChange(of: currentTab) { newValue in
                if newValue == 7 {
                    loads = model.loads7
                }
                if newValue == 28 {
                    loads = model.loads28
                }
                if newValue == 365 {
                    weekLoads = model.weekLoads
                }
            }
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
}
