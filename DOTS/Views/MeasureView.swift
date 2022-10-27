//
//  MeasureViewTest.swift
//  DOTS
//
//  Created by Claudio Cantieni on 10.08.22.
//
import SwiftUI
import AVFAudio
struct MeasureView: View {
   // @ObservedObject var BluethoothModel = BLEModel()
    @ObservedObject var HRVModel = HRV()
    var colorScheme: Color
    @EnvironmentObject var model:ContentModel
    @EnvironmentObject var manager:NotificationManager
    @State private var index = 1
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var current = 0.0
    @State var current2 = 0.0
    
    var body: some View {
        ZStack {
        if model.lastTimestampRhr() >= NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 0, to: Date())!) || model.lastTimestampHrv() >= NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 0, to: Date())!){
            
                Text("Execute measurement tomorrow")
                .font(.custom("Ubuntu-Medium", size: 22))
//                            Button {
//
//                                manager.badgeNumber = 0
//                                UIApplication.shared.applicationIconBadgeNumber = manager.badgeNumber
//            } label: {
//                Text("REmove")
//           }

        }
        
            
        else {
            
                
                
                //Text(String(BluethoothModel.bpm ?? 0))
                //   .font(.custom("Ubuntu-Regular", size: 100))
                if index == 1 {
                    VStack(spacing: 20) {
                        HStack {
                            Text("HR ")
                            Text("\(HRVModel.bpm ?? 0)")
                        }
                            .foregroundColor(colorScheme)
                            .font(.custom("Ubuntu-Medium", size: 50))
                        if HRVModel.bpm == nil {
                            ZStack {
                                ButtonView(color: .accentColor)
                                    .opacity(0.2)
                                Text("Start")
                                    .foregroundColor(colorScheme)
                                    .font(.custom("Ubuntu-Medium", size: 18))
                            }
                        }
                        else {
                            Button {
                                
                                index = 4
                                UIApplication.shared.isIdleTimerDisabled = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 28) {
                                    HRVModel.startMeasure()
                                    index = 2
                                    
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 86) {
                                    HRVModel.stopMeasure()
                                    AudioServicesPlaySystemSound(1050)
                                    index = 3
                                }
                            } label: {
                                ZStack {
                                    ButtonView(color: .accentColor)
                                    Text("Start")
                                        .foregroundColor(colorScheme)
                                        .font(.custom("Ubuntu-Medium", size: 18))
                                }
                            }
                        }
                        
                        NavigationLink {
                            BluetoothListView()
                        } label: {
                            ZStack {
                                ButtonView(color: .gray)
                                Text("Devices")
                                    .foregroundColor(colorScheme)
                                    .font(.custom("Ubuntu-Medium", size: 18))
                            }
                        }
                        
                    }
                    
                }
                else if index == 4 {
                    VStack(spacing: 20) {
                        HStack {
                            Text("HR ")
                            Text("\(HRVModel.bpm ?? 0)")
                        }
                            .foregroundColor(colorScheme)
                            .font(.custom("Ubuntu-Medium", size: 50))
                        Text("30s relaxing")
                            .foregroundColor(colorScheme)
                            .font(.custom("Ubuntu-Medium", size: 22))
                        if #available(iOS 16.0, *) {
                            Gauge(value: current, in: 0...30) {
                                
                            } currentValueLabel: {
                                Text("\(Int(current))s")
                            }
                            .onReceive(timer) { _ in
                                if current == 29 {
                                    timer.upstream.connect().cancel()
                                }
                                current += 1
                            }
                            .tint(Color.yellow)
                            .gaugeStyle(.accessoryLinearCapacity)
                            
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    .padding()
                }
                
                else if index == 2 {
                    VStack(spacing: 20) {
                        HStack {
                            Text("HR ")
                            Text("\(HRVModel.bpm ?? 0)")
                        }
                        .foregroundColor(colorScheme)
                        .font(.custom("Ubuntu-Medium", size: 50))
                        Text("60s measuring")
                            .foregroundColor(colorScheme)
                            .font(.custom("Ubuntu-Medium", size: 22))
                        if #available(iOS 16.0, *) {
                            Gauge(value: current2, in: 0...60) {
                                
                            } currentValueLabel: {
                                Text("\(Int(current2))s")
                            }
                            .onReceive(timer) { _ in
                                if current2 == 59 {
                                    timer.upstream.connect().cancel()
                                }
                                current2 += 1
                            }
                            .tint(Color.accentColor)
                            .gaugeStyle(.accessoryLinearCapacity)
                            
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    .padding()
                    
                }
                else if index == 3 {
                    VStack(spacing: 20) {
                        HStack {
                            Text("Resting heart rate: ")
                            Text("\(Int(HRVModel.hr))")
                        }
                        .foregroundColor(colorScheme)
                        .font(.custom("Ubuntu-Regular", size: 18))
                        
                        
                        HStack {
                            Text("Heart rate variability (RMSSD): ")
                            Text("\(Int(HRVModel.hrv))")
                        }
                        .foregroundColor(colorScheme)
                        .font(.custom("Ubuntu-Regular", size: 18))
                        
                        
                        
                        if (HRVModel.hr >= model.calculateMeanRhr28()*1.4 ||  HRVModel.hr <= model.calculateMeanRhr28()*0.6 ||  HRVModel.hrv >= model.calculateMeanHrv28()*1.4 || HRVModel.hrv <= model.calculateMeanHrv28()*0.6) && model.hearts28.count != 0{
                            Text("Measure quality: low")
                                .foregroundColor(Color.red)
                                .font(.custom("Ubuntu-Regular", size: 18))
                            
                        }
                            
                        
                        else {
                            Text("Measure quality: high")
                                .foregroundColor(Color.green)
                                .font(.custom("Ubuntu-Regular", size: 18))
                                
                        }
                        
                        
                        Button {
                            index = 1
                            current = 0.0
                            current2 = 0.0
                        } label: {
                            ZStack {
                                ButtonView(color: .gray)
                                Text("Repeat")
                                    .foregroundColor(colorScheme)
                                    .font(.custom("Ubuntu-Medium", size: 18))
                            }
                        }
                        
                        Button {
                            HRVModel.addData()
                            var dateComponents = DateComponents()
                            
                            dateComponents.calendar = Calendar.current
                            dateComponents.hour = UserDefaults.standard.integer(forKey: "notificationHour")
                            dateComponents.minute = UserDefaults.standard.integer(forKey: "notificationMinute")
                            
                            let date = NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 3, to: self.model.timestampQuestionnaire())!))
                            //let date = model.lastTimestampRhr()
                            var dateComponents2 = Calendar.current.dateComponents([.year, .month, .day], from: date)
                            dateComponents2.calendar = Calendar.current
                            dateComponents2.hour = UserDefaults.standard.integer(forKey: "notificationHour")
                            dateComponents2.minute = UserDefaults.standard.integer(forKey: "notificationMinute")
                            
                            if dateComponents.date! < Date() && dateComponents2.date! > Date() {
                                manager.badgeNumber = 0
                                UIApplication.shared.applicationIconBadgeNumber = manager.badgeNumber
                            }
                            
                            model.fetchHearts()
                            
                            model.fetchHeartsFirst()
                            


                            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: manager.RhrIdentifier)
                            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: manager.HrvIdentifier)
                            
                            if  NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! > model.firstInputRhr() as Date && NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! > model.firstInputHrv() as Date { model.createLoad()}
                            
                            self.presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            ZStack {
                                ButtonView(color: .accentColor)
                                Text("Speichern")
                                    .foregroundColor(colorScheme)
                                    .font(.custom("Ubuntu-Medium", size: 18))
                            }
                        }
                        
                    }
                }
                
            }
            
        }
        .onAppear(perform: {
            HRVModel.connect()
        })
        .onDisappear {
            HRVModel.stopMeasure2()
            UIApplication.shared.isIdleTimerDisabled = false
        }
        .navigationTitle("HR measurement")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                MeasurePopoverView()
                
            }
        }
            
    }
        
}
