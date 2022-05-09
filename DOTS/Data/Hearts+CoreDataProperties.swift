//
//  Hearts+CoreDataProperties.swift
//  DOTS
//
//  Created by Claudio Cantieni on 09.05.22.
//
//

import Foundation
import CoreData


extension Hearts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hearts> {
        return NSFetchRequest<Hearts>(entityName: "Hearts")
    }

    @NSManaged public var hrv: NSNumber?
    @NSManaged public var rhr: NSNumber?
    @NSManaged public var timestamp: Date

}

extension Hearts : Identifiable {

}
