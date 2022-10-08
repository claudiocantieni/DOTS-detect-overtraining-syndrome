//
//  Model.swift
//  DOTS
//
//  Created by Claudio Cantieni on 03.10.22.
//

import Foundation
import CoreBluetooth

struct WeekLoads: Identifiable {
    
    var id: UUID
    var load: Double
    var timestamp: Date
    
}

struct WeekHeartsRhr: Identifiable {
    var id: UUID
    var rhr: Double
    var timestamp: Date
}

struct WeekHeartsHrv: Identifiable {
    var id: UUID
    var hrv: Double
    var timestamp: Date
}

struct Selected: Codable {

    // MARK: - Properties

    let id: [UUID]

    let name: String

}
