//
//  SightWordsApp.swift
//  SightWords
//
//  Created by Kamil Wrobel on 1/21/22.
//

import SwiftUI

@main
struct SightWordsApp: App {
   
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            //StudyPage(word: SightWord())
        
            DeckView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
