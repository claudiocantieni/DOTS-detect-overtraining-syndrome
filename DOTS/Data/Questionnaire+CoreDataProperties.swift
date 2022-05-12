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
    @NSManaged public var answer: NSSet?

}

// MARK: Generated accessors for answer
extension Questionnaire {

    @objc(addAnswerObject:)
    @NSManaged public func addToAnswer(_ value: Answers)

    @objc(removeAnswerObject:)
    @NSManaged public func removeFromAnswer(_ value: Answers)

    @objc(addAnswer:)
    @NSManaged public func addToAnswer(_ values: NSSet)

    @objc(removeAnswer:)
    @NSManaged public func removeFromAnswer(_ values: NSSet)

}

extension Questionnaire : Identifiable {

}
