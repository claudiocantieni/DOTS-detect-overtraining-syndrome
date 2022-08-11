//
//  WelcomeView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 22.05.22.
//

import SwiftUI

struct WelcomeView: View {
    
    @AppStorage("welcomeViewShown")
    var welcomeViewShown: Bool = false
    var isButtonNeeded: Bool
    var body: some View {
        
        ScrollView {
            VStack {
                HStack {
                    Text("Benutzungsanleitung")
                        
                        .padding()
                        .font(.custom("Ubuntu-Medium", size: 24))
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                
                
                    
                Text("""
                    Die DOTS App zeigt einen Belastungszustand an. Die angezeigte Diagnose ist mit der aktuellen Trainingsbelastung abzugleichen.
                                    
                    Die DOTS App kann helfen, eine mögliche Überbelastung frühzeitig zu erkennen.
                                    
                    Damit die Analyse aussagekräftig ist, muss täglich morgens die Ruheherzfrequenz und jeden dritten Morgen die Herzfrequenzvariabilität erfasst werden.
                                    
                    Zudem ist einmal wöchentlich ein psychometrischer Fragebogen auszufüllen.
                    """)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .lineSpacing(5)
                    .font(.custom("Ubuntu-Regular", size: 16))
                    
                
                Spacer()
                if isButtonNeeded == true {
                    Button {
                        welcomeViewShown = true
                    } label: {
                        ZStack {
                            ButtonView(color: .accentColor)
                            Text("Weiter")
                                .foregroundColor(.black)
                                .font(.custom("Ubuntu-Medium", size: 18))
                        }
                    }
                    .frame(alignment: .center)
                    .padding()
                }
                
                

            }
        }
        
    }
}


