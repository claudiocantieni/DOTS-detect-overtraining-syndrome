//
//  Hearts+CoreDataProperties.swift
//  DOTS
//
//  Created by Claudio Cantieni on 04.05.22.
//
//

import Foundation
import CoreData


extension Hearts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hearts> {
        return NSFetchRequest<Hearts>(entityName: "Hearts")
    }

    @NSManaged public var timestamp: Date
    @NSManaged public var hrv: Float
    @NSManaged public var rhr: Float

}

extension Hearts : Identifiable {

}
