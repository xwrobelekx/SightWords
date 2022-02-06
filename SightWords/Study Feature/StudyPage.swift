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
    @State var backgroundColor : Color = .white
    @State var showDoneView = false
    @State var showColorScreen = false
    @State var feedbackColor = Color.correct
    
    var body: some View {
        ZStack{
            VStack(alignment: .center){
                
                Text(deck.title ?? "")
                    .font(.title2)
                
                Spacer()
                TabView(selection: $selection){
                    if fetchRequest.wrappedValue.isEmpty {
                        Text("This collection is empty.")
                    } else {
                        
                        ForEach(0..<fetchRequest.wrappedValue.count){ i in
                           WordView(word:  fetchRequest.wrappedValue[i])
                                .tag(fetchRequest.wrappedValue[i])
                        }
                        
                    }
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                
                HStack{
                    Button(action: badButtonPRessed, label: {
                    Text("Try again")
                        .padding()
                    .withDefaultButtonFormatting(color: .red)
                }
                       )
                    .withPRessableStyle()
                    
                    
                
                Button(action: goodButtonPRessed, label: {
                        Text("Good")
                        .padding()
                        .withDefaultButtonFormatting(color: .green)
                    }
                )
                    .withPRessableStyle()
                
                
            }.padding(.bottom)
                
                
                
        }.padding(.bottom)
            DonePopUp(showDoneView: $showDoneView, viewModel: viewModel)
            ColorView(color: feedbackColor, showScreen: $showColorScreen)
        .onAppear(perform: lockScreenInLandscape)
        }
    
    }
    
    
    
    
    
    func goodButtonPRessed(){
        print("Good Button Pressed")
        feedbackColor = .correct
        showFeedbackScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
        if selection != fetchRequest.wrappedValue.count {
        selection += 1
        } else {
            //did all the words
            withAnimation{
                showDoneView.toggle()
            }
        }
        print(selection)
        }
    }
    
    
    func badButtonPRessed(){
        print("Try Again Button Pressed")
        feedbackColor = .incorrect
        showFeedbackScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
        if selection != fetchRequest.wrappedValue.count {
        selection += 1
        } else {
            //did all the words
            withAnimation{
                showDoneView.toggle()
            }
        }
        print(selection)
        }
    }
    
    
    func showFeedbackScreen(){
            showColorScreen.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation {
                showColorScreen.toggle()
            }
            
        }
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
