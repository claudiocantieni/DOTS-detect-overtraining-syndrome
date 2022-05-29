//
//  Loads+CoreDataProperties.swift
//  DOTS
//
//  Created by Claudio Cantieni on 29.05.22.
//
//

import Foundation
import CoreData


extension Loads {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Loads> {
        return NSFetchRequest<Loads>(entityName: "Loads")
    }

    @NSManaged public var load: Double
    @NSManaged public var timestamp: Date

}

extension Loads : Identifiable {

}
