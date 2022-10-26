//
//  HomeViewTest.swift
//  DOTS
//
//  Created by Claudio Cantieni on 03.04.22.
//
import SwiftUI
import GaugeProgressViewStyle

//class Theme {
//    // Wird für den Darkmode benötigt
//    static func navigationBarColors(background : UIColor?,
//                                    titleColor : UIColor? = nil, tintColor : UIColor? = nil, font: Font){
//
//        let navigationAppearance = UINavigationBarAppearance()
//        navigationAppearance.configureWithOpaqueBackground()
//        navigationAppearance.backgroundColor = background ?? .clear
//
//        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
//        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
//
////        navigationAppearance.backButtonAppearance = [.font : UIFont(name: "Ubuntu-Medium", size: 18)!]
////        navigationAppearance.backButtonAppearance = [.text : Text("Zurück")]
//        UINavigationBar.appearance().standardAppearance = navigationAppearance
//        UINavigationBar.appearance().compactAppearance = navigationAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
//
//        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
//    }
//}
struct HomeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var model:ContentModel
    
    @Environment(\.scenePhase) var scenePhase
    
    @Environment(\.colorScheme) var colorScheme
    // Um Zeitspanne auszuwählen (7d, 28d, 365d)
    @State var selectedTimeRangeHome: Int = 7
    
    @Binding var tabSelection: Int
    
    @State private var frameWidth: CGFloat = 175
    @State private var frameHeight: CGFloat = 175
    @State private var textSize = CGSize(width: 200, height: 100)
    
    init(tabSelection: Binding<Int>) {
        self._tabSelection = tabSelection
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor.systemYellow
        navBarAppearance.titleTextAttributes = [.font: UIFont(name: "Ubuntu-Bold", size: 24)!, .foregroundColor: UIColor.black]
        navBarAppearance.buttonAppearance.normal.titleTextAttributes = [.font: UIFont(name: "Ubuntu-Regular", size: 18)!]
//        let barButton = UIBarItem()
//        barButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Ubuntu-Medium", size: 18)!], for: .normal)
 
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    
        }

    
    
    var body: some View {
        
        
        NavigationView {
            ZStack {
                colorScheme == .dark ? Color.black : Color(red: 0.89, green: 0.89, blue: 0.89)
                    
                ScrollView {
                    LazyVStack(spacing: 13) {


                        NavigationLink(
                            destination: {
                                // Ansicht wenn auf Feld getippt wird
                                GaugeView(tabSelection: $tabSelection, selectedTimeRange: $selectedTimeRangeHome, chartColor: Color(red: 0.14, green: 0.45, blue: 0.73), colorScheme: colorScheme == .dark ? Color(red: 0.25, green: 0.25, blue: 0.25) : Color.white)
                                    .onDisappear{
                                    selectedTimeRangeHome = 7
                                    }
                                    
                                    
                                
                            },
                            label: {
                                // Ansicht auf HomeView
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(colorScheme == .dark ? Color(red: 0.25, green: 0.25, blue: 0.25) : Color.white)
                                        .cornerRadius(10)
                                        .aspectRatio(CGSize(width: 335, height: 250), contentMode: .fit)
                                        
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.yellow, lineWidth: 2)
                                        .aspectRatio(CGSize(width: 335, height: 250), contentMode: .fit)
                                        
                                        
                                        
                                    // Zeigt den Punkt im Tachometer erst an, wenn die App seit länger als eine Woche benutzt wurde
                                    if model.firstInputRhr() as Date > NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! || model.firstInputHrv() as Date > NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! {
                                        // Tachometer
                                        ProgressView(value: model.createTodayLoad()) {
                                            Text("Shape")
                                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                                .font(.custom("Ubuntu-Regular", size: 22))
                                                .lineLimit(1)
                                                .allowsTightening(true)
                                                .minimumScaleFactor(0.5)
                                                .padding(100)
                                        }
                                        .progressViewStyle(
                                            .gauge(thickness: 20, lineWidth: 0, color: colorScheme == .dark ? Color(red: 0.25, green: 0.25, blue: 0.25) : Color.white)
                                        )
                                        .padding(.top)
                                    }
                                    else {
                                        ProgressView(value: model.createTodayLoad()) {
                                            HStack(spacing: 10) {
                                                
                                                
                                                Text("Shape")
                                                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                                    .font(.custom("Ubuntu-Regular", size: 22))
                                                    .lineLimit(1)
                                                    .allowsTightening(true)
                                                    .minimumScaleFactor(0.5)
                                                if model.calculateMeanLoad14() < 0.2 || model.calculateMeanLoad28() < 0.4 {
                                                    Image(systemName: "exclamationmark.triangle")
                                                        .foregroundColor(Color.red)
                                                        .font(.system(size: 27))
                                                }
                                            }
                                        }
                                        .progressViewStyle(
                                            .gauge(thickness: 20, lineWidth: 8, color: colorScheme == .dark ? Color(red: 0.25, green: 0.25, blue: 0.25) : Color.white)
                                        )
                                        .padding(.top)
                                    }
                                        
                                    
                                    
                                    VStack {
                                        
                                        
                                        Spacer()
                                        // Text unter Tachometer
                                        HStack {
                                            if model.firstInputRhr() as Date > NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! || model.firstInputHrv() as Date > NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! {
                                                Button {
                                                    tabSelection = 2
                                                } label: {
                                                    Text("Not enough reference data")
                                                        .foregroundColor(Color(red: 0.14, green: 0.45, blue: 0.73))
                                                        .font(.custom("Ubuntu-Regular", size: 16))
                                                        .lineLimit(1)
                                                        .allowsTightening(true)
                                                        .minimumScaleFactor(0.5)
                                                        .padding(.horizontal)
                                                }

                                                
                                            }
                                            else {
                                                if model.createTodayLoad() >= 0.75 {
                                                    Text("recovered")
                                                        .foregroundColor(Color.green)
                                                        .font(.custom("Ubuntu-Regular", size: 18))
                                                }
                                                else if model.createTodayLoad() >= 0.5 {
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
                                                
                                            
                                        }
                                        .padding()
                                            
                                    }
                                    
                                    
                                }
                                
                            }
                        )
                        
                        

                            
                        // Ruheherzfrequenzfeld
                        HStack(spacing: 13) {
                            NavigationLink(
                                destination: {
                                    if #available(iOS 16, *) {
                                        HRChartIOS16RhrView(hearts: model.hearts7, weekHearts: model.weekHeartsRhr, colorScheme: colorScheme == .dark ? Color(red: 0.25, green: 0.25, blue: 0.25) : Color.white)
                                    }
                                    else {
                                        // Ansicht wenn auf Feld getippt wird
                                        HRView(tabSelection: $tabSelection, selectedTimeRange: $selectedTimeRangeHome, title: "Resting heart rate", data: model.createArrayRhr(selectedTimeRange: selectedTimeRangeHome), dataSuffix: " bpm", timestamps: model.createTimestampsRhr(selectedTimeRange: selectedTimeRangeHome), indicatorPointColor: Color(red: 0.14, green: 0.45, blue: 0.73), lineColor: Color(red: 0.14, green: 0.45, blue: 0.73), lineSecondColor: Color(red: 0.14, green: 0.45, blue: 0.73), today: Int(model.createTodayRhr().rounded()), av7days: model.calculateMeanRhr())
                                            .onDisappear{
                                                selectedTimeRangeHome = 7
                                            }
                                        
                                        
                                    }
                                    
                                },
                                label: {
                                    // Ansicht auf HomeView
                                    
                                        ZStack {
                                            
                                            Rectangle()
                                                .foregroundColor(colorScheme == .dark ? Color(red: 0.25, green: 0.25, blue: 0.25) : Color.white)
                                                .cornerRadius(10)
                                                //.aspectRatio(CGSize(width: 250, height: 220), contentMode: .fill)
                                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                                //.padding(.vertical, 5)
                                            
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.yellow, lineWidth: 2)
                                                .frame(maxWidth: .infinity,  alignment: .leading)
                                                //.padding(.vertical, 5)
                                                
                                            VStack(alignment: .leading) {
                                                Text("Resting heart rate")
                                                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                                    .font(.custom("Ubuntu-Regular", size: 22))
                                                    .lineLimit(1)
                                                    .allowsTightening(true)
                                                    .minimumScaleFactor(0.5)
                                                    .padding(.horizontal)
                                                    
                                                
                                                HRChartView(data: model.createArrayRhr(selectedTimeRange: 7), timestamps: model.createTimestampsRhr(selectedTimeRange: 7), height: 150, width: 320, dotsWidth: -1, dataSuffix: " bpm", indicatorPointColor: Color(red: 0.14, green: 0.45, blue: 0.73), lineColor: Color(red: 0.14, green: 0.45, blue: 0.73), lineSecondColor: Color(red: 0.14, green: 0.45, blue: 0.73))
                                                
                                                
                                            }
                                            
                                        }
                                        
                                        
                                    
                                    
                                    
                                }
                            )
                            
                            
                            
                                NavigationLink(
                                    destination: {
                                        
                                        InputView(model: model)
                                    },
                                    label: {
                                    
                                        ZStack {
                                            Rectangle()
                                                .foregroundColor(Color(red: 0.14, green: 0.45, blue: 0.73))
                                                .cornerRadius(10)
                                                .frame(maxWidth: 40, alignment: .trailing)
                                                //.aspectRatio(CGSize(width: 75, height: 220), contentMode: .fill)
                                                //.padding(.vertical, 5)
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.accentColor, lineWidth: 2)
                                                .frame(maxWidth: 40, alignment: .trailing)

                                                    
                                            Image(systemName: "plus")
                                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                                .font(.system(size: 30))
                                            
                                            
                                        }
                                    }
                                )
                                
                            
                            
                        }
                        .frame(height:220)
                        
                        NavigationLink(
                            destination: {
                                
                                MeasureView(colorScheme: colorScheme == .dark ? Color.white : Color.black)
                            },
                            label: {
                            
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color.yellow)
                                        .cornerRadius(10)
                                        .aspectRatio(CGSize(width: 335, height: 50), contentMode: .fit)
                                        //.aspectRatio(CGSize(width: 75, height: 220), contentMode: .fill)
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.yellow, lineWidth: 2)
                                        .aspectRatio(CGSize(width: 335, height: 50), contentMode: .fit)
                                        
                                   
                                    HStack {
                                        Text("HR measurement")
                                            .foregroundColor(Color.black)
                                            .font(.custom("Ubuntu-Regular", size: 20))
                                            
                                            .lineLimit(1)
                                            .allowsTightening(true)
                                            .minimumScaleFactor(0.5)
                                        Spacer()
                                        Image(systemName: "stopwatch")
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 30))
                                            
                                        
                                    }
                                    .padding(.horizontal)
                                            
                                    
                                    
                                    
                                }
                            }
                        )
                        
                        HStack(spacing: 13) {
                            NavigationLink(
                                destination: {
                                    
                                    InputHrvView(model: model)
                                },
                                label: {
                                
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Color(red: 0.14, green: 0.45, blue: 0.73))
                                            .cornerRadius(10)
                                            .frame(maxWidth: 40, alignment: .trailing)
                                            //.aspectRatio(CGSize(width: 75, height: 220), contentMode: .fill)
                                            //.padding(.vertical, 5)
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.accentColor, lineWidth: 2)
                                            .frame(maxWidth: 40, alignment: .trailing)

                                                
                                        Image(systemName: "plus")
                                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                            .font(.system(size: 30))
                                        
                                        
                                    }
                                }
                            )
                            
                            
                            
                            
                            NavigationLink(
                                destination: {if #available(iOS 16, *) {
                                    HRChartIOS16HrvView(hearts: model.hearts7, weekHearts: model.weekHeartsHrv, colorScheme: colorScheme == .dark ? Color(red: 0.25, green: 0.25, blue: 0.25) : Color.white)
                                }
                                    else {
                                        HRView(tabSelection: $tabSelection, selectedTimeRange: $selectedTimeRangeHome , title: "Heart rate variability", data: model.createArrayHrv(selectedTimeRange: selectedTimeRangeHome), dataSuffix: " ms", timestamps: model.createTimestampsHrv(selectedTimeRange: selectedTimeRangeHome), indicatorPointColor: Color(red: 0.14, green: 0.45, blue: 0.73), lineColor: Color(red: 0.14, green: 0.45, blue: 0.73), lineSecondColor: Color(red: 0.14, green: 0.45, blue: 0.73), today: Int(model.createTodayHrv().rounded()), av7days: model.calculateMeanHrv())
                                            .onDisappear{
                                                selectedTimeRangeHome = 7
                                            }
                                    }
                                },
                                label: {
                                    
                                    ZStack {
                                        
                                        Rectangle()
                                            .foregroundColor(colorScheme == .dark ? Color(red: 0.25, green: 0.25, blue: 0.25) : Color.white)
                                            .cornerRadius(10)
                                            //.aspectRatio(CGSize(width: 250, height: 220), contentMode: .fill)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                            //.padding(.vertical, 5)
                                        
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.yellow, lineWidth: 2)
                                            .frame(maxWidth: .infinity,  alignment: .leading)
                                            
                                        VStack(alignment: .leading) {
                                            Text("Heart rate variability")
                                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                                .font(.custom("Ubuntu-Regular", size: 22))
                                                .lineLimit(1)
                                                .allowsTightening(true)
                                                .minimumScaleFactor(0.5)
                                                .padding(.horizontal)
                                                
                                            HRChartView(data: model.createArrayHrv(selectedTimeRange: 7), timestamps: model.createTimestampsHrv(selectedTimeRange: 7), height: 150, width: 320, dotsWidth: -1, dataSuffix: " ms", indicatorPointColor: Color(red: 0.14, green: 0.45, blue: 0.73), lineColor: Color(red: 0.14, green: 0.45, blue: 0.73), lineSecondColor: Color(red: 0.14, green: 0.45, blue: 0.73))
                                                
                                            
                                            
                                        }
                                        
                                    }
                                    
                                }
                            )
                            
                        }
                        .frame(height: 220)
                        
                        NavigationLink(
                            destination: {
                                
                                QuestionnaireView(colorScheme: colorScheme == .dark ? Color.white : Color.black)
                            },
                            label: {
                            
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color.yellow)
                                        .cornerRadius(10)
                                        .aspectRatio(CGSize(width: 335, height: 50), contentMode: .fit)
                                        //.aspectRatio(CGSize(width: 75, height: 220), contentMode: .fill)
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.yellow, lineWidth: 2)
                                        .aspectRatio(CGSize(width: 335, height: 50), contentMode: .fit)
                                        
                                   
                                    HStack {
                                        Text("Questionnaire")
                                            .foregroundColor(Color.black)
                                            .font(.custom("Ubuntu-Regular", size: 20))
                                            
                                            .lineLimit(1)
                                            .allowsTightening(true)
                                            .minimumScaleFactor(0.5)
                                        Spacer()
                                        Image(systemName: "square.and.pencil")
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 30))
                                            
                                        
                                    }
                                    .padding(.horizontal)
                                            
                                    
                                    
                                    
                                }
                            }
                        )
                        
                        
                        
                            
                        
                        
                        
                    }
                    .padding(13)
                    .navigationBarTitle("DOTS")
//                    .toolbar {
//                                ToolbarItem(placement: .principal) {
//                                    VStack {
//                                        Text("DOTS")
//                                            .font(.custom("Ubuntu-Bold", size: 24))
//                                            .foregroundColor(Color.black)
//                                    }
//                                }
//                            }
                    .navigationBarTitleDisplayMode(.inline)
                    
                }
            }
            
            
        }
        .onAppear() { if  NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! > model.firstInputRhr() as Date && NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! > model.firstInputHrv() as Date { model.createLoad()} }
                    .onChange(of: scenePhase) { newPhase in
                        
                        if newPhase == .active {
                            if  NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! > model.firstInputRhr() as Date && NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! > model.firstInputHrv() as Date {
                                model.createLoad()
                            }
                        }
                        
                    }
        
        
                
    }
        
    
        
}
