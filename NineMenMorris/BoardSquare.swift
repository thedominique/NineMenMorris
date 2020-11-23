//
//  BoardSquare.swift
//  NineMenMorris
//
//  Created by Abraham Elmgren on 2020-11-23.
//

import SwiftUI

struct BoardSquare: View {
    @EnvironmentObject var gameState: NMM_VM
    @Binding var team: String
    @Binding var removeable: [Bool]
    let position: Int
    var body: some View {
        let text = Text(team).onTapGesture(perform: {
            if(removeable[position]){
                print("TRY REMOVE")
                if(gameState.removePiece(from: position, color: team)){
                    print("REMOVING ASS")
                    self.team = ""
                    removeable = Array.init(repeating: false, count: 25)
                }
            }else{
                print("couldn't remove")
            }
        })
        return Rectangle()
            .foregroundColor(.clear)
            .contentShape(Rectangle())
            .overlay(text)
    }
}
