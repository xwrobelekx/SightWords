//
//  DonePopUp.swift
//  SightWords
//
//  Created by Kamil Wrobel on 2/5/22.
//

import SwiftUI

struct DonePopUp: View {
    @State var showDoneView: Bool = true
    @State var allDone: Bool = true
    var body: some View {
        if showDoneView {
            ZStack(alignment: .center){
                Color.black.opacity(0.7)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 300, height: 500)
                    .foregroundColor(.pink)
                    .overlay(
                        
                        VStack{
                            
                            
                            
                            Text("Add New Word")
                                .foregroundColor(.white)
                                .font(.title)
                                .bold()
                            
                            
                            
                            
//                            Button(action: addItem, label: {
//                                Text(word == "" ? "Cancel" : "Save")
//                                    .foregroundColor(.white)
//                            })
//                                .frame(width: 100)
//                                .padding()
//                                .background(Color.blue)
//                                .cornerRadius(.infinity)
                            
                        })
                
                
            }.ignoresSafeArea()
        }
    }
}

struct DonePopUp_Previews: PreviewProvider {
    @State var yes = true
    static var previews: some View {
        
        DonePopUp()
    }
}
