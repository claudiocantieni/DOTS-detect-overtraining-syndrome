//
//  Answers+CoreDataProperties.swift
//  DOTS
//
//  Created by Claudio Cantieni on 12.05.22.
//
//

import Foundation
import CoreData


extension Answers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Answers> {
        return NSFetchRequest<Answers>(entityName: "Answers")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var answer: Int
    @NSManaged public var questionnaire: Questionnaire?

}

extension Answers : Identifiable {

}
