//
//  BoardPosition.swift
//  NineMenMorris
//
//  Created by Dominique Persson on 2020-11-21.
//

import SwiftUI

struct BoardGrid: View {
    @EnvironmentObject var gameState: NMM_VM
    @State var piece: [String] = Array.init(repeating: "", count: 25)
    @State var isRemoveable: [Bool] = Array.init(repeating: false, count: 25)
    @State var menLeft: Int
    @Binding var rect: CGPoint
    var body: some View{
        GeometryReader{
            geometry in
            VStack(spacing: 0){
                ForEach(0..<7){row in
                    HStack(spacing: 0){
                        ForEach(0..<7){column in
                            if gameState.checkSquareValidity(row: row, column: column){
                                let position = gameState.getSquare(row: row, column: column)
                                BoardSquare(team: $piece[position], removeable: $isRemoveable, position: position)
                                    .frame(width: geometry.size.width/7, height: geometry.size.height/7)
                                    .onDrop(of: ["public.text"], isTargeted: nil){ providers in
                                        return self.drop(providers: providers, row: row, column: column)
                                    }
                            }else{
                                Rectangle()
                                    .frame(width: geometry.size.width/7, height: geometry.size.height/7)
                                    .foregroundColor(.clear)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func drop(providers: [NSItemProvider], row: Int, column: Int) -> Bool{
        if let found = providers.first {
            found.loadItem(forTypeIdentifier: "public.text", options: nil, completionHandler: {(emoji, error) in
                DispatchQueue.main.async {
                    if let emoji = emoji as? Data {
                        let gamePiece = String(decoding: emoji, as: UTF8.self)
                        if(gameState.legalMove(To: gameState.getSquare(row: row, column: column), From: 0, piece: gamePiece)){
                            let position = gameState.getSquare(row: row, column: column)
                            self.piece[position] = gamePiece
                            if(gameState.checkMill(To: gameState.getSquare(row: row, column: column))){
                                if(gamePiece == NMM_VM.red){
                                    for index in 0..<self.piece.count {
                                        if(piece[index] == NMM_VM.blue){
                                            self.isRemoveable[index] = true
                                        }
                                    }
                                }else if(gamePiece == NMM_VM.blue){
                                    for index in 0..<self.piece.count {
                                        if(piece[index] == NMM_VM.red){
                                            self.isRemoveable[index] = true
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            })
            return true
        } else{
            print("No Go")
            return false
        }
    }
}
