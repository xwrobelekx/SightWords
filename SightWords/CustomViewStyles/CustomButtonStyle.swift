//
//  GoodButtonStyle.swift
//  SightWords
//
//  Created by Kamil Wrobel on 2/4/22.
//

import SwiftUI



struct CustomButtonStyle: ButtonStyle {
    
    let scaleAmount: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
    
}




struct ButtonViewModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .frame(width: 135, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .font(.title3)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(20)
//            .overlay(Capsule()
//                        .stroke(.red, style: StrokeStyle(lineWidth: 4))
//            )
    }
    
}
