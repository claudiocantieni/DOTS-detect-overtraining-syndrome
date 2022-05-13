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
    @Published var hearts28: [Hearts] = []
    @Published var hearts365: [Hearts] = []
    @Published var heartsfirst: [Hearts] = []
    @Published var heartsrhrbase: [Hearts] = []
    @Published var heartshrvbase: [Hearts] = []
    @Published var questions: [Questionnaire] = []
    
 //   @Published var models = [Model]()
    init() {
       // self.models = ContentModel.getLocalData()
        fetchHeartsFirst()
        
        fetchHearts()
        
        fetchQuestionnaire()
    }
    func fetchHearts() {
        let request = NSFetchRequest<Hearts>(entityName: "Hearts")
        let sort = NSSortDescriptor(key: "timestamp", ascending: true)
        
        let predicate7 = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)!) as CVarArg, NSDate())
        let predicate28 = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -28, to: NSDate() as Date)!) as CVarArg, NSDate())
        let predicate365 = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -365, to: NSDate() as Date)!) as CVarArg, NSDate())
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
        
        request.sortDescriptors = [sortfirst]
        request.fetchLimit = 1
        do {
             heartsfirst = try managedObjectContext.fetch(request)
        }
        catch {
            
        }
    }
    
    func fetchQuestionnaire() {
        let request = NSFetchRequest<Questionnaire>(entityName: "Questionnaire")
        let sort = NSSortDescriptor(key: "timestamp", ascending: false)
        let predicate = NSPredicate(format:"(timestamp >= %@) AND (timestamp < %@)", NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)!) as CVarArg, NSDate())
        
        request.sortDescriptors = [sort]
        request.predicate = predicate
        request.fetchLimit = 1
        do {
             questions = try managedObjectContext.fetch(request)
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
    func calculateRhrBase() -> Double {
        var array:[Double] = []
        for f in heartsrhrbase {
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

    func calculateHrvBase() -> Double{
        var array:[Double] = []
        for f in heartshrvbase {
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
        else if calculateTotalQuestionnaire() >= 20 {
            loadSum += 0.6666667
        }
        else if calculateTotalQuestionnaire() >= 15 {
            loadSum += 0.3333333
        }
        else if calculateTotalQuestionnaire() < 15 {
            loadSum += 0
        }
        if calculateMeanRhr() <= calculateRhrBase() {
            loadSum += 1
        }
        else if calculateMeanRhr() <= calculateRhrBase() * 1.05 {
            loadSum += 0.6666667
        }
        else if calculateMeanRhr() <= calculateRhrBase() * 1.07 {
            loadSum += 0.3333333
        }
        else if calculateMeanRhr() > calculateRhrBase() * 1.07 {
            loadSum += 0
        }
        if calculateMeanHrv() >= calculateHrvBase() {
            loadSum += 1
        }
        else if calculateMeanHrv() >= calculateHrvBase() / 1.05 {
            loadSum += 0.6666667
        }
        else if calculateMeanHrv() >= calculateHrvBase() / 1.07 {
            loadSum += 0.3333333
        }
        else if calculateMeanHrv() < calculateHrvBase() / 1.07 {
            loadSum += 0
        }
        let load = loadSum / 3
        
        return load
    }
// watch viedeo cwc preload data first time?
 //get first date and insert it in top as byAdding(.day)
    func firstInputRhr() -> NSDate {
        var firstDate:Date?
        for i in heartsfirst {
            if i.rhr != nil {
                firstDate = i.timestamp
            }
        }
        return firstDate! as NSDate
    }
    func firstInputHrv() -> NSDate {
        var firstDate:Date?
        for i in heartsfirst {
            if i.hrv != nil {
                firstDate = i.timestamp
            }
        }
        return firstDate! as NSDate
    }
    
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
