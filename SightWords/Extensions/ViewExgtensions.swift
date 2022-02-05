//
//  ViewExgtensions.swift
//  SightWords
//
//  Created by Kamil Wrobel on 2/4/22.
//

import Foundation
import SwiftUI




extension View {
    func withDefaultButtonFormatting(color: Color) -> some View {
        modifier(ButtonViewModifier(color: color))
    }
    
    
    func withPRessableStyle(scalledAmount: CGFloat = 0.9) -> some View {
        buttonStyle(CustomButtonStyle(scaleAmount: scalledAmount))
    }
}



