//
//  DonePopUp.swift
//  SightWords
//
//  Created by Kamil Wrobel on 2/5/22.
//

import SwiftUI

struct DonePopUp: View {
    @Binding var showDoneView: Bool
    //@State var allDone: Bool = true
    let viewModel : StudyViewModel?
    @Binding var dismissManimSreen : Bool
    
    var body: some View {
        if showDoneView {
            ZStack(alignment: .center){
                Color.black.opacity(0.7)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 320, height: 350)
                    .foregroundColor(.yellow)
                    .overlay(
                        
                        VStack(spacing: 20){
                            
                            
                            Text("Congratulations!")
                                //.foregroundColor(.white)
                                .font(.title)
                                .bold()
                                .padding()
                            
                            Text("You have finished all the words.")
                                //.foregroundColor(.white)
                                .font(.title3)
                                .multilineTextAlignment(.center)
                                .padding(.bottom)
                            
                            
                            //Spacer()
                            
                            if viewModel?.words.count ?? 0 >= 0{
                                Text("Would you like to repeat the words you may still have trouble with?")
                                    .font(.subheadline)
                                    .multilineTextAlignment(.center)
                                
                                
                            }
                            HStack {
                            
                            if viewModel?.words.count ?? 0 >= 0{
                                
                                Button(action: studyMore, label: {
                                    Text("Study More")
                                        .padding()
                                        .withDefaultButtonFormatting(color: .blue)
                                }
                                )
                                    .withPRessableStyle()
                                
                            }
                            
                            Button(action: finish, label: {
                                Text("Finish")
                                    .padding()
                                    .withDefaultButtonFormatting(color: .green)
                            }
                            )
                                .withPRessableStyle()
                            
                            
                            
                            }
                            
                            
                        }.padding()
                    )
                
                
            }.ignoresSafeArea()
        }
    }
    
    
    func finish(){
        print("Finish Button Pressed")
        withAnimation{
            showDoneView.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            dismissManimSreen.toggle()
        }
        }
    }
    
    
    func studyMore(){
        print("Study More Button Pressed")
    }
    
    
}

//struct DonePopUp_Previews: PreviewProvider {
//    @State var yes = true
//    static var previews: some View {
//        
//        DonePopUp(viewModel: StudyViewModel())
//    }
//}
