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
        ZStack{
            VStack{
        Text(word.word ?? "..........")
            .font(.largeTitle).scaleEffect(1.5)
                Text("wrong count: \(word.wrongCount)")
            }
        }.ignoresSafeArea()
            
        
    }
}

struct WordView_Previews: PreviewProvider {
    static var previews: some View {
        WordView(word: SightWord(word: "Example", deck: Deck(title: "Kamil")))
    }
}
