//
//  QuestionnaireView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 11.05.22.
//

import SwiftUI

struct QuestionnaireView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @EnvironmentObject var model:ContentModel
    @EnvironmentObject var manager:NotificationManager
    
    @State private var value = 3.0
    @State private var isEditing = false
    @State private var index = 1
    @State var answerRow:[Int] = []
    
    
    var body: some View {
        VStack {
            if model.timestampQuestionnaire() >= NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -6, to: NSDate() as Date)!) {
                if Int((NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 7, to: model.timestampQuestionnaire())!)).timeIntervalSinceNow / 3600 / 24).rounded(.up)) == 1 {
                    Text("Fragebogen morgen ausfüllen")
                }
                else {
                    Text("Fragebogen in \(Int((NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 7, to: model.timestampQuestionnaire())!)).timeIntervalSinceNow / 3600 / 24).rounded(.up))) Tagen ausfüllen")
                }
                
            }
            else {
                if index == 1{
                    Text("In der letzten Woche habe ich mich entspannt gefühlt")
                        .padding()
                    Slider(value: $value, in: 1...5, step: 1)
                        .padding()
                }
    //            Text("In der letzten Woche \(questions.question) ")
    //                        .padding()
    //                Slider(value: $value, in: 1...5, step: 1)
    //                    .padding()
                else if index == 2 {
                    Text("In der letzten Woche konnte ich mich gut konzentrieren")
                        .padding()
                    Slider(value: $value, in: 1...5, step: 1)
                        .padding()
                }
                else if index == 3 {
                    Text("In der letzten Woche hatte ich genügend Schlaf")
                        .padding()
                    Slider(value: $value, in: 1...5, step: 1)
                        .padding()
                }
                else if index == 4 {
                    Text("In der letzten Woche war ich guter Laune")
                        .padding()
                    Slider(value: $value, in: 1...5, step: 1)
                        .padding()
                }
                else if index == 5 {
                    Text("In der letzten Woche fühlte ich mich unter Druck gesetzt")
                        .padding()
                    Slider(value: $value, in: 1...5, step: 1)
                        .padding()
                }
                else if index == 6 {
                    Text("In der letzten Woche fühlte ich mich leistungsfähig")
                        .padding()
                    Slider(value: $value, in: 1...5, step: 1)
                        .padding()
                }
                else if index == 7 {
                    
                    Text("Fragebogen ist ausgefüllt")
                }
                
                    if value == 1 {
                        Text("nie")
                    }
                    else if value == 2 {
                        Text("selten")
                    }
                    else if value == 3 {
                        Text("manchmal")
                    }
                    else if value == 4 {
                        Text("oft")
                    }
                    else if value == 5 {
                        Text("immer")
                    }
                    else {
                    
                    }
                if index == 5 {
                    Button {
                        addToAnswersReversed()
                        index += 1
                        value = 3
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.accentColor)
                                .cornerRadius(10)
                                .shadow(color: .gray, radius:5)
                                .frame(height: 48)
                                .padding()
                            Text("Weiter")
                                .foregroundColor(.black)
                        }
                        
                    }
                }
                else if index != 7 && index != 6 && index != 5 {
                    Button {
                        addToAnswers()
                        index += 1
                        value = 3
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.accentColor)
                                .cornerRadius(10)
                                .shadow(color: .gray, radius:5)
                                .frame(height: 48)
                                .padding()
                            Text("Weiter")
                                .foregroundColor(.black)
                        }
                        
                    }
                }
                else if index == 6 {
                    Button {
                        index += 1
                        addToAnswers()
                        value  = 0
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.accentColor)
                                .cornerRadius(10)
                                .shadow(color: .gray, radius:5)
                                .frame(height: 48)
                                .padding()
                            Text("Beenden")
                                .foregroundColor(.black)
                        }
                        
                    }
                }
                else if index == 7 {
                    Button {
                        addData()
                        
                        model.fetchQuestionnaire()
                        
                        manager.badgeNumber -= 1
                        UIApplication.shared.applicationIconBadgeNumber = manager.badgeNumber
                        
                        manager.scheduleNotificationQuestionnaire()
                        
                        self.presentationMode.wrappedValue.dismiss()

                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.accentColor)
                                .cornerRadius(10)
                                .shadow(color: .gray, radius:5)
                                .frame(height: 48)
                                .padding()
                            Text("Fertig")
                                .foregroundColor(.black)
                        }
                        
                    }
                }
            }

        }
//        ForEach(model.models, id: \.id) { i in
//                QuestionView(questions:i)
//            }
                
        
    }
    func addToAnswers() {
        answerRow.append(Int(value))
    }
    func addToAnswersReversed() {
        var valueReversed = 0
        if  value == 1 {
            valueReversed = 5
        }
        else if value == 2 {
            valueReversed = 4
        }
        else if value == 3 {
            valueReversed = 3
        }
        else if value == 4 {
            valueReversed = 2
        }
        else if value == 5 {
            valueReversed = 1
        }
            answerRow.append(Int(valueReversed))
    }
    func addData() {
        let questionnaire = Questionnaire(context: viewContext)
        questionnaire.timestamp = Date()
        questionnaire.answers = answerRow
//        for i in answerRow {
//            let answers = Answers(context: viewContext)
//            answers.id = UUID()
//            answers.answer = i
//            answers.questionnaire = questionnaire
       // }
        
        do {
            try viewContext.save()
        }
        catch {
            
        }
    
        
        
    }
    
}

