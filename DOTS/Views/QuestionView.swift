////
////  QuestionView.swift
////  DOTS
////
////  Created by Claudio Cantieni on 11.05.22.
////
//
//import SwiftUI
//
//struct QuestionView: View {
// //   var questions: Model
//    @State private var value = 3.0
//    @State private var isEditing = false
//    @State private var index = 1
//    var body: some View {
//        VStack {
//            if index == 1{
//                Text("In der letzten Woche  ")
//                    .padding()
//                Slider(value: $value, in: 1...5, step: 1)
//                    .padding()
//            }
////            Text("In der letzten Woche \(questions.question) ")
////                        .padding()
////                Slider(value: $value, in: 1...5, step: 1)
////                    .padding()
//            else if index == 2 {
//                Text("In der letzten Woche  ")
//                    .padding()
//                Slider(value: $value, in: 1...5, step: 1)
//                    .padding()
//            }
//            else if index == 3 {
//                Text("In der letzten Woche  ")
//                    .padding()
//                Slider(value: $value, in: 1...5, step: 1)
//                    .padding()
//            }
//            else if index == 4 {
//                Text("In der letzten Woche  ")
//                    .padding()
//                Slider(value: $value, in: 1...5, step: 1)
//                    .padding()
//            }
//            else if index == 5 {
//                Text("In der letzten Woche  ")
//                    .padding()
//                Slider(value: $value, in: 1...5, step: 1)
//                    .padding()
//            }
//            else if index == 6 {
//                Text("In der letzten Woche  ")
//                    .padding()
//                Slider(value: $value, in: 1...5, step: 1)
//                    .padding()
//            }
//            else if index == 7 {
//                Text("In der letzten Woche  ")
//                    .padding()
//                Slider(value: $value, in: 1...5, step: 1)
//                    .padding()
//            }
//                if value == 1 {
//                    Text("nie")
//                }
//                else if value == 2 {
//                    Text("selten")
//                }
//                else if value == 3 {
//                    Text("manchmal")
//                }
//                else if value == 4 {
//                    Text("oft")
//                }
//                else if value == 5 {
//                    Text("immer")
//                }
//            if index != 7 {
//                Button {
//                    index += 1
//                } label: {
//                    ZStack {
//                        Rectangle()
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                            .shadow(radius:5)
//                            .frame(height: 48)
//                        Text("Weiter")
//                            .foregroundColor(.black)
//                    }
//                    
//                }
//            }
//            else if index == 7 {
//                Button {
//                    isQuestionnaireViewShowing
//                } label: {
//                    ZStack {
//                        Rectangle()
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                            .shadow(radius:5)
//                            .frame(height: 48)
//                        Text("Weiter")
//                            .foregroundColor(.black)
//                    }
//                    
//                }
//            }
//            
//
//        }
//
//    }
//}
//
