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
    //    @State var showAddWord = false
    
    
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
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(AngularGradient.gradient, lineWidth: 4)
                                    .frame(height: 150)
                                //.foregroundColor(Color.green)
                                    .overlay(
                                        VStack{
                                            Text(deck.title ?? "empty")
                                                .font(.title)
                                                .foregroundColor(.textColor)
                                                .padding()
                                        }
                                    )
                                    .padding()
                                
                            }
                        }
                        
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: showPopUp) {
                            Label("Add Item", systemImage: "plus.circle")
                                .withDefaultButtonFormatting(color: .green, width: 65, height: 35)
                            
                        }.withPRessableStyle()
                    }
                    ToolbarItem {
                        EditButton()
                            .withDefaultButtonFormatting(color: .yellow, width: 65, height: 35)
                            .withPRessableStyle()
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
