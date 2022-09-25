//
//  ContentModel.swift
//  DOTS
//
//  Created by Claudio Cantieni on 06.04.22.
//

import Foundation
import SwiftUI
import CoreData
class ContentModel: ObservableObject {
    
    
    let managedObjectContext = PersistenceController.shared.container.viewContext
    
    @Published var hearts7: [Hearts] = []
    @Published var hearts0: [Hearts] = []
    @Published var hearts14: [Hearts] = []
    @Published var hearts28: [Hearts] = []
    @Published var hearts365: [Hearts] = []
    @Published var heartsAll: [Hearts] = []
    @Published var heartsfirstrhr: [Hearts] = []
    @Published var heartsfirsthrv: [Hearts] = []
    @Published var heartsrhrbase: [Hearts] = []
    @Published var heartshrvbase: [Hearts] = []
    @Published var heartsrhrbasecalc: [Hearts] = []
    @Published var heartshrvbasecalc: [Hearts] = []
    
    @Published var questions: [Questionnaire] = []
    @Published var questionsdata: [Questionnaire] = []
    
    @Published var loads7: [Loads] = []
    @Published var loads28: [Loads] = []
    @Published var loads365: [Loads] = []
    @Published var loads0: [Loads] = []
    @Published var loadsToday: [Loads] = []
    
    var timer = Timer()
    init() {
        //createLoad()
        
        fetchHeartsFirst()
        
        fetchHearts()
        
        fetchQuestionnaire()
        
        fetchLoads()
        
        
        
        
    }
    func fetchHearts() {
        let request = NSFetchRequest<Hearts>(entityName: "Hearts")
        let sort = NSSortDescriptor(key: "timestamp", ascending: true)
        let sortAll = NSSortDescriptor(key: "timestamp", ascending: false)
        
        let predicate7 = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -6, to: NSDate() as Date)!) as CVarArg, NSDate())
        let predicate14 = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -13, to: NSDate() as Date)!) as CVarArg, NSDate())
        let predicate28 = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -27, to: NSDate() as Date)!) as CVarArg, NSDate())
        let predicate365 = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -364, to: NSDate() as Date)!) as CVarArg, NSDate())
        let predicate0 = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 0, to: NSDate() as Date)!) as CVarArg, NSDate())
        let predicatebaserhr = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", firstInputRhr(), NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 14, to: firstInputRhr() as Date)!) as CVarArg)
        let predicatebasehrv = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", firstInputHrv(), NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 14, to: firstInputHrv() as Date)!) as CVarArg)
        request.sortDescriptors = [sort]
        request.predicate = predicate7
        do {
            hearts7 = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
        request.sortDescriptors = [sort]
        request.predicate = predicate0
        do {
            hearts0 = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
        request.sortDescriptors = [sort]
        request.predicate = predicate14
        do {
            hearts14 = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
        request.sortDescriptors = [sort]
        request.predicate = predicate28
        do {
            hearts28 = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
        request.sortDescriptors = [sort]
        request.predicate = predicate365
        do {
            hearts365 = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
        request.sortDescriptors = [sortAll]
        
        do {
            heartsAll = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
        
        request.sortDescriptors = [sort]
        request.predicate = predicatebaserhr
        do {
            heartsrhrbase = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
        request.sortDescriptors = [sort]
        request.predicate = predicatebasehrv
        do {
            heartshrvbase = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
    }
    func fetchHeartsFirst() {
        let request = NSFetchRequest<Hearts>(entityName: "Hearts")
        let sortfirst = NSSortDescriptor(key: "timestamp", ascending: true)
        let predicaterhr = NSPredicate(format: "%K != nil", "rhr")
        let predicatehrv = NSPredicate(format: "%K != nil", "hrv")
        
        request.sortDescriptors = [sortfirst]
        request.fetchLimit = 1
        request.predicate = predicaterhr
        do {
             heartsfirstrhr = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
        request.sortDescriptors = [sortfirst]
        request.fetchLimit = 1
        request.predicate = predicatehrv
        do {
             heartsfirsthrv = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
    }
    func fetchQuestionnaire() {
        let request = NSFetchRequest<Questionnaire>(entityName: "Questionnaire")
        let sort = NSSortDescriptor(key: "timestamp", ascending: false)
        let sortdata = NSSortDescriptor(key: "timestamp", ascending: true)
        // control in 2 days
        // let predicate = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -14, to: NSDate() as Date)!) as CVarArg, NSDate())
        let predicate365 = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -364, to: NSDate() as Date)!) as CVarArg, NSDate())
        
        request.sortDescriptors = [sort]
        // request.predicate = predicate
        request.fetchLimit = 1
        do {
             questions = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
        request.sortDescriptors = [sortdata]
        request.predicate = predicate365
        request.fetchLimit = 100
        do {
             questionsdata = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
        
    }
    
    func fetchLoads() {
        let request = NSFetchRequest<Loads>(entityName: "Loads")
        let sort = NSSortDescriptor(key: "timestamp", ascending: true)
        let sortToday = NSSortDescriptor(key: "timestamp", ascending: false)
        
        let predicate7 = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -6, to: NSDate() as Date)!) as CVarArg, NSDate())
        let predicate28 = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -27, to: NSDate() as Date)!) as CVarArg, NSDate())
        let predicate365 = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -364, to: NSDate() as Date)!) as CVarArg, NSDate())
        let predicate0 = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 0, to: NSDate() as Date)!) as CVarArg, NSDate())
  
        request.sortDescriptors = [sort]
        request.predicate = predicate7
        do {
            loads7 = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
        request.sortDescriptors = [sort]
        request.predicate = predicate0
        do {
            loads0 = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
        request.sortDescriptors = [sort]
        request.predicate = predicate28
        do {
            loads28 = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
        request.sortDescriptors = [sort]
        request.predicate = predicate365
        do {
            loads365 = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
        request.sortDescriptors = [sortToday]
        request.fetchLimit = 1
        do {
             loadsToday = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
    }
    
    func createArrayRhr(selectedTimeRange: Int) -> [Double]{
        var hrArray:[Double] = []
        
            if selectedTimeRange == 7 {
                for f in hearts7 {
                    if f.rhr != nil {
                        hrArray.append(f.rhr as! Double)
                    }
                }
            }
            else if selectedTimeRange == 28 {
                for f in hearts28 {
                    if f.rhr != nil {
                        hrArray.append(f.rhr as! Double)
                    }
                }
            }
            else if selectedTimeRange == 365 {
                for f in hearts365 {
                    if f.rhr != nil {
                        hrArray.append(f.rhr as! Double)
                    }
                }
            }
        
        return hrArray
    }
    func createArrayHrv(selectedTimeRange:Int) -> [Double]{
        var hrArray:[Double] = []
        
            if selectedTimeRange == 7 {
                for f in hearts7 {
                    if f.hrv != nil {
                        hrArray.append(f.hrv as! Double)
                    }
                    
                }
            }
            else if selectedTimeRange == 28 {
                for f in hearts28 {
                    if f.hrv != nil {
                        hrArray.append(f.hrv as! Double)
                    }
                }
            }
            else if selectedTimeRange == 365 {
                for f in hearts365 {
                    if f.hrv != nil {
                        hrArray.append(f.hrv as! Double)
                    }
                }
            }
        
        return hrArray
    }
    func createTimestampsRhr(selectedTimeRange: Int) -> [Date]{
        var timestamps:[Date] = []
        
            if selectedTimeRange == 7 {
                for f in hearts7 {
                    if f.rhr != nil {
                        timestamps.append(f.timestamp)
                    }
                }
            }
            else if selectedTimeRange == 28 {
                for f in hearts28 {
                    if f.rhr != nil {
                        timestamps.append(f.timestamp)
                    }
                }
            }
            else if selectedTimeRange == 365 {
                for f in hearts365 {
                    if f.rhr != nil {
                        timestamps.append(f.timestamp)
                    }
                }
            }
        
        return timestamps
    }
    func createTimestampsHrv(selectedTimeRange: Int) -> [Date]{
            var timestamps:[Date] = []
            
                if selectedTimeRange == 7 {
                    for f in hearts7 {
                        if f.hrv != nil {
                            timestamps.append(f.timestamp)
                        }
                    }
                }
                else if selectedTimeRange == 28 {
                    for f in hearts28 {
                        if f.hrv != nil {
                            timestamps.append(f.timestamp)
                        }
                    }
                }
                else if selectedTimeRange == 365 {
                    for f in hearts365 {
                        if f.hrv != nil {
                            timestamps.append(f.timestamp)
                        }
                    }
                }
            
            return timestamps
        }
    func createTodayRhr() -> Double {
    var HrToday:Double = 0
        for f in hearts0 {
            if f.rhr != nil {
                HrToday = f.rhr as! Double
            }
        }
        return HrToday
    }
    func createTodayHrv() -> Double {
    var HrToday:Double = 0
        for f in hearts0 {
            if f.hrv != nil {
                HrToday = f.hrv as! Double
            }
        }
        return HrToday
    }
    func calculateMeanRhr() -> Double {
        var array:[Double] = []
        for f in hearts7 {
            if f.rhr != nil {
                array.append(f.rhr as! Double)
            }
        }
        // Calculate sum ot items with reduce function
        let sum = array.reduce(0, { a, b in
            return a + b
        })
        
        let mean = Double(sum) / Double(array.count)
        let meanRound = Double(round(100 * mean) / 100)
        return Double(meanRound)
    }
    func calculateMeanHrv() -> Double {
        var array:[Double] = []
        for f in hearts7 {
            if f.hrv != nil {
                array.append(f.hrv as! Double)
            }
        }
        // Calculate sum ot items with reduce function
        let sum = array.reduce(0, { a, b in
            return a + b
        })
        
        let mean = Double(sum) / Double(array.count)
        let meanRound = Double(round(100 * mean) / 100)
        return Double(meanRound)
    }
    
    func calculateMeanRhr28() -> Double {
        var array:[Double] = []
        for f in hearts28 {
            if f.rhr != nil {
                array.append(f.rhr as! Double)
            }
        }
        // Calculate sum ot items with reduce function
        let sum = array.reduce(0, { a, b in
            return a + b
        })
        
        let mean = Double(sum) / Double(array.count)
        let meanRound = Double(round(100 * mean) / 100)
        return Double(meanRound)
    }
    func calculateMeanHrv28() -> Double {
        var array:[Double] = []
        for f in hearts28 {
            if f.hrv != nil {
                array.append(f.hrv as! Double)
            }
        }
        // Calculate sum ot items with reduce function
        let sum = array.reduce(0, { a, b in
            return a + b
        })
        
        let mean = Double(sum) / Double(array.count)
        let meanRound = Double(round(100 * mean) / 100)
        return Double(meanRound)
    }
    
//    func calculateMeanRhr14() -> Double {
//        var array:[Double] = []
//        for f in hearts14 {
//            if f.rhr != nil {
//                array.append(f.rhr as! Double)
//            }
//        }
//        // Calculate sum ot items with reduce function
//        let sum = array.reduce(0, { a, b in
//            return a + b
//        })
//
//        let mean = Double(sum) / Double(array.count)
//        let meanRound = Double(round(100 * mean) / 100)
//        return Double(meanRound)
//    }
//    func calculateMeanHrv14() -> Double {
//        var array:[Double] = []
//        for f in hearts14 {
//            if f.hrv != nil {
//                array.append(f.hrv as! Double)
//            }
//        }
//        // Calculate sum ot items with reduce function
//        let sum = array.reduce(0, { a, b in
//            return a + b
//        })
//
//        let mean = Double(sum) / Double(array.count)
//        let meanRound = Double(round(100 * mean) / 100)
//        return Double(meanRound)
//    }
//
//    func calculateRhrFirstBase() -> Double {
//        var array:[Double] = []
//        for f in heartsrhrbase {
//            if f.rhr != nil {
//                array.append(f.rhr as! Double)
//            }
//        }
//        // Calculate sum ot items with reduce function
//        let sum = array.reduce(0, { a, b in
//            return a + b
//        })
//
//        let mean = Double(sum) / Double(array.count)
//        let meanRound = Double(round(100 * mean) / 100)
//        return Double(meanRound)
//    }
//    func calculateHrvFirstBase() -> Double{
//        var array:[Double] = []
//        for f in heartshrvbase {
//            if f.hrv != nil {
//                array.append(f.hrv as! Double)
//            }
//
//        }
//        // Calculate sum ot items with reduce function
//        let sum = array.reduce(0, { a, b in
//            return a + b
//        })
//
//        let mean = Double(sum) / Double(array.count)
//        let meanRound = Double(round(100 * mean) / 100)
//        return Double(meanRound)
//    }
//
//    func calculateRhrBase() -> Double {
//        if firstInputRhr() as Date >=  NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -13, to: NSDate() as Date)!) {
//            return calculateRhrFirstBase()
//        }
//        else {
//            if calculateMeanRhr14() < calculateRhrFirstBase() {
//                calculateRhrFirstBase() == calculateMeanRhr14()
//                return calculateMeanRhr14()
//
//            }
//            else {
//                return calculateRhrFirstBase()
//            }
//        }
//    }
//    func calculateHrvBase() -> Double {
//        if firstInputHrv() as Date >=  NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -13, to: NSDate() as Date)!) {
//            return calculateHrvFirstBase()
//        }
//        else {
//            if calculateMeanHrv14() > calculateHrvFirstBase() {
//                calculateHrvFirstBase() == calculateMeanHrv14()
//                return calculateMeanHrv14()
//            }
//            else {
//                return calculateHrvFirstBase()
//            }
//        }
//    }
    func calculateTotalQuestionnaire() -> Int {
        var sum:Int = 0
        for i in questions {
            for item in i.answers {
                sum += item
            }
        }
        
        
        return sum
        
        
    }
    
    func calculateLoad() -> Double {
        var loadSum:Double = 0
        if calculateTotalQuestionnaire() >= 25 {
            loadSum += 1
        }
        else if calculateTotalQuestionnaire() == 24 {
            loadSum += 0.9
        }
        else if calculateTotalQuestionnaire() == 23 {
            loadSum += 0.8
        }
        else if calculateTotalQuestionnaire() == 22 {
            loadSum += 0.7
        }
        else if calculateTotalQuestionnaire() == 21 {
            loadSum += 0.6
        }
        else if calculateTotalQuestionnaire() == 20 {
            loadSum += 0.5
        }
        else if calculateTotalQuestionnaire() == 19 {
            loadSum += 0.4
        }
        else if calculateTotalQuestionnaire() == 18 {
            loadSum += 0.3
        }
        else if calculateTotalQuestionnaire() == 17 {
            loadSum += 0.2
        }
        else if calculateTotalQuestionnaire() == 16 {
            loadSum += 0.1
        }
        else if calculateTotalQuestionnaire() <= 15 {
            loadSum += 0
        }
        if calculateMeanRhr() <= calculateRhrBase() {
            loadSum += 1
        }
        else if calculateMeanRhr() <= calculateRhrBase() * 1.01 {
            loadSum += 0.9
        }
        else if calculateMeanRhr() <= calculateRhrBase() * 1.02 {
            loadSum += 0.8
        }
        else if calculateMeanRhr() <= calculateRhrBase() * 1.03 {
            loadSum += 0.7
        }
        else if calculateMeanRhr() <= calculateRhrBase() * 1.04 {
            loadSum += 0.6
        }
        else if calculateMeanRhr() <= calculateRhrBase() * 1.05 {
            loadSum += 0.5
        }
        else if calculateMeanRhr() <= calculateRhrBase() * 1.06 {
            loadSum += 0.4
        }
        else if calculateMeanRhr() <= calculateRhrBase() * 1.07 {
            loadSum += 0.3
        }
        else if calculateMeanRhr() <= calculateRhrBase() * 1.08 {
            loadSum += 0.2
        }
        else if calculateMeanRhr() <= calculateRhrBase() * 1.09 {
            loadSum += 0.1
        }
        else if calculateMeanRhr() >= calculateRhrBase() * 1.1 {
            loadSum += 0
        }
        if calculateMeanHrv() >= calculateHrvBase() {
            loadSum += 1
        }
        // TODO: Change to bigger percentage 1.1 & 1.2 Gioni
        else if calculateMeanHrv() >= calculateHrvBase() / 1.01 {
            loadSum += 0.9
        }
        else if calculateMeanHrv() >= calculateHrvBase() / 1.02 {
            loadSum += 0.8
        }
        else if calculateMeanHrv() >= calculateHrvBase() / 1.03 {
            loadSum += 0.7
        }
        else if calculateMeanHrv() >= calculateHrvBase() / 1.04 {
            loadSum += 0.6
        }
        else if calculateMeanHrv() >= calculateHrvBase() / 1.05 {
            loadSum += 0.5
        }
        else if calculateMeanHrv() >= calculateHrvBase() / 1.06 {
            loadSum += 0.4
        }
        else if calculateMeanHrv() >= calculateHrvBase() / 1.07 {
            loadSum += 0.3
        }
        else if calculateMeanHrv() >= calculateHrvBase() / 1.08 {
            loadSum += 0.2
        }
        else if calculateMeanHrv() >= calculateHrvBase() / 1.09 {
            loadSum += 0.1
        }
        else if calculateMeanHrv() <= calculateHrvBase() / 1.1 {
            loadSum += 0
        }
        let load = loadSum / 3
        
        return load
    }

    func firstInputRhr() -> NSDate {
        var firstDate:Date?
        for i in heartsfirstrhr {
            if i.rhr != nil {
                firstDate = i.timestamp
            }
        }
        if firstDate != nil {
            return firstDate! as NSDate
        }
        else {
            return NSDate()
        }
    }
    func firstInputHrv() -> NSDate {
        var firstDate:Date?
        for i in heartsfirsthrv {
            if i.hrv != nil {
                firstDate = i.timestamp
            }
        }
        if firstDate != nil {
            return firstDate! as NSDate
        }
        else {
            return NSDate()
        }
    }
    
    func timestampQuestionnaire() -> Date {
        var timestamp:Date?
        for i in questions {
            
            timestamp = i.timestamp
            
        }
        return timestamp ?? NSCalendar.current.date(byAdding: .day, value: -10, to: NSDate() as Date)!
    }
    func lastTimestampRhr() -> Date {
        var timestamp:Date?
        for i in hearts365 {
            if i.rhr != nil {
                timestamp = i.timestamp
            }
        }
        return timestamp ?? NSCalendar.current.date(byAdding: .day, value: -10, to: NSDate() as Date)!
    }
    func lastTimestampHrv() -> Date {
        var timestamp:Date?
        for i in hearts365 {
            if i.hrv != nil {
                timestamp = i.timestamp
            }
        }
        return timestamp ?? NSCalendar.current.date(byAdding: .day, value: -10, to: NSDate() as Date)!
    }
    
    
    
    func createTodayLoad() -> Double {
    var loadToday:Double = 0
        for f in loadsToday {
            
                loadToday = f.load
            
        }
        return loadToday
    }
    
    func calculateMeanLoad() -> Double {
        var array:[Double] = []
        for f in loads7 {
            
            array.append(f.load )
            
        }
        // Calculate sum ot items with reduce function
        let sum = array.reduce(0, { a, b in
            return a + b
        })
        
        let mean = Double(sum) / Double(array.count)
        let meanRound = Double(round(100 * mean) / 100)
        return Double(meanRound)
    }
    
    func createArrayLoad(selectedTimeRange:Int) -> [Double]{
        var loadArray:[Double] = []
        
            if selectedTimeRange == 7 {
                for f in loads7 {
                    
                    loadArray.append(f.load * 100)
                    
                    
                }
            }
            else if selectedTimeRange == 28 {
                for f in loads28 {
                    
                    loadArray.append(f.load * 100) 
                }
            }
        else if selectedTimeRange == 365 {
            for f in loads365 {
                
                loadArray.append(f.load * 100)
            }
        }
        
        return loadArray 
    }
    func createTimestampsLoad(selectedTimeRange: Int) -> [Date]{
        var timestamps:[Date] = []
        
            if selectedTimeRange == 7 {
                for f in loads7 {
                    
                        timestamps.append(f.timestamp)
                    
                }
            }
            else if selectedTimeRange == 28 {
                for f in loads28 {
                    
                        timestamps.append(f.timestamp)
                    
                }
            }
            else if selectedTimeRange == 365 {
                for f in loads365 {
                    
                        timestamps.append(f.timestamp)
                    
                }
            }
        
        return timestamps
    }
    func createLoad() {
       
        let loads = Loads(context: managedObjectContext)
        if loads0.isEmpty {
            loads.timestamp = NSCalendar.current.startOfDay(for: Date())
            loads.load = calculateLoad()
        }
        else {
            for i in loadsToday {
                i.load = calculateLoad()
            }
           
        }
        do {
            try managedObjectContext.save()
            
        }
        catch {
            print("Error")
        }
            
        fetchLoads()
        
        
    }
    func calculateRhrBase() -> Double {
        
        var array:[Double] = []
        var date = firstInputRhr() as Date
        let calendar = Calendar.current

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: date as Date)
        let date2 = calendar.startOfDay(for: Date())

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        let range = 1...components.day! - 14
        
        for _ in range {
            
            let request = NSFetchRequest<Hearts>(entityName: "Hearts")
            let sort = NSSortDescriptor(key: "timestamp", ascending: true)
           
           
            let predicatebaserhr = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", date as CVarArg, NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 14, to: date as Date)!) as CVarArg)
           
            request.sortDescriptors = [sort]
            request.predicate = predicatebaserhr
            do {
                heartsrhrbasecalc = try managedObjectContext.fetch(request)
            }
            catch {
                
            }
            
            var arrayrhr:[Double] = []
            for f in heartsrhrbasecalc {
                if f.rhr != nil {
                    arrayrhr.append(f.rhr as! Double)
                }
            }
            // Calculate sum ot items with reduce function
            let sum = arrayrhr.reduce(0, { a, b in
                return a + b
            })
            
            let mean = Double(sum) / Double(arrayrhr.count)
            
            if arrayrhr.count >= 5 {
                array.append(Double(mean))
            }
                         
            date = Calendar.current.date(byAdding: .day, value: 1, to: date as Date)!
        }
        let min = array.min() ?? 0
        return min
    }
    func calculateHrvBase() -> Double {
        
        var array:[Double] = []
        var date = firstInputHrv() as Date
        let calendar = Calendar.current

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: date as Date)
        let date2 = calendar.startOfDay(for: Date())

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        let range = 1...components.day! - 14
        
        for _ in range {
            
            let request = NSFetchRequest<Hearts>(entityName: "Hearts")
            let sort = NSSortDescriptor(key: "timestamp", ascending: true)
           
           
            let predicatebasehrv = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", date as CVarArg, NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 14, to: date as Date)!) as CVarArg)
           
            request.sortDescriptors = [sort]
            request.predicate = predicatebasehrv
            do {
                heartshrvbasecalc = try managedObjectContext.fetch(request)
            }
            catch {
                
            }
            
            var arrayrhr:[Double] = []
            for f in heartshrvbasecalc {
                if f.hrv != nil {
                    arrayrhr.append(f.hrv as! Double)
                }
            }
            // Calculate sum ot items with reduce function
            let sum = arrayrhr.reduce(0, { a, b in
                return a + b
            })
            
            let mean = Double(sum) / Double(arrayrhr.count)
            if arrayrhr.count >= 5 {
                array.append(Double(mean))
            }
            
                         
            date = Calendar.current.date(byAdding: .day, value: 1, to: date as Date)!
        }
        let max = array.max() ?? 0
        return max
    }
    func deleteHearts(at offsets: IndexSet) {
        for offset in offsets {
            let hr = heartsAll[offset]
            managedObjectContext.delete(hr)
        }
        
        try? managedObjectContext.save()
        
        fetchHearts()
        fetchHeartsFirst()
        
        
        
    }
    
    /*func deleteHearts(at offsets: IndexSet) {
     for offset in offsets {
         let hr = heartsAll[offset]
         managedObjectContext.delete(hr)
     }
     
    
     
     
     
 }
 func mocSave() {
     try? managedObjectContext.save()
     
     fetchHearts()
     fetchHeartsFirst()
 }*/
//    func fetchHeartsBase() {
//        let request = NSFetchRequest<Hearts>(entityName: "Hearts")
//        let sort = NSSortDescriptor(key: "timestamp", ascending: true)
//
//
//        let predicatebaserhr = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", firstInputRhr(), NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 14, to: firstInputRhr() as Date)!) as CVarArg)
//        let predicatebasehrv = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", firstInputHrv(), NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 14, to: firstInputHrv() as Date)!) as CVarArg)
//        request.sortDescriptors = [sort]
//        request.predicate = predicate7
//        do {
//            hearts7 = try managedObjectContext.fetch(request)
//        }
//        catch {
//
//        }
//
    
//    static func getLocalData() -> [Model] {
//
//        let pathString = Bundle.main.path(forResource: "questions", ofType: "json")
//
//        guard pathString != nil else {
//            return [Model]()
//        }
//
//        let url = URL(fileURLWithPath: pathString!)
//
//        do {
//            let data = try Data(contentsOf: url)
//
//                let decoder = JSONDecoder()
//            do {
//
//                let questionData = try decoder.decode([Model].self, from: data)
//
//                for r in questionData {
//                    r.id = UUID()
//
//                }
//                return questionData
//            }
//            catch {
//                print(error)
//            }
//        }
//        catch {
//
//            print(error)
//        }
//        return [Model]()
//    }
}

/*import ObjcFIT
import SwiftFIT



    /**
     Test decoding a FIT file using the FITListener and FITMessages classes.
     - Note: FITListener is a Swift class that implements each message type's delegate.
     - Note: FITMessages is a Swift class that contains a mutable array for each message type.
     - Attention: FITListener routes the decoded messages to their corresponding array in FITMessages. After the file is decoded, all of the messages will be in an instance of a FITMessages class.
     */
class ContentModel: ObservableObject {
        
        func testDecoder() throws {
        let filename = ""

        try XCTSkipIf(filename.count == 0, "8586194076_ACTIVITY.fit") // noch nicht vorhanden API?

        let decoder = FITDecoder()
        let listener = FITListener()
        decoder.mesgDelegate = listener

        XCTAssertTrue(decoder.decodeFile(filename))

        let messages = listener.messages;
        XCTAssertEqual(messages.getFileIdMesgs().count,1)
    }

    func testListener() {
        let listener = FITListener()
        listener.onMesg(FITFileIdMesg())
        listener.onMesg(FITActivityMesg())
        listener.onMesg(FITSessionMesg())
        listener.onMesg(FITLapMesg())
        listener.onMesg(FITRecordMesg())

        XCTAssertEqual(listener.messages.getFileIdMesgs().count,1)
        XCTAssertEqual(listener.messages.getActivityMesgs().count,1)
        XCTAssertEqual(listener.messages.getSessionMesgs().count,1)
        XCTAssertEqual(listener.messages.getLapMesgs().count,1)
        XCTAssertEqual(listener.messages.getRecordMesgs().count,1)
    }


    static var allTests = [
        ("testDecoder",testDecoder),
        ("testDecoder",testListener)
    ]
}
*/
