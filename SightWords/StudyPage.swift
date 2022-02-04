//
//  StudyPage.swift
//  SightWords
//
//  Created by Kamil Wrobel on 1/21/22.
//

import SwiftUI
import CoreData

struct StudyPage: View {
    
    var fetchRequest: FetchRequest<SightWord>

    @StateObject var viewModel = StudyViewModel()
    var deck : Deck
    
    @State var selection = 0
    
    var body: some View {
        VStack(alignment: .center){
            
            Text(deck.title ?? "").bold()
                .font(.title)
            
            Spacer()
            TabView(selection: $selection){
                if fetchRequest.wrappedValue.isEmpty {
                    Text("No Words in this collection.")
                } else {
                ForEach(fetchRequest.wrappedValue, id: \.dateCreated) { word in
                    WordView(word: word)
                }

                }
            
            }.tabViewStyle(PageTabViewStyle())
            
            HStack{
                Button("Bad", action: badButtonPRessed)
                Button("Medium", action: mediumButtonPRessed)
                Button("Good", action: goodButtonPRessed)
                
            }.padding(.bottom)
        }
        .onAppear(perform: lockScreenInLandscape)
    }
    
    
    
    
    
    
    func goodButtonPRessed(){
        print("Good Button Pressed")
    }
    
    func mediumButtonPRessed(){
        print("Medium Button Pressed")
    }
    
    func badButtonPRessed(){
        print("Bad Button Pressed")
    }
    
    func lockScreenInLandscape(){
        //figure how to set the orientation to landscape
//        fetchRequest.wrappedValue.forEach{ word in
//            print("🟢 \(word.word)")
//        }
     //   viewModel.fetchSightWords(for: deck)
       
        
    }
    
    
    init(deck: Deck){
        let request : NSFetchRequest<SightWord> = SightWord.fetchRequest()
//        request.fetchLimit = 30
        request.sortDescriptors = [NSSortDescriptor(keyPath: \SightWord.dateCreated, ascending: false)]
        request.predicate = NSPredicate(format: "deck == %@", deck)
        
        fetchRequest = FetchRequest<SightWord>(fetchRequest: request, animation: .easeIn(duration: 1.0))

        self.deck = deck
    }
    
}

struct StudyPage_Previews: PreviewProvider {
    static var previews: some View {
        StudyPage(deck: Deck(title: "NADA"))
//.previewInterfaceOrientation(.landscapeLeft)
    }
}
