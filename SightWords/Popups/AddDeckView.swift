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
        if showView {
            ZStack(alignment: .center){
                Color.black.opacity(0.7)
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 300, height: 250)
                    .foregroundColor(.popupBackground)
                    .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AngularGradient.gradient, lineWidth: 4)
                    .frame(width: 300, height: 250)
                    .overlay(
                        VStack{
                            Text("Add Deck")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .bold()
                            
                            HStack {
                                Text("Language: ")
                                    .foregroundColor(.white)
                                Picker("", selection: $language) {
                                    ForEach(Languages.allCases, id: \.self){ lang in
                                        switch lang {
                                        case .English :
                                            Text("English - US").tag(lang.rawValue)
                                        case .Spanish :
                                            Text("Spanish").tag(lang.rawValue)
                                        case .Polish :
                                            Text("Polish").tag(lang.rawValue)
                                        }
                                    }
                                }
                            }
                            TextField("title:", text: $deckTitle)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                                        
                            Button(action: addItem) {
                                Text(deckTitle == "" ? "Cancel" : "Save")
                                    .withDefaultButtonFormatting(color: deckTitle == "" ? .orange : .green, width: 80, height: 40)
                            }
                            .withPRessableStyle()
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
