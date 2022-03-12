//
//  AddDeckView.swift
//  SightWords
//
//  Created by Kamil Wrobel on 1/21/22.
//

import SwiftUI

struct AddDeckView: View {
    
    @Binding var showView : Bool
    @State var deckTitle : String = ""
    @State var language : String = "en-US"
    
    var body: some View {
        // Circle()
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
                    //.foregroundColor(.black)
                    .overlay(
                        
                        VStack{
                            Picker("", selection: $language) {
                                ForEach(Languages.allCases, id: \.self){ lang in
                                    Text("\(lang.rawValue)").tag(lang.rawValue)
                                }
                            }
                            
                            Text("Add Deck")
                                .foregroundColor(.white)
                                .font(.title)
                                .bold()
                            
                            TextField("type the name of new collection", text: $deckTitle)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                            
                            
                            Button(action: addItem, label: {
                                Text(deckTitle == "" ? "Cancel" : "Save")
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
        withAnimation {
            if deckTitle != "" {
            let _ = Deck(title: deckTitle, language: language)
            PersistenceController.shared.save()
            }
            deckTitle = ""
            showView.toggle()
        }
    }

    
}

//struct AddDeckView_Previews: PreviewProvider {
//    static var previews: some View {
//        //@State var t = true
//        AddDeckView(showView: true, deckTitle: "")
//    }
//}
