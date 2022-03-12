//
//  StudyPreviewPage.swift
//  SightWords
//
//  Created by Kamil Wrobel on 3/12/22.
//

import SwiftUI

struct StudyPreviewPage: View {
    
    @EnvironmentObject private var viewModel: StudyViewModel
    @State var showAddWord = false
    
    var body: some View {
        ZStack{
            VStack(spacing: 20){
                
                Text(viewModel.deck?.title ?? "empty")
                    .font(.largeTitle)
                Text("Language: \(viewModel.deck?.language ?? "empty")")
                    .font(.title2)
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AngularGradient.gradient, lineWidth: 4)
                    .frame(width: 300, height: 200)
                    .overlay(Text("Calendar View?"))
                
                Spacer()
                HStack{
                    Button(action: showAddWordPopUp, label: {
                        Text("Add Word")
                            .padding()
                            .withDefaultButtonFormatting(color: .green)
                        
                    }
                    )
                        .withPRessableStyle()
                    
                    NavigationLink() {
                        StudyPage(fetchRequest: viewModel.request()).environmentObject(viewModel)
                    } label: {
                        Text("Study")
                            .padding()
                            .withDefaultButtonFormatting(color: .green)
                    }
                    
                }.padding(.bottom)
                Spacer()
                
            }
            AddWord(showView: $showAddWord).environmentObject(viewModel)
            
        }
    }
    
    
    
    private func showAddWordPopUp(){
        withAnimation{
            showAddWord.toggle()
        }
    }
    
}

struct StudyPreviewPage_Previews: PreviewProvider {
    static var previews: some View {
        StudyPreviewPage()
    }
}
