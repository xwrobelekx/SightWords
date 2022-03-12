//
//  Deck+Convenience.swift
//  SightWords
//
//  Created by Kamil Wrobel on 1/21/22.
//

import Foundation
import CoreData



extension Deck {
    
    convenience init(title: String, language: String = "en-US", created: Date = Date(), context: NSManagedObjectContext =  PersistenceController.shared.container.viewContext){
        self.init(context: context)
        self.language = language
        self.dateCreated = created
        self.title = title
    }
}
