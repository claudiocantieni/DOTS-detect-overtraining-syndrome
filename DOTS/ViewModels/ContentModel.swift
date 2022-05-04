//
//  ContentModel.swift
//  DOTS
//
//  Created by Claudio Cantieni on 06.04.22.
//

import Foundation
import SwiftUI

class ContentModel: ObservableObject {
    
    let managedObjectContext = PersistenceController.shared.container.viewContext
    
    @Published var modules = [Model]()
    
//    init() {
//        checkLoadedData()
//    }
//
//    func checkLoadedData() {
//
//        let status = UserDefaults.standard.bool(forKey: Constants.isDataPreloaded)
//
//        if status == false {
//            preloadLocalData()
//
//        }
//
//    }
//    func preloadLocalData() {
//        //Create arrays
//        for _ in 0...1 {
//            let hearts = Hearts(context: managedObjectContext)
//
//            hearts.rhr = 50
//            hearts.hrv = 100
//            hearts.timestamp = Date()
//        }
//        //Save to Core Data
//        do {
//            try managedObjectContext.save()
//
//            UserDefaults.standard.setValue(true, forKey: Constants.isDataPreloaded)
//        }
//        catch {
//        }
//    }
    
    static func getTimeData(selectedRange: Int, HRData:[Float]) -> [Double] {
        
        var HRDataDouble:[Double] = []
        
        for item in HRData[0..<selectedRange] {
            HRDataDouble.append(Double(item))
        
        }
        return HRDataDouble
    }
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
