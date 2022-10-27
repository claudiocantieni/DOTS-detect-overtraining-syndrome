//
//  Persistence.swift
//  Core data demo
//
//  Created by Claudio Cantieni on 01.05.22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Hearts(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Core Data Model")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("Unresolved error")
        }
        description.setOption(true as NSObject, forKey:
        NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.processUpdate), name: .NSPersistentStoreRemoteChange, object: nil)
        
    }
    
//    @objc
//    func processUpdate(notification: NSNotification) {
//        operationQueue.addOperation {
//            let context = self.container.newBackgroundContext()
//            context.performAndWait {
//                let hearts: [Hearts]
//                let quest: [Questionnaire]
//                let loads: [Loads]
//                do {
//                    try hearts = context.fetch(Hearts.fetchRequest())
//                    try quest = context.fetch(Questionnaire.fetchRequest())
//                    try loads = context.fetch(Loads.fetchRequest())
//                } catch {
//                    let nserror = error as NSError
//                    fatalError("Unresolved error \(nserror)")
//                }
//
//
//
//                if context.hasChanges {
//                    do {
//                        try context.save()
//
//                    } catch {
//                        let nserror = error as NSError
//                        fatalError("Unresolved error \(nserror)")
//                    }
//                }
//            }
//        }
//    }
    
//
//    lazy var operationQueue: OperationQueue = {
//        var queue = OperationQueue()
//        queue.maxConcurrentOperationCount = 1
//        return queue
//    }()
}
