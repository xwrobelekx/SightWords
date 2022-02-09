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
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = StudyViewModel()
    var deck : Deck
    @State var selection = 0
    @State var backgroundColor : Color = .white
    @State var showDoneView = false
    @State var showColorScreen = false
    @State var feedbackColor = Color.correct
    @State var dismissScreen = false
    
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
                .disabled(true)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                
                HStack{
                    Button(action: badButtonPressed, label: {
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
            DonePopUp(showDoneView: $showDoneView, viewModel: viewModel, dismissManimSreen: $dismissScreen).onDisappear(perform: dismissStudyPage)
            ColorView(color: feedbackColor, showScreen: $showColorScreen)
        }
    
    }
    
    
    
    
    
    func goodButtonPRessed(){
        Haptics.shared.play(.medium)
        print("Good Button Pressed")
        print("good  selection: \(selection)")
        
        let word = fetchRequest.wrappedValue[selection]
        if word.wrongCount >= 1 {
            word.wrongCount -= 1
            PersistenceController.shared.save()
        }
        
        
        feedbackColor = .correct
        showFeedbackScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
        if selection != fetchRequest.wrappedValue.count - 1 {
        selection += 1
        } else {
            //did all the words
            withAnimation{
                showDoneView.toggle()
                dismissScreen.toggle()
            }
        }
        print(selection)
        }
    }
    
    
    func badButtonPressed(){
        Haptics.shared.play(.medium)
        print("Try Again Button Pressed")
        
        print("bad selection: \(selection)")
        
        let mistakenWord = fetchRequest.wrappedValue[selection]
        mistakenWord.wrongCount += 1
        PersistenceController.shared.save()
        
        feedbackColor = .incorrect
        showFeedbackScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
        if selection != fetchRequest.wrappedValue.count - 1 {
        selection += 1
        } else {
            //did all the words
            withAnimation{
                showDoneView.toggle()
                dismissScreen.toggle()
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
    
    func dismissStudyPage(){
        if dismissScreen {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    
    init(deck: Deck, request: FetchRequest<SightWord>){
//        let request : NSFetchRequest<SightWord> = SightWord.fetchRequest()
////        request.fetchLimit = 30
//        request.sortDescriptors = [NSSortDescriptor(keyPath: \SightWord.dateCreated, ascending: false)]
//        request.predicate = NSPredicate(format: "deck == %@", deck)
//        fetchRequest = FetchRequest<SightWord>(fetchRequest: request, animation: .easeIn(duration: 1.0))
        
        fetchRequest = request

        self.deck = deck
    }
    
}
//
//struct StudyPage_Previews: PreviewProvider {
//    static var previews: some View {
//        StudyPage(deck: Deck(title: "NADA"))
////.previewInterfaceOrientation(.landscapeLeft)
//    }
//}
