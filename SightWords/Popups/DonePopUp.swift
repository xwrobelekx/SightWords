//
//  DonePopUp.swift
//  SightWords
//
//  Created by Kamil Wrobel on 2/5/22.
//

import SwiftUI

struct DonePopUp: View {
    @Binding var showDoneView: Bool
    @Binding var dismissManimSreen : Bool
    @EnvironmentObject private var viewModel: StudyViewModel

    
    var body: some View {
        if showDoneView {
            ZStack(alignment: .center){
                Color.black.opacity(0.7)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 320, height: 350)
                    .foregroundColor(.popupBackground)
                    .overlay(
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AngularGradient.gradient, lineWidth: 4)
                    .frame(width: 320, height: 350)
                    .overlay(
                        
                        VStack(spacing: 20){
                            
                            
                            Text("Congratulations!")
                                .foregroundColor(.white)
                                .font(.title)
                                .bold()
                                .padding()
                            
                            Text("You have finished all the words.")
                                .foregroundColor(.white)
                                .font(.title3)
                                .multilineTextAlignment(.center)
                                .padding(.bottom)
                            
                            
                            //Spacer()
                            
                            if viewModel.wrongCount > 0{
                                
                                Text("You got \(viewModel.wrongCount ) words wrong. \n Would you like to repeat the words you may still have trouble with?")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .multilineTextAlignment(.center)
                                
                                
                            }
                            HStack {
                                
                                if viewModel.wrongCount > 0{
                                    
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
                    ))
                
                
            }.ignoresSafeArea()
        }
    }
    
    
    func finish(){
        print("Finish Button Pressed")
        withAnimation{
            showDoneView.toggle()
            viewModel.wrongCount = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                dismissManimSreen.toggle()
                
            }
        }
    }
    
    
    func studyMore(){
        print("Study More Button Pressed")
        
        withAnimation{
            showDoneView.toggle()
            
            //reload Study page with wrong words
            
            
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
//                dismissManimSreen.toggle()
//                viewModel.wrongCount = 0
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                    if viewModel.wrongCount != 0 {
//                    viewModel.studyAgain = true
//                    }
//                }
//            }
        }
        
    }
}

//struct DonePopUp_Previews: PreviewProvider {
//    @State var yes = true
//    static var previews: some View {
//        
//        DonePopUp(viewModel: StudyViewModel())
//    }
//}
