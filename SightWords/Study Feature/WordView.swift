//
//  WordView.swift
//  SightWords
//
//  Created by Kamil Wrobel on 1/23/22.
//

import SwiftUI

struct WordView: View {
    var word : SightWord
    let vm = StudyViewModel()
    
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
                    .foregroundColor(word.wrongCount <= 0 ? .green
                                     : .orange)
                    .overlay(
                        Text("\(word.wrongCount > 0 ? word.wrongCount : (word.wrongCount * -1))")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                    )
                    .padding()
                }
                
             
                
                Spacer()
                
                Text(word.word ?? "..........")
                    .font(.largeTitle)
                    .bold()
                    .scaledToFill()
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
    
                
                Button(action: speak, label: {
                        Image(systemName: "speaker.wave.2.circle")
                        .font(.largeTitle)
                        .padding()
                        //.withDefaultButtonFormatting(color: .green)
                    }
                )
                    .withPRessableStyle()
                
                Spacer()
              
            }
        }.ignoresSafeArea()
        
        
    }
    private func speak(){
        print("speak pressed")
        vm.speak(word: word.word ?? "")
    }
}

struct WordView_Previews: PreviewProvider {
    static var previews: some View {
        WordView(word: SightWord(word: "Examplesdfkkmmsffmkdkmdlsmflmldmflvmldkfsmfl", deck: Deck(title: "Kamil")))
    }
}
