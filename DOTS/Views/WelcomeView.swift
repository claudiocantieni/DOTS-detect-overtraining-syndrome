//
//  WelcomeView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 17.10.22.
//

import SwiftUI

struct WelcomeView: View {
    @State private var index = 1
    
    @AppStorage("welcomeViewShown")
    var welcomeViewShown: Bool = false
    @AppStorage("notificationHour") var notificationHour: Int = 7
    @AppStorage("notificationMinute") var notificationMinute: Int = 0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack(spacing: 50) {
            if index == 1 {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .aspectRatio(CGSize(width: 335, height: 250), contentMode: .fit)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.yellow, lineWidth: 2)
                        .aspectRatio(CGSize(width: 335, height: 250), contentMode: .fit)
                    ZStack {
                        ProgressView(value: 0.3) {
                            HStack(spacing: 10) {
                                
                                
                                Text("Shape")
                                    .foregroundColor( Color.black)
                                    .font(.custom("Ubuntu-Regular", size: 22))
                                    .lineLimit(1)
                                    .allowsTightening(true)
                                    .minimumScaleFactor(0.5)
                                   
                                
                            }
                        }
                        .progressViewStyle(
                            .gauge(thickness: 20, lineWidth: 8, color: Color.white)
                        )
                        .padding(.top)
                        VStack {
                            
                            
                            Spacer()
                            // Text unter Tachometer
                            
                                    
                            Text("slightly loaded")
                                .foregroundColor(Color.orange)
                                .font(.custom("Ubuntu-Regular", size: 18))
                                    
                                
                            .padding()
                    }
                    
                            
                    }
                    .aspectRatio(CGSize(width: 335, height: 250), contentMode: .fit)
                }
                
                
                    
                Text("""
                    The DOTS app displays a shape. The displayed diagnosis should be compared with the current training load.
                    """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
                Button {
                    index += 1
                } label: {
                    ZStack {
                        ButtonView(color: .accentColor)
                        Text("Next")
                            .foregroundColor(.black)
                            .font(.custom("Ubuntu-Medium", size: 18))
                    }
                }

            }
            else if index == 2 {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .aspectRatio(CGSize(width: 335, height: 250), contentMode: .fit)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.yellow, lineWidth: 2)
                        .aspectRatio(CGSize(width: 335, height: 250), contentMode: .fit)
                    ZStack {
                        ProgressView(value: 0.3) {
                            HStack(spacing: 10) {
                                
                                
                                Text("Shape")
                                    .foregroundColor( Color.black)
                                    .font(.custom("Ubuntu-Regular", size: 22))
                                    .lineLimit(1)
                                    .allowsTightening(true)
                                    .minimumScaleFactor(0.5)
                                
                                Image(systemName: "exclamationmark.triangle")
                                    .foregroundColor(Color.red)
                                    .font(.system(size: 27))
                                
                            }
                        }
                        .progressViewStyle(
                            .gauge(thickness: 20, lineWidth: 8, color: Color.white)
                        )
                        .padding(.top)
                        VStack {
                            
                            
                            Spacer()
                            // Text unter Tachometer
                            
                                    
                            Text("slightly loaded")
                                .foregroundColor(Color.orange)
                                .font(.custom("Ubuntu-Regular", size: 18))
                                    
                                
                            .padding()
                    }
                    
                            
                    }
                    .aspectRatio(CGSize(width: 335, height: 250), contentMode: .fit)
                }
                Text("""
                    The DOTS app can help to detect a possible overload at an early stage.
                    """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
                Button {
                    index += 1
                } label: {
                    ZStack {
                        ButtonView(color: .accentColor)
                        Text("Next")
                            .foregroundColor(.black)
                            .font(.custom("Ubuntu-Medium", size: 18))
                    }
                }
            }
            else if index == 3 {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.yellow)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        
                        //.aspectRatio(CGSize(width: 75, height: 220), contentMode: .fill)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.yellow, lineWidth: 2)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                   
                    HStack {
                        Text("HR measurement")
                            .foregroundColor(Color.black)
                            .font(.custom("Ubuntu-Regular", size: 22))
                            .lineLimit(1)
                            .allowsTightening(true)
                            .minimumScaleFactor(0.5)
                            .padding(.horizontal)
                        Spacer()
                        Image(systemName: "stopwatch")
                            .foregroundColor(Color.black)
                            .font(.system(size: 30))
                            .padding(.horizontal)
                            
                        
                    }
                            
                    
                    
                    
                }
                Text("""
                    For the analysis to be representative, the resting heart rate and heart rate variability have to be recorded daily in the morning. The measurement can be done in the app.
                    """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
                Button {
                    index += 1
                } label: {
                    ZStack {
                        ButtonView(color: .accentColor)
                        Text("Next")
                            .foregroundColor(.black)
                            .font(.custom("Ubuntu-Medium", size: 18))
                    }
                }
            }
            else if index == 4 {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(red: 0.14, green: 0.45, blue: 0.73))
                        .cornerRadius(10)
                        .frame(width: 40)
                        .frame(height: 220)
                        //.aspectRatio(CGSize(width: 75, height: 220), contentMode: .fill)
                        //.padding(.vertical, 5)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 0.14, green: 0.45, blue: 0.73), lineWidth: 2)
                        .frame(width: 40)
                        .frame(height: 220)

                            
                    Image(systemName: "plus")
                        .foregroundColor(Color.black)
                        .font(.system(size: 30))
                    
                    
                }
                Text("""
                    Manual input is also available.
                    """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
                Button {
                    index += 1
                } label: {
                    ZStack {
                        ButtonView(color: .accentColor)
                        Text("Next")
                            .foregroundColor(.black)
                            .font(.custom("Ubuntu-Medium", size: 18))
                    }
                }
            }
            else if index == 5 {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.yellow)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        //.aspectRatio(CGSize(width: 75, height: 220), contentMode: .fill)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.yellow, lineWidth: 2)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        
                   
                    HStack {
                        Text("Questionnaire")
                            .padding(.horizontal)
                            .foregroundColor(Color.black)
                            .font(.custom("Ubuntu-Regular", size: 22))
                            
                            .lineLimit(1)
                            .allowsTightening(true)
                            .minimumScaleFactor(0.5)
                        Spacer()
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(Color.black)
                            .font(.system(size: 30))
                            .padding(.horizontal)
                            
                        
                    }
                            
                    
                    
                    
                }
                Text("""
                    A psychometric questionnaire has to be filled out every three days.
                    """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
                Button {
                    index += 1
                   
                    
                    
                    
                } label: {
                    ZStack {
                        ButtonView(color: .accentColor)
                        Text("Next")
                            .foregroundColor(.black)
                            .font(.custom("Ubuntu-Medium", size: 18))
                        
                    }
                }
            }
            
            else if index == 6 {
                Image(systemName: "lock.shield")
                    .font(.system(size: 100))
                    .foregroundColor(.accentColor)
                Text("""
                    The data is stored locally on the device.
                    """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
                Button {
                    index += 1
                    if welcomeViewShown == false {
                        tabSelection = 1
                        notificationHour = 7
                        notificationMinute = 0
                        welcomeViewShown = true
                    }
                    else {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                   
                    
                    
                    
                } label: {
                    ZStack {
                        ButtonView(color: .accentColor)
                        Text("Done")
                            .foregroundColor(.black)
                            .font(.custom("Ubuntu-Medium", size: 18))
                        
                    }
                }
            }
        }
        .padding(13)
        
    }
        
}




