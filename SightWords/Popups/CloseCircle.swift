//
//  CloseCircle.swift
//  SightWords
//
//  Created by Kamil Wrobel on 3/12/22.
//

import SwiftUI

struct CloseCircle: View {
    
    @Binding var showXButton: Bool
    
    var body: some View {
        if showXButton {
            ZStack(alignment: .topTrailing){
                Circle()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.red)
                //.overlay(
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .frame(width: 35, height: 35)
                //).padding(3)
            }
        }
    }
}

//struct CloseCircle_Previews: PreviewProvider {
//    @State var show = false
//    static var previews: some View {
//        CloseCircle(showXButton: $show)
//    }
//}
