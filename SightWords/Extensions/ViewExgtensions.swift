//
//  ViewExgtensions.swift
//  SightWords
//
//  Created by Kamil Wrobel on 2/4/22.
//

import Foundation
import SwiftUI




extension View {
    func withDefaultButtonFormatting(color: Color, width: CGFloat = 135, height: CGFloat = 40) -> some View {
        modifier(ButtonViewModifier(color: color, width: width, height: height))
    }
    
    
    func withPRessableStyle(scalledAmount: CGFloat = 0.9) -> some View {
        buttonStyle(CustomButtonStyle(scaleAmount: scalledAmount))
    }
}



