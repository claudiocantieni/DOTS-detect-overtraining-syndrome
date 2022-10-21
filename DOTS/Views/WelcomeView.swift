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
                    Die DOTS App zeigt einen Formzustand an. Die angezeigte Diagnose ist mit der aktuellen Trainingsbelastung abzugleichen.
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
                    Die DOTS App kann helfen, eine mögliche Überbelastung frühzeitig zu erkennen.
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
                    Damit die Analyse aussagekräftig ist, muss täglich morgens die Ruheherzfrequenz und die Herzfrequenzvariabilität erfasst werden. Die Messung kann in der App durchgeführt werden.
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
                    Die manuelle Eingabe ist auch möglich.
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
                    Alle drei Tage ist ein psychometrischer Fragebogen auszufüllen.
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
                    Die Daten sind lokal auf dem Gerät gespeichert.
                    """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
                Button {
                    index += 1
                    if welcomeViewShown == false {
                        tabSelection = 1
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




