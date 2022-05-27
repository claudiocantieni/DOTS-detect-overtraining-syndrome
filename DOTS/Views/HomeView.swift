//
//  HomeView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 03.04.22.
//

import SwiftUI
import GaugeProgressViewStyle

class Theme {
    // Wird für den Darkmode benötigt
    static func navigationBarColors(background : UIColor?,
       titleColor : UIColor? = nil, tintColor : UIColor? = nil ){
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = background ?? .clear
        
        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
       
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance

        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
    }
}

struct HomeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var model:ContentModel
    
    @Environment(\.colorScheme) var colorScheme
    // Um Zeitspanne auszuwählen (7d, 28d, 365d)
    @State var selectedTimeRangeHome: Int = 7
    
    @State private var frameWidth: CGFloat = 175
    @State private var frameHeight: CGFloat = 175
    @State private var textSize = CGSize(width: 200, height: 100)
    init(){
        Theme.navigationBarColors(background: .systemYellow, titleColor: .black)
        }
    var body: some View {
        
        
        NavigationView {
            ScrollView {
                LazyVStack {
                    
                    ZStack {
                        
                        Rectangle()
                            .colorInvert()
                            .cornerRadius(20)
                            .aspectRatio(CGSize(width: 335, height: 250), contentMode: .fit)
                            .shadow(color: .gray, radius: 5)
                            
                        // Zeigt den Punkt im Tachometer erst an, wenn die App seit länger als eine Woche benutzt wurde
                        if model.firstInputRhr() as Date > NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! && model.firstInputHrv() as Date > NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! {
                            // Tachometer
                            ProgressView(value: model.calculateLoad()) {
                                Text("Belastungszustand")
                                    .font(.title3)
                                    .lineLimit(1)
                                    .allowsTightening(true)
                                    .minimumScaleFactor(0.5)
                                    .padding(100)
                            }
                            .progressViewStyle(
                                .gauge(thickness: 20, lineWidth: 0)
                            )
                            .padding(.top)
                        }
                        else {
                            ProgressView(value: model.calculateLoad()) {
                                Text("Belastungszustand")
                                    .font(.title3)
                                    .lineLimit(1)
                                    .allowsTightening(true)
                                    .minimumScaleFactor(0.5)
                                    .padding(100)
                            }
                            .progressViewStyle(
                                .gauge(thickness: 20, lineWidth: 6)
                            )
                            .padding(.top)
                        }
                            
                           
                        
                        VStack {
                            
                            
                            Spacer()
                            // Text unter Tachometer
                            HStack {
                                if model.firstInputRhr() as Date > NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! && model.firstInputHrv() as Date > NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! {
                                    Text("Nicht genügend Referenzdaten")
                                        .foregroundColor(Color.blue)
                                        .font(.title3)
                                        .lineLimit(1)
                                        .allowsTightening(true)
                                        .minimumScaleFactor(0.5)
                                        .padding(.horizontal)
                                }
                                else {
                                    if model.calculateLoad() >= 0.75 {
                                        Text("erholt")
                                            .foregroundColor(Color.mint)
                                    }
                                    else if model.calculateLoad() >= 0.5 {
                                        Text("ziemlich erholt")
                                            .foregroundColor(Color.green)
                                    }
                                    else if model.calculateLoad() >= 0.25 {
                                        Text("etwas belastet")
                                            .foregroundColor(Color.orange)
                                    }
                                        else if model.calculateLoad() < 0.25 {
                                        Text("belastet")
                                                .foregroundColor(Color.red)
                                    }
                                }
                                
                            }
                            .padding()
                                
                        }
                        
                        
                    }
                    // Ruheherzfrequenzfeld
                    NavigationLink(
                        destination: {
                            // Ansicht wenn auf Feld getippt wird
                            HRView(title: "Ruheherzfrequenz", data: model.createArrayRhr(selectedTimeRange: selectedTimeRangeHome), dataSuffix: " bpm", timestamps: model.createTimestampsRhr(selectedTimeRange: selectedTimeRangeHome), selectedTimeRange: $selectedTimeRangeHome, indicatorPointColor: Color.red, lineColor: Color.orange, lineSecondColor: Color.red, today: model.createTodayRhr(), av7days: model.calculateMeanRhr())
                                .onDisappear{
                                selectedTimeRangeHome = 7
                                }
                                
                                
                                
                            
                        },
                        label: {
                            // Ansicht auf HomeView
                            ZStack {
                                
                                Rectangle()
                                    .foregroundColor(Color(UIColor.systemBackground))
                                    .cornerRadius(20)
                                    .aspectRatio(CGSize(width: 335, height: 220), contentMode: .fit)
                                    .shadow(color: .gray, radius: 5)
                                    
                                VStack {
                                    Text("Ruheherzfrequenz")
                                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                        .font(.title)
                                        .bold()
                                        .lineLimit(1)
                                        .allowsTightening(true)
                                        .minimumScaleFactor(0.5)
                                        .padding()
                                        
                                    
                                    HRChartView(data: model.createArrayRhr(selectedTimeRange: 7), timestamps: model.createTimestampsRhr(selectedTimeRange: 7), height: 150, width: 335, dotsWidth: -1, dataSuffix: " bpm", indicatorPointColor: Color.red, lineColor: Color.orange, lineSecondColor: Color.red)
                                    
                                    
                                }
                                
                            }
                            
                        }
                    )
                    
                    
                    NavigationLink(
                        destination: {
                            HRView(title: "Herzfrequenzvariabilität", data: model.createArrayHrv(selectedTimeRange: selectedTimeRangeHome), dataSuffix: " ms", timestamps: model.createTimestampsHrv(selectedTimeRange: selectedTimeRangeHome), selectedTimeRange: $selectedTimeRangeHome ,indicatorPointColor: Color.blue, lineColor: Color.cyan, lineSecondColor: Color.blue, today: model.createTodayHrv(), av7days: model.calculateMeanHrv())
                                .onDisappear{
                                selectedTimeRangeHome = 7
                                }
                        
                        },
                        label: {
                            
                            ZStack {
                                
                                Rectangle()
                                    .foregroundColor(Color(UIColor.systemBackground))
                                    .cornerRadius(20)
                                    .aspectRatio(CGSize(width: 335, height: 220), contentMode: .fit)
                                    .shadow(color: .gray, radius: 5)
                                    
                                VStack {
                                    Text("Herzfrequenzvariabilität")
                                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                        .font(.title)
                                        .bold()
                                        .lineLimit(1)
                                        .allowsTightening(true)
                                        .minimumScaleFactor(0.5)
                                        .padding()
                                    HRChartView(data: model.createArrayHrv(selectedTimeRange: 7), timestamps: model.createTimestampsHrv(selectedTimeRange: 7), height: 150, width: 335, dotsWidth: -1, dataSuffix: " ms", indicatorPointColor: Color.blue, lineColor: Color.cyan, lineSecondColor: Color.blue)
                                    
                                    
                                }
                                
                            }
                            
                        }
                    )
                    
                    
                    
                        
                    
                    
                    
                }
                .padding()
                .accentColor(.black)
                .navigationTitle("DOTS")
                .navigationBarTitleDisplayMode(.inline)
                
            }
        }
        
        
                
    }
        

        
}

    
