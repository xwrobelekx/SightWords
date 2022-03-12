//
//  AddWord.swift
//  SightWords
//
//  Created by Kamil Wrobel on 1/23/22.
//

import SwiftUI

struct AddWord: View {
    
    @Binding var showView : Bool
    @State var word : String = ""
    //var deckViewModel : DeckViewModel
    @EnvironmentObject private var viewModel: StudyViewModel

    
    var body: some View {
        if showView {
            ZStack(alignment: .center){
                Color.black.opacity(0.7)
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 300, height: 250)
                    .foregroundColor(.black)
                    .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AngularGradient.gradient, lineWidth: 4)
                    .frame(width: 300, height: 250)
                    .overlay(
                        
                        VStack{
                            Text("Add New Word")
                                .foregroundColor(.white)
                                .font(.title)
                                .bold()
                            
                            TextField("", text: $word)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                            Button(action: addItem, label: {
                                Text(word == "" ? "Cancel" : "Save")
                                    .foregroundColor(.white)
                            })
                                .frame(width: 100)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(.infinity)
                            
                        })
                )
                
            }.ignoresSafeArea()
        }
        
    }
    
    private func addItem() {
        print("word: \(word)")
        
        if word != "" {
            if let deck = viewModel.deck {
                let word = SightWord(word: word, deck: deck)
                print("word: \(word.word) \(deck.title)")
                PersistenceController.shared.save()
            }
        }
        word = ""
        showView.toggle()
        
    }
}

//struct AddWord_Previews: PreviewProvider {
//    static var previews: some View {
//        AddWord(s,\ deckViewModel: DeckViewModel())
//    }
//}
