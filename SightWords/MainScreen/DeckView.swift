//
//  ContentView.swift
//  SightWords
//
//  Created by Kamil Wrobel on 1/21/22.
//

import SwiftUI
import CoreData

struct DeckView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Deck.dateCreated, ascending: true)],
        animation: .default)
    
    private var decks: FetchedResults<Deck>
    @State var viewModel : DeckViewModel
    
    @State var showAddNewDeck = false
    @State var showAddWord = false
    
    let layout = [
        GridItem(.adaptive(minimum: 300)),
        //GridItem(.adaptive(minimum: 140))
    ]
    
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView{
                LazyVGrid(columns: layout, spacing: 20) {
                    ForEach(decks) { deck in
                        NavigationLink {
                            StudyPage(deck: deck, request: viewModel.request(deck: deck))
                        } label: {

                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 80)
                                .foregroundColor(Color.green)
                                .overlay(
                                    HStack{
                                        Button(action: showAddWordPopUp) {
                                            Label("", systemImage: "plus.circle")
                                                .withDefaultButtonFormatting(color: .green, width: 100, height: 50)
                                            
                                        }.withPRessableStyle()
                                        
                                        Spacer()
                                        
                                        Text(deck.title ?? "empty")
                                            .font(.title)
                                            .foregroundColor(.white)
                                            .padding()
                                    }
                                )
                            
                        }
                        .swipeActions(edge: .leading){
                            Button(role: .cancel, action: {
                                viewModel.deck = deck
                                showAddWordPopUp()
                            }, label: {
                                Image(systemName: "plus.circle.fill")
                            })
                                .tint(.teal)
                            
                        }
                    }
                    .onDelete(perform: deleteItems)
                    
                }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                            .withDefaultButtonFormatting(color: .yellow, width: 65, height: 35)
                            .withPRessableStyle()
                    }
                    ToolbarItem {
                        Button(action: showPopUp) {
                            Label("Add Item", systemImage: "plus.circle")
                                .withDefaultButtonFormatting(color: .green, width: 50, height: 35)
                                
                        }.withPRessableStyle()
                    }
                }
                AddDeckView(showView: $showAddNewDeck)
                AddWord(showView: $showAddWord, deckViewModel: viewModel)
                if let deck = viewModel.deck{
                NavigationLink(destination: StudyPage(deck: deck, request: viewModel.request(deck: deck)), isActive: $viewModel.studyAgain) {
                    
                    
                }
                }
                
            }.onAppear(){
                
                decks.forEach{ deck in
                    print("✅ decks: \(deck.title)")
                }
                
                
//                if viewModel.studyAgain {
//                    NavigationLink {
//                        StudyPage(deck: viewModel.deck!, request: viewModel.requestForWrongWords(deck: viewModel.deck!))
//                    } label: {
//                        Text("Study Again")
//                    }
//                }
                
            }
        }
    }
    
    func leadingAction(){
        
    }
    
    private func cool (){
        print("Cool")
    }
    
    
    
    private func showPopUp(){
        withAnimation{
            showAddNewDeck.toggle()
        }
    }
    
    private func showAddWordPopUp(){
        withAnimation{
            showAddWord.toggle()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { decks[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.save()
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeckView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
