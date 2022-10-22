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
    
    // Core Data for Hearts(rhr,hrv) is stored here, with different time spans
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
    
    // Core Data for answers of questionnaire
    @Published var questions: [Questionnaire] = []

    // Core Data for load
    @Published var loads7: [Loads] = []
    @Published var loads14: [Loads] = []
    @Published var loads28: [Loads] = []
    @Published var loads365: [Loads] = []
    @Published var loads0: [Loads] = []
    @Published var loadsToday: [Loads] = []
    
    // Data for weekly averages
    @Published var weekLoads = [WeekLoads]()
    @Published var weekHeartsRhr = [WeekHeartsRhr]()
    @Published var weekHeartsHrv = [WeekHeartsHrv]()
    var timer = Timer()
    init() {
        //createLoad()
        
        fetchHeartsFirst()
        
        fetchHearts()
        
        fetchQuestionnaire()
        
        fetchLoads()
        
        weekMeanLoads()
        
        weekMeanHeartsRhr()
        
        weekMeanHeartsHrv()
        
    }
    // All Fetch request for Hearts
    func fetchHearts() {
        let request = NSFetchRequest<Hearts>(entityName: "Hearts")
        let sort = NSSortDescriptor(key: "timestamp", ascending: true)
        let sortAll = NSSortDescriptor(key: "timestamp", ascending: false)
        
        // different predicates for all timespans from different timestamps
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
    
    // Fetchrequest for predicates of other fetchRequest
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
    // Fetch Request for Questionnaire
    func fetchQuestionnaire() {
        let request = NSFetchRequest<Questionnaire>(entityName: "Questionnaire")
        let sort = NSSortDescriptor(key: "timestamp", ascending: false)
        
        // Data of questionnaire is icluded from load for 14 days
        let predicate = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -14, to: NSDate() as Date)!) as CVarArg, NSDate())
        
        
        request.sortDescriptors = [sort]
        request.predicate = predicate
        request.fetchLimit = 1
        do {
             questions = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
        
        
    }
    
    // Fetch Request for Load/Shape
    func fetchLoads() {
        let request = NSFetchRequest<Loads>(entityName: "Loads")
        let sort = NSSortDescriptor(key: "timestamp", ascending: true)
        let sortToday = NSSortDescriptor(key: "timestamp", ascending: false)
        
        // different predicates for all timespans from different timestamps
        let predicate7 = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -6, to: NSDate() as Date)!) as CVarArg, NSDate())
        let predicate14 = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -13, to: NSDate() as Date)!) as CVarArg, NSDate())
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
        request.predicate = predicate14
        do {
            loads14 = try managedObjectContext.fetch(request)
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
    
    // needed creation of arrays before ios 16
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
        // returns an array for the old graphs
        return hrArray
    }
    // needed creation of arrays before ios 16
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
        // returns an array for the old graphs
        return hrArray
    }
    // creates the timestamps which belong to the data from createArrayRhr
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
    // creates the timestamps which belong to the data from createArrayHrv
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
    // < ios 16
    func createTodayRhr() -> Double {
    var HrToday:Double = 0
        for f in hearts0 {
            if f.rhr != nil {
                HrToday = f.rhr as! Double
            }
        }
        return HrToday
    }
    // < ios 16
    func createTodayHrv() -> Double {
    var HrToday:Double = 0
        for f in hearts0 {
            if f.hrv != nil {
                HrToday = f.hrv as! Double
            }
        }
        return HrToday
    }
    // < ios 16
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
    // < ios 16
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
    // < ios 16
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
    // < ios 16
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
    // to sum up the answers from the questionnaire
    func calculateTotalQuestionnaire() -> Int {
        var sum:Int = 0
        for i in questions {
            for item in i.answers {
                sum += item
            }
        }
        
        
        return sum
        
        
    }
    // calculate the daily load
    func calculateLoad() -> Double {
        // 0...3
        var loadSum:Double = 0
        // Questionnaire
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
        // RHR with all percentages
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
        // HRV with different percentages
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
        // get average
        let load = loadSum / 3
        
        return load
    }
    // get the first Date of Input for Rhr
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
    // get the first Date of Input for Hrv
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
    // get last timestamp of questionnaire
    func timestampQuestionnaire() -> Date {
        var timestamp:Date?
        for i in questions {
            
            timestamp = i.timestamp
            
        }
        return timestamp ?? NSCalendar.current.date(byAdding: .day, value: -10, to: NSDate() as Date)!
    }
    // get last timestamp of Rhr
    func lastTimestampRhr() -> Date {
        var timestamp:Date?
        for i in hearts365 {
            if i.rhr != nil {
                timestamp = i.timestamp
            }
        }
        return timestamp ?? NSCalendar.current.date(byAdding: .day, value: -10, to: NSDate() as Date)!
    }
    // get last timestamp of Hrv
    func lastTimestampHrv() -> Date {
        var timestamp:Date?
        for i in hearts365 {
            if i.hrv != nil {
                timestamp = i.timestamp
            }
        }
        return timestamp ?? NSCalendar.current.date(byAdding: .day, value: -10, to: NSDate() as Date)!
    }
    
    
    // create daily load
    func createTodayLoad() -> Double {
    var loadToday:Double = 0
        for f in loadsToday {
            
                loadToday = f.load
            
        }
        return loadToday
    }
    
    // calculate average load for < ios 16
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
    
    // calculate average load for < ios 16
    func calculateMeanLoad14() -> Double {
        var array:[Double] = []
        for f in loads14 {
            
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
    
    // calculate average load for < ios 16
    func calculateMeanLoad28() -> Double {
        var array:[Double] = []
        for f in loads28 {
            
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
    
    // create arrays for < ios 16
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
    
    // create timestamps arrays for createArrayLoad
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
    
    // save daily Load/Form to Core Data
    func createLoad() {
       
        let loads = Loads(context: managedObjectContext)
        // save only once a day
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
    
    // calculate the base for Rhr
    func calculateRhrBase() -> Double {
        
        var array:[Double] = []
        var date = firstInputRhr() as Date
        let calendar = Calendar.current

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: date as Date)
        let date2 = calendar.startOfDay(for: Date())

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        let range = 1...components.day! - 14
        // get for every data the array for the data - 14
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
            // get the array for the data -14
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
            
            // only valid if more than 5 numbers, to not have random numbers
            if arrayrhr.count >= 5 {
                array.append(Double(mean))
            }
                         
            date = Calendar.current.date(byAdding: .day, value: 1, to: date as Date)!
        }
        // get the lowest of the array
        let min = array.min() ?? 0
        return min
    }
    
    // calculate the base for Hrv
    // exactly same logic as calculateRhrBase
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
    
    // delete one data row at a time for DeleteList
    func deleteHearts(at offsets: IndexSet) {
        for offset in offsets {
            let hr = heartsAll[offset]
            managedObjectContext.delete(hr)
        }
        
        try? managedObjectContext.save()
        
        fetchHearts()
        fetchHeartsFirst()
        
        
        
    }
    
    // create weekly averages for Load/Form
    func weekMeanLoads() {
        var array:[Double] = []
        var endOfWeek: Date?
        for i in loads365 {
            
                let weekday = Calendar.current.component(.weekday, from: i.timestamp)
                // when end of week is reached -> make array
                if endOfWeek ?? NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 2, to: i.timestamp)!) <= NSCalendar.current.startOfDay(for: i.timestamp)  {
                    
                    
                    let sum = array.reduce(0, { a, b in
                        return a + b
                    })
                    
                    let mean = Double(sum) / Double(array.count)
                    let meanRound = Double(round(100 * mean) / 100)
                   
                    
                    weekLoads.append(WeekLoads(id: UUID(), load: meanRound, timestamp: endOfWeek!))
                    array = []
                    
                    
                }
            
                if weekday == 1 {
                    // set end of the week and save to array, for every day
                        array.append(i.load)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 7, to: i.timestamp)!)
                    
                }
                else if weekday == 2 {
                    
                        array.append(i.load)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 6, to: i.timestamp)!)
                   
                }
                else if weekday == 3 {
                    
                        array.append(i.load)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 5, to: i.timestamp)!)
                   
                }
                else if weekday == 4 {
                    
                        array.append(i.load)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 4, to: i.timestamp)!)
                   
                }
                else if weekday == 5 {
                    
                        array.append(i.load)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 3, to: i.timestamp)!)
                   
                }
                else if weekday == 6 {
                    
                        array.append(i.load)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 2, to: i.timestamp)!)
                   
                }
                else if weekday == 7 {
                    
                        array.append(i.load)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 1, to: i.timestamp)!)
                   
                }
                
            
            
            
            
            
        }
    }
    
    // create weekly averages for Rhr
    func weekMeanHeartsRhr() {
    
        var array:[Double] = []
        var endOfWeek: Date?
        for i in hearts365 {
            if i.rhr != nil {
                let weekday = Calendar.current.component(.weekday, from: i.timestamp)
                // when end of week is reached -> make array
                if endOfWeek ?? NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 2, to: i.timestamp)!) <= NSCalendar.current.startOfDay(for: i.timestamp)  {
                    
                    
                    let sum = array.reduce(0, { a, b in
                        return a + b
                    })
                    
                    let mean = Double(sum) / Double(array.count)
                    let meanRound = Double(round(100 * mean) / 100)
                   
                    
                    weekHeartsRhr.append(WeekHeartsRhr(id: UUID(), rhr: meanRound, timestamp: endOfWeek!))
                    array = []
                    
                    
                }
            
                if weekday == 1 {
                    // set end of the week and save to array, for every day
                        array.append(i.rhr as! Double)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 7, to: i.timestamp)!)
                    
                }
                else if weekday == 2 {
                    
                        array.append(i.rhr as! Double)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 6, to: i.timestamp)!)
                   
                }
                else if weekday == 3 {
                    
                        array.append(i.rhr as! Double)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 5, to: i.timestamp)!)
                   
                }
                else if weekday == 4 {
                    
                        array.append(i.rhr as! Double)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 4, to: i.timestamp)!)
                   
                }
                else if weekday == 5 {
                    
                        array.append(i.rhr as! Double)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 3, to: i.timestamp)!)
                   
                }
                else if weekday == 6 {
                    
                        array.append(i.rhr as! Double)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 2, to: i.timestamp)!)
                   
                }
                else if weekday == 7 {
                    
                        array.append(i.rhr as! Double)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 1, to: i.timestamp)!)
                   
                }
                
            }
            
            
            
            
        }
    }
    // create weekly averages for Hrv
    func weekMeanHeartsHrv() {
    
        var array:[Double] = []
        var endOfWeek: Date?
        for i in hearts365 {
            if i.hrv != nil {
                let weekday = Calendar.current.component(.weekday, from: i.timestamp)
                // when end of week is reached -> make array
                if endOfWeek ?? NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 2, to: i.timestamp)!) <= NSCalendar.current.startOfDay(for: i.timestamp)  {
                    
                    
                    let sum = array.reduce(0, { a, b in
                        return a + b
                    })
                    
                    let mean = Double(sum) / Double(array.count)
                    let meanRound = Double(round(100 * mean) / 100)
                   
                    
                    weekHeartsHrv.append(WeekHeartsHrv(id: UUID(), hrv: meanRound, timestamp: endOfWeek!))
                    array = []
                    
                    
                }
            
                if weekday == 1 {
                    // set end of the week and save to array, for every day
                        array.append(i.hrv as! Double)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 7, to: i.timestamp)!)
                    
                }
                else if weekday == 2 {
                    
                        array.append(i.hrv as! Double)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 6, to: i.timestamp)!)
                   
                }
                else if weekday == 3 {
                    
                        array.append(i.hrv as! Double)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 5, to: i.timestamp)!)
                   
                }
                else if weekday == 4 {
                    
                        array.append(i.hrv as! Double)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 4, to: i.timestamp)!)
                   
                }
                else if weekday == 5 {
                    
                        array.append(i.hrv as! Double)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 3, to: i.timestamp)!)
                   
                }
                else if weekday == 6 {
                    
                        array.append(i.hrv as! Double)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 2, to: i.timestamp)!)
                   
                }
                else if weekday == 7 {
                    
                        array.append(i.hrv as! Double)
                    endOfWeek = NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 1, to: i.timestamp)!)
                   
                }
                
            }
            
            
            
            
        }
    }
    
}


