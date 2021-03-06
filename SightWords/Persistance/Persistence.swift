//
//  Persistence.swift
//  SightWords
//
//  Created by Kamil Wrobel on 1/21/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = SightWord(context: viewContext)
            newItem.dateCreated = Date()
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

    let container: NSPersistentContainer


    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SightWords")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
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
    }
    
    
    func save(){
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("Error saving data to Core Data. Error: \(error.localizedDescription)")
            }
        }
    }
    
    func delete(deck: Deck){
        print("Deleting: words")
        deck.words?.forEach{word in
            container.viewContext.delete(word as! NSManagedObject)
        }
        container.viewContext.delete(deck)
        save()
    }
    
    func delete(word: SightWord){
        print("deleting word \(word.word)")
        container.viewContext.delete(word)
        save()
    }
}
