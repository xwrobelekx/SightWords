//
//  DeckViewModel.swift
//  SightWords
//
//  Created by Kamil Wrobel on 1/27/22.
//

import SwiftUI
import CoreData


class DeckViewModel : ObservableObject {
    
    @Published var deck : Deck?
    @Published var wrongCount: Int = 0
    @Published var studyAgain: Bool = false
    
    
    func request(deck: Deck) -> FetchRequest<SightWord> {
        let request : NSFetchRequest<SightWord> = SightWord.fetchRequest()
        //        request.fetchLimit = 30
        request.sortDescriptors = [NSSortDescriptor(keyPath: \SightWord.dateCreated, ascending: false)]
        request.predicate = NSPredicate(format: "deck == %@", deck)
        return FetchRequest<SightWord>(fetchRequest: request, animation: .easeIn(duration: 1.0))
        
    }
    
    
    func requestForWrongWords(deck: Deck) -> FetchRequest<SightWord> {
        let request : NSFetchRequest<SightWord> = SightWord.fetchRequest()
        //        request.fetchLimit = 30
        request.sortDescriptors = []//[NSSortDescriptor(keyPath: \SightWord.dateCreated, ascending: false)]
        request.predicate = NSPredicate(format: "deck == %@ AND wrongCount >= %1", deck, 1)
        return FetchRequest<SightWord>(fetchRequest: request, animation: .easeIn(duration: 1.0))
        
    }
    
    
    
}
