//
//  SightWord+Convenience.swift
//  SightWords
//
//  Created by Kamil Wrobel on 1/23/22.
//

import Foundation
import CoreData



extension SightWord {
    
    convenience init(word: String, deck: Deck, wrongCount: Int = 0, date: Date = Date(), context: NSManagedObjectContext = PersistenceController.shared.container.viewContext){
        self.init(context: context)
        self.word = word
        self.deck = deck
        self.wrongCount = Int64(wrongCount)
        self.dateCreated = date
    }
}
