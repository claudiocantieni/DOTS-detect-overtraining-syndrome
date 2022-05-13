//
//  Questionnaire+CoreDataProperties.swift
//  DOTS
//
//  Created by Claudio Cantieni on 12.05.22.
//
//

import Foundation
import CoreData


extension Questionnaire {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Questionnaire> {
        return NSFetchRequest<Questionnaire>(entityName: "Questionnaire")
    }

    @NSManaged public var answers: [Int]
    @NSManaged public var timestamp: Date

}

extension Questionnaire : Identifiable {

}
