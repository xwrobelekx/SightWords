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
        animation: .default) private var decks: FetchedResults<Deck>
    
    @State var viewModel : DeckViewModel
    
    @State var showAddNewDeck = false
    @State var editDecks = false
    
    
    let layout = [
        GridItem(.adaptive(minimum: 200, maximum: 200)),
        GridItem(.flexible(minimum: 50, maximum: 200))
    ]
    
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView{
                    LazyVGrid(columns: layout, spacing: 20) {
                        ForEach(decks) { deck in
                            NavigationLink {
                                StudyPreviewPage().environmentObject(StudyViewModel(deck: deck))
                            } label: {
                                ZStack {
                                    
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(AngularGradient.gradient, lineWidth: 4)
                                    .frame(height: 150)
                                    .overlay(
                                        VStack{
                                            Text(deck.title ?? "empty")
                                                .font(.title)
                                                .foregroundColor(.textColor)
                                                .padding()
                                        }
                                    )
                                    .padding()
        
                                    CloseCircle(showXButton: $editDecks).position(x: 170, y: 18)
                                        .onTapGesture {
                                            //deletee
                                            print("💧")
                                            delete(deck: deck)
                                        }
                                }
                                
                            }
                        }
                        
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: showPopUp) {
                            Label("Add Item", systemImage: "plus.circle")
                                .withDefaultButtonFormatting(color: showAddNewDeck ? .yellow : .green, width: 65, height: 35)
                            
                        }.withPRessableStyle()
                    }
                    ToolbarItem {
                        Button(action: edit) {
                            Label("Edit", systemImage: editDecks ? "gear.circle.fill" : "gear.circle")
                                .withDefaultButtonFormatting(color: editDecks ? .red : .green, width: 65, height: 35)
                            
                        }.withPRessableStyle()
                    }
                    
                }
                AddDeckView(showView: $showAddNewDeck)
            }.onAppear(){
                decks.forEach{ deck in
                    print("✅ decks: \(deck.title ?? "empty")")
                }
            }
        }
    }
    
    private func showPopUp(){
        withAnimation{
            showAddNewDeck.toggle()
        }
    }
    
    private func edit() {
        withAnimation{
            editDecks.toggle()
        }
    }
    
    private func delete(deck: Deck) {
        print("deleting deck: \(deck.title ?? "no title")")
        withAnimation {
            PersistenceController.shared.delete(deck: deck)
        }
    }
}





//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeckView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
