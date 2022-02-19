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
                HStack{
                    Text(word.deck?.title! ?? "")
                        .font(.title2)
                        .padding()
                    Spacer()
                    
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(word.wrongCount == 0 ? .green
                                     : .orange)
                    .overlay(
                        Text("\(word.wrongCount)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                    )
                    .padding()
                }
                
                Spacer()
                
                Text(word.word ?? "..........")
                    .font(.largeTitle).scaleEffect(1.5)
                
                Spacer()
                
              
            }
        }.ignoresSafeArea()
        
        
    }
}

struct WordView_Previews: PreviewProvider {
    static var previews: some View {
        WordView(word: SightWord(word: "Example", deck: Deck(title: "Kamil")))
    }
}
