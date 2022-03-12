//
//  StudyPage.swift
//  SightWords
//
//  Created by Kamil Wrobel on 1/21/22.
//

import SwiftUI
import CoreData



struct StudyPage: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: StudyViewModel
    var fetchRequest: FetchRequest<SightWord>
    @State var selection = 0
    @State var backgroundColor : Color = .white
    @State var showDoneView = false
    @State var showColorScreen = false
    @State var feedbackColor = Color.correct
    @State var dismissScreen = false
    
    var body: some View {
        ZStack{
            VStack(alignment: .center){
                
                HStack(){
                    Button(action: backButtonPressed, label: {
                        HStack{
                            Image(systemName: "chevron.backward")
                            Text("Back")
                        }
                        .withDefaultButtonFormatting(color: .blue, width: 75, height: 30)
                    }
                    )
                        .withPRessableStyle()
                        .padding()
                    Spacer()
                }
                
                TabView(selection: $selection){
                    if fetchRequest.wrappedValue.isEmpty {
                        Text("This collection is empty.")
                    } else {
                        ForEach(0..<fetchRequest.wrappedValue.count){ i in
                            WordView(word:  fetchRequest.wrappedValue[i])
                                .tag(fetchRequest.wrappedValue[i])
                                .environmentObject(viewModel)
                            
                        }
                    }
                }
                //.disabled(true) //when this is on it locks the swipe but it also locks the speach
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                
                Spacer()
                
                HStack{
                    Button(action: tryAgainButtonPressed, label: {
                        Text("Try again")
                            .padding()
                            .withDefaultButtonFormatting(color: .red)
                        
                    }
                    )
                        .withPRessableStyle()
                        .disabled(fetchRequest.wrappedValue.isEmpty)
                    
                    
                    
                    Button(action: goodButtonPRessed, label: {
                        Text("Good")
                            .padding()
                            .withDefaultButtonFormatting(color: .green)
                    }
                    )
                        .withPRessableStyle()
                        .disabled(fetchRequest.wrappedValue.isEmpty)
                    
                }.padding(.bottom)
                
        }.padding(.bottom)
            DonePopUp(showDoneView: $showDoneView, dismissManimSreen: $dismissScreen).onDisappear(perform: dismissStudyPage)
            ColorView(color: feedbackColor, showScreen: $showColorScreen)
        }.navigationBarHidden(true)
    }
    
    
    func backButtonPressed(){
        presentationMode.wrappedValue.dismiss()
    }
    
    
    
    func goodButtonPRessed(){
        Haptics.shared.play(.medium)
        print("Good Button Pressed")
        print("good  selection: \(selection)")
        
        let word = fetchRequest.wrappedValue[selection]
        word.wrongCount -= 1
        PersistenceController.shared.save()
        viewModel.wrongCount -= 1
        
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
    
    
    func tryAgainButtonPressed(){
        Haptics.shared.play(.medium)
        print("Try Again Button Pressed")
        
        print("bad selection: \(selection)")
        
        let mistakenWord = fetchRequest.wrappedValue[selection]
        mistakenWord.wrongCount += 1
        PersistenceController.shared.save()
        viewModel.wrongCount += 1
        
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
        #warning("Check this")
        //reload the page with new data when popup is dismissed
       // self.init(deck: viewModel.deck, request: viewModel.requestForWrongWords(deck: viewModel.deck!))
    }
    
//    
//    init(deck: Deck, request: FetchRequest<SightWord>){
//        fetchRequest = request
//        self.deck = deck
//    }
    
}

//
//struct StudyPage_Previews: PreviewProvider {
//    static var previews: some View {
//        StudyPage(deck: Deck(title: "NADA"))
////.previewInterfaceOrientation(.landscapeLeft)
//    }
//}
