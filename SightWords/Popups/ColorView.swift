//
//  ColorView.swift
//  SightWords
//
//  Created by Kamil Wrobel on 2/6/22.
//

import SwiftUI

struct ColorView: View {
    
    var color: Color = .white
    @Binding var showScreen : Bool
    
    var body: some View {
        if showScreen {
        ZStack {
            color.opacity(0.7)
        }.ignoresSafeArea()
        }
    }
}

//struct ColorView_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorView()
//    }
//}
