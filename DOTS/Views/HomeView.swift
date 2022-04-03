//
//  HomeView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 03.04.22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack {
                    ZStack {
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .aspectRatio(CGSize(width: 335, height: 150), contentMode: .fit)
                            .shadow(radius: 5)
                        VStack {
                            Image("diagram")
                                .resizable()
                                .frame(width: 300, height: 130)
                            Text("Ruheherzfrequenz letzte 7 Tage")
                        }
                    }
                    ZStack {
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .aspectRatio(CGSize(width: 335, height: 150), contentMode: .fit)
                            .shadow(radius: 5)
                        VStack {
                            Image("diagram")
                                .resizable()
                                .frame(width: 300, height: 130)
                            Text("HRV letzte 7 Tage")
                        }
                    }
                    ZStack {
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .aspectRatio(CGSize(width: 335, height: 80), contentMode: .fit)
                            .shadow(radius: 5)
                        VStack {
                            
                            Text("EBF")
                                .font(.largeTitle)
                                .bold()
                        }
                    }
                    ZStack {
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .aspectRatio(CGSize(width: 335, height: 100), contentMode: .fit)
                            .shadow(radius: 5)
                        VStack {
                            Image("tacho")
                                .resizable()
                                .frame(width: 172, height: 65, alignment: .top)
                                
                        }
                    }
                }
                .padding()
                .accentColor(.black)
                    .navigationTitle("Home")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
