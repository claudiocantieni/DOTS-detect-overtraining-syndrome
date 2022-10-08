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
    var colorScheme: Color

    
    var body: some View {
        VStack {
            
            
            Spacer()
            VStack {
                if model.timestampQuestionnaire() >= NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -2, to: NSDate() as Date)!) {
                    if Int((NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 3, to: model.timestampQuestionnaire())!)).timeIntervalSinceNow / 3600 / 24).rounded(.up)) == 1 {
                        Text("Fill out questionnaire tomorrow")
                            .font(.custom("Ubuntu-Medium", size: 22))
                    }
                    else {
                        VStack(spacing: 10) {
                            Text("Fill out questionnaire in ")
                            HStack(spacing: 0) {
                                Text("\(Int((NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 3, to: model.timestampQuestionnaire())!)).timeIntervalSinceNow / 3600 / 24).rounded(.up)))")
                                Text(" days")
                            }
                            
                        }
                            .font(.custom("Ubuntu-Medium", size: 22))
                    }
                    
                }
                else {
                    if index == 1{
                        Text("In den letzten 3 Tagen habe ich mich entspannt gefühlt")
                            .padding()
                            .font(.custom("Ubuntu-Regular", size: 18))
                        Slider(value: $value, in: 1...5, step: 1)
                            .padding()
                    }
                    //            Text("In der letzten Woche \(questions.question) ")
                    //                        .padding()
                    //                Slider(value: $value, in: 1...5, step: 1)
                    //                    .padding()
                    else if index == 2 {
                        Text("In den letzten 3 Tagen konnte ich mich gut konzentrieren")
                            .padding()
                            .font(.custom("Ubuntu-Regular", size: 18))
                        Slider(value: $value, in: 1...5, step: 1)
                            .padding()
                    }
                    else if index == 3 {
                        Text("In den letzten 3 Tagen hatte ich genügend Schlaf")
                            .padding()
                            .font(.custom("Ubuntu-Regular", size: 18))
                        Slider(value: $value, in: 1...5, step: 1)
                            .padding()
                    }
                    else if index == 4 {
                        Text("In den letzten 3 Tagen war ich guter Laune")
                            .padding()
                            .font(.custom("Ubuntu-Regular", size: 18))
                        Slider(value: $value, in: 1...5, step: 1)
                            .padding()
                    }
                    else if index == 5 {
                        Text("In den letzten 3 Tagen fühlte ich mich unter Druck gesetzt")
                            .padding()
                            .font(.custom("Ubuntu-Regular", size: 18))
                        Slider(value: $value, in: 1...5, step: 1)
                            .padding()
                    }
                    else if index == 6 {
                        Text("In den letzten 3 Tagen fühlte ich mich leistungsfähig")
                            .padding()
                            .font(.custom("Ubuntu-Regular", size: 18))
                        Slider(value: $value, in: 1...5, step: 1)
                            .padding()
                    }
                    else if index == 7 {
                        
                        Text("Questionnaire is filled out")
                            .font(.custom("Ubuntu-Medium", size: 22))
                    }
                    
                    if value == 1 {
                        Text("never")
                            .font(.custom("Ubuntu-Medium", size: 18))
                    }
                    else if value == 2 {
                        Text("rarely")
                            .font(.custom("Ubuntu-Medium", size: 18))
                    }
                    else if value == 3 {
                        Text("sometimes")
                            .font(.custom("Ubuntu-Medium", size: 18))
                    }
                    else if value == 4 {
                        Text("often")
                            .font(.custom("Ubuntu-Medium", size: 18))
                    }
                    else if value == 5 {
                        Text("always")
                            .font(.custom("Ubuntu-Medium", size: 18))
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
                                ButtonView(color: .accentColor)
                                Text("Next")
                                    .foregroundColor(colorScheme)
                                    .font(.custom("Ubuntu-Medium", size: 18))
                            }
                            
                        }
                        Button {
                            deleteAnswer()
                            index -= 1
                            value = 3
                        } label: {
                            ZStack {
                                ButtonView(color: .gray)
                                Text("Back")
                                    .foregroundColor(colorScheme)
                                    .font(.custom("Ubuntu-Medium", size: 18))
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
                                ButtonView(color: .accentColor)
                                Text("Next")
                                    .foregroundColor(colorScheme)
                                    .font(.custom("Ubuntu-Medium", size: 18))
                            }
                            
                        }
                        if index != 1 {
                            Button {
                                deleteAnswer()
                                index -= 1
                                value = 3
                            } label: {
                                ZStack {
                                    ButtonView(color: .gray)
                                    Text("Back")
                                        .foregroundColor(colorScheme)
                                        .font(.custom("Ubuntu-Medium", size: 18))
                                }
                                
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
                                ButtonView(color: .accentColor)
                                Text("End")
                                    .foregroundColor(colorScheme)
                                    .font(.custom("Ubuntu-Medium", size: 18))
                            }
                            
                        }
                        Button {
                            deleteAnswer()
                            index -= 1
                            value = 3
                        } label: {
                            ZStack {
                                ButtonView(color: .gray)
                                Text("Back")
                                    .foregroundColor(colorScheme)
                                    .font(.custom("Ubuntu-Medium", size: 18))
                            }
                            
                        }
                        
                    }
                    else if index == 7 {
                        Button {
                            let date = NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 3, to: self.model.timestampQuestionnaire())!))
                            //let date = model.lastTimestampRhr()
                            var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
                            dateComponents.calendar = Calendar.current
                            dateComponents.hour = 7
                            dateComponents.minute = 0
                            
                            
                            if dateComponents.date! < Date() {
                                manager.badgeNumber = 0
                                UIApplication.shared.applicationIconBadgeNumber = manager.badgeNumber
                            }
                            
                            addData()
                            
                            model.fetchQuestionnaire()
                            
                            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: manager.QuestIdentifier)
                            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: manager.QuestIdentifier)
                            
                            manager.scheduleNotificationQuestionnaire()
                            
                            self.presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            ZStack {
                                ButtonView(color: .gray)
                                Text("Save")
                                    .foregroundColor(colorScheme)
                                    .font(.custom("Ubuntu-Medium", size: 18))
                            }
                            
                        }
                    }
                }
                
            }
            Spacer()
        }
        .navigationTitle("Questionnaire")
//        ForEach(model.models, id: \.id) { i in
//                QuestionView(questions:i)
//            }
                
        
    }
    func addToAnswers() {
        answerRow.append(Int(value))
    }
    
    func deleteAnswer() {
        answerRow.removeLast()
        
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

