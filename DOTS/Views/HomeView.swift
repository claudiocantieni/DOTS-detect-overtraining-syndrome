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
    @FetchRequest(sortDescriptors: []) var hearts1: FetchedResults<Hearts>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)]) var hearts: FetchedResults<Hearts>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)], predicate: NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 0, to: NSDate() as Date)!) as CVarArg, NSDate())) var hearts0: FetchedResults<Hearts>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)], predicate: NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)!) as CVarArg, NSDate())) var hearts7: FetchedResults<Hearts>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)], predicate: NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -28, to: NSDate() as Date)!) as CVarArg, NSDate())) var hearts28: FetchedResults<Hearts>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)], predicate: NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -365, to: NSDate() as Date)!) as CVarArg, NSDate())) var hearts365: FetchedResults<Hearts>
    
    
    @State var isInputViewShowing = false
    @State var selectedTimeRange: Int = 7
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack {
                    NavigationLink(
                        destination: {
        
                            HRView(title: "Herzfrequenz", data: createArrayRhr(selectedTimeRange: selectedTimeRange), dataSuffix: " bpm", timestamps: createTimestamps(selectedTimeRange: selectedTimeRange), selectedTimeRange: $selectedTimeRange, indicatorPointColor: Color.red, lineColor: Color.orange, lineSecondColor: Color.red, today: createTodayRhr(), av7days: calculateMeanRhr())
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
                                    
                                    HRChartView(data: createArrayRhr(selectedTimeRange: 7), timestamps: createTimestamps(selectedTimeRange: 7), height: 150, width: 335, dotsWidth: -1, dataSuffix: " bpm", indicatorPointColor: Color.red, lineColor: Color.orange, lineSecondColor: Color.red)
                                    
                                    
                                }
                                //LineChartView(data:48), title: "RHF 7 Tage", form: ChartForm.large, rateValue: 0)
                            }
                            
                        }
                    )
                    
                    NavigationLink(
                        destination: {
                            HRView(title: "Herzfrequenzvariabilität", data: createArrayHrv(selectedTimeRange: selectedTimeRange), dataSuffix: " ms", timestamps: createTimestamps(selectedTimeRange: selectedTimeRange), selectedTimeRange: $selectedTimeRange ,indicatorPointColor: Color.blue, lineColor: Color.cyan, lineSecondColor: Color.blue, today: createTodayHrv(), av7days: calculateMeanHrv())
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
                                    
                                    HRChartView(data: createArrayHrv(selectedTimeRange: 7), timestamps: createTimestamps(selectedTimeRange: 7), height: 150, width: 335, dotsWidth: -1, dataSuffix: " ms", indicatorPointColor: Color.blue, lineColor: Color.cyan, lineSecondColor: Color.blue)
                                    
                                    
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
        
        
        
        
        
    func createArrayRhr(selectedTimeRange: Int) -> [Double]{
        var hrArray:[Double] = []
        
        if hearts.count >= 1 {
            if selectedTimeRange == 7 {
                for f in hearts7 {
                    if f.rhr != nil {
                        hrArray.append(f.rhr as! Double)
                    }
                }
            }
            else if selectedTimeRange == 28 {
                for f in hearts28 {
                    if f.rhr != nil {
                        hrArray.append(f.rhr as! Double)
                    }
                }
            }
            else if selectedTimeRange == 365 {
                for f in hearts365 {
                    if f.rhr != nil {
                        hrArray.append(f.rhr as! Double)
                    }
                }
            }
        }
        return hrArray
    }
    func createArrayHrv(selectedTimeRange:Int) -> [Double]{
        var hrArray:[Double] = []
        if hearts.count >= 1 {
            if selectedTimeRange == 7 {
                for f in hearts7 {
                    if f.hrv != nil {
                        hrArray.append(f.hrv as! Double)
                    }
                    
                }
            }
            else if selectedTimeRange == 28 {
                for f in hearts28 {
                    if f.hrv != nil {
                        hrArray.append(f.hrv as! Double)
                    }
                }
            }
            else if selectedTimeRange == 365 {
                for f in hearts365 {
                    if f.hrv != nil {
                        hrArray.append(f.hrv as! Double)
                    }
                }
            }
        }
        return hrArray
    }
func createTimestamps(selectedTimeRange: Int) -> [Date]{
        var timestamps:[Date] = []
        if hearts.count >= 1 {
            if selectedTimeRange == 7 {
                for f in hearts7 {
                    timestamps.append(f.timestamp)
                }
            }
            else if selectedTimeRange == 28 {
                for f in hearts28 {
                    timestamps.append(f.timestamp)
                }
            }
            else if selectedTimeRange == 365 {
                for f in hearts365 {
                    timestamps.append(f.timestamp)
                }
            }
        }
        return timestamps
    }
    func createTodayRhr() -> Double {
    var HrToday:Double = 0
        for f in hearts0 {
            if f.rhr != nil {
                HrToday = f.rhr as! Double
            }
        }
        return HrToday
    }
    func createTodayHrv() -> Double {
    var HrToday:Double = 0
        for f in hearts0 {
            if f.hrv != nil {
                HrToday = f.hrv as! Double
            }
        }
        return HrToday
    }
    func calculateMeanRhr() -> Double {
        var array:[Double] = []
        for f in hearts7 {
            if f.rhr != nil {
                array.append(f.rhr as! Double)
            }
        }
        // Calculate sum ot items with reduce function
        let sum = array.reduce(0, { a, b in
            return a + b
        })
        
        let mean = Double(sum) / Double(array.count)
        return Double(mean)
    }
    func calculateMeanHrv() -> Double {
        var array:[Double] = []
        for f in hearts7 {
            if f.hrv != nil {
                array.append(f.hrv as! Double)
            }
        }
        // Calculate sum ot items with reduce function
        let sum = array.reduce(0, { a, b in
            return a + b
        })
        
        let mean = Double(sum) / Double(array.count)
        return Double(mean)
    }
        
}
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            
            HomeView()
        }
    }
    
