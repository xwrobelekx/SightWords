//
//  StudyViewModel.swift
//  SightWords
//
//  Created by Kamil Wrobel on 1/27/22.
//

import Foundation
import CoreData
import SwiftUI



class StudyViewModel: ObservableObject {
    
    @Published var words: [SightWord] = []
    
    
//    func fetchSightWords(for deck: Deck){
//        
//        let request : NSFetchRequest<SightWord> = SightWord.fetchRequest()
//        //        request.fetchLimit = 30
//        request.sortDescriptors = [NSSortDescriptor(keyPath: \SightWord.dateCreated, ascending: false)]
//        request.predicate = NSPredicate(format: "deck == %@", deck)
//        
//        let fetchRequest: FetchRequest<SightWord> = FetchRequest<SightWord>(fetchRequest: request, animation: .easeIn(duration: 1.0))
//        
//        let fetchedWords = fetchRequest.wrappedValue
//        
//        words = fetchedWords.compactMap{$0 as SightWord}
//    }
    
    
    
    
    
    
    
    
}



