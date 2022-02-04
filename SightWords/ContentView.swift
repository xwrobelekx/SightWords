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
    
    let viewModel = DeckViewModel()
    

    
    
    @State var showAddNewDeck = false
    @State var showAddWord = false
    
    
    
    var body: some View {
        NavigationView {
            ZStack{
            List {
                ForEach(decks) { deck in
                    NavigationLink {
                        StudyPage(deck: deck)
                    } label: {
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 300, height: 70)
                            .foregroundColor(Color.green)
                            .overlay(
                        Text(deck.title ?? "empty")
                            .foregroundColor(.white)
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: showPopUp) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
                AddDeckView(showView: $showAddNewDeck)
                AddWord(showView: $showAddWord, deckViewModel: viewModel)
        
            }.onAppear(){
                
                decks.forEach{ deck in
                    print("✅ decks: \(deck.title)")
                }
              
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DeckView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
