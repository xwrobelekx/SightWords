//
//  WordView.swift
//  SightWords
//
//  Created by Kamil Wrobel on 1/23/22.
//

import SwiftUI

struct WordView: View {
    var word : SightWord
    
    var body: some View {
        Text(word.word ?? "..........")
            .font(.title)
        
    }
}

struct WordView_Previews: PreviewProvider {
    static var previews: some View {
        WordView(word: SightWord(word: "Example", deck: Deck(title: "KAmil")))
    }
}
