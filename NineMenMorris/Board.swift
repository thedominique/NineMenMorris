//
//  BoardView.swift
//  NineMenMorris
//
//  Created by Abraham Elmgren on 2020-11-17.
//

import SwiftUI

struct Board: View {
    @EnvironmentObject var gameState: NMM_VM
    @State var rect: CGPoint = CGPoint()
    var body : some View {
        GeometryReader { geometry in
            Image("ninemen")
                .resizable()
                .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                // .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                .clipped()
            BoardPosition(rect: $rect)
        }
    }
}

struct Board_Previews: PreviewProvider {
    static var previews: some View {
        Board()
    }
}
