//
//  StudyViewModel.swift
//  SightWords
//
//  Created by Kamil Wrobel on 1/27/22.
//

import Foundation
import CoreData
import SwiftUI
import AVFoundation



class StudyViewModel: ObservableObject {
    
    @Published var words: [SightWord] = []
    @Published var deck : Deck?
    @Published var wrongCount: Int = 0
    @Published var studyAgain: Bool = false
    @Published var requestt: FetchRequest<SightWord>
    
    
    init(deck: Deck) {
        self.deck = deck
        self.requestt = {
            let request : NSFetchRequest<SightWord> = SightWord.fetchRequest()
            //        request.fetchLimit = 30
            request.sortDescriptors = [NSSortDescriptor(keyPath: \SightWord.dateCreated, ascending: false)]
            print("🟠➡︎ Fetching Data for deck: \(deck.title)")
            request.predicate = NSPredicate(format: "deck == %@", deck)
            return FetchRequest<SightWord>(fetchRequest: request, animation: .easeIn(duration: 1.0))
        }()
        
    }
    
    
    
    func speak(word: String, language: String = "en-US"){
        
        let uttersnce = AVSpeechUtterance(string: word)
        uttersnce.voice = AVSpeechSynthesisVoice(language: language)
        uttersnce.rate = 0.5
        
        let synthetizer = AVSpeechSynthesizer()
        synthetizer.speak(uttersnce)
        
    }
    
    func request() -> FetchRequest<SightWord> {
        let request : NSFetchRequest<SightWord> = SightWord.fetchRequest()
        //        request.fetchLimit = 30
        request.sortDescriptors = [NSSortDescriptor(keyPath: \SightWord.dateCreated, ascending: false)]
        print("🟣 fetching words for deck: \(deck?.title)")
        if let deck = deck {
        request.predicate = NSPredicate(format: "deck == %@", deck)
        }
        return FetchRequest<SightWord>(fetchRequest: request, animation: .easeIn(duration: 1.0))
        
    }
    
    
    func requestForWrongWords() -> FetchRequest<SightWord> {
        let request : NSFetchRequest<SightWord> = SightWord.fetchRequest()
        //        request.fetchLimit = 30
        request.sortDescriptors = []//[NSSortDescriptor(keyPath: \SightWord.dateCreated, ascending: false)]
        if let deck = deck {
        request.predicate = NSPredicate(format: "deck == %@ AND wrongCount >= %1", deck, 1)
        }
        return FetchRequest<SightWord>(fetchRequest: request, animation: .easeIn(duration: 1.0))
        
    }
    
    

    
    
    
}



