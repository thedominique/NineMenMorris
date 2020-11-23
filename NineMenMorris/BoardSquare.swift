//
//  BoardSquare.swift
//  NineMenMorris
//
//  Created by Abraham Elmgren on 2020-11-23.
//

import SwiftUI

struct BoardSquare: View {
    @EnvironmentObject var gameState: NMM_VM
    let row: Int
    let column: Int
    
    var body: some View {
        let team = gameState.getPieceTeam(row: row, column: column)
        var text: AnyView
        if(gameState.getBlueTeamSize() + gameState.getRedTeamSize() == 0 && gameState.remove == Teams.none){
            let draggableItem = team+row.description+column.description
            text = AnyView(Text(team)
                            .onTapGesture(perform: {
                                if(gameState.remove.rawValue == team){
                                    gameState.removePiece(row: row, column: column, color: team)
                                }else{
                                    print("couldn't remove")
                                }
                            })
                            .onDrag({ NSItemProvider(object: (draggableItem as NSString))})
            )
        }else{
            text = AnyView(Text(team)
                            .onTapGesture(perform: {
                                if(gameState.remove.rawValue == team){
                                    gameState.removePiece(row: row, column: column, color: team)
                                }else{
                                    print("couldn't remove")
                                }
                            }))
        }
        return Rectangle()
            .foregroundColor(.clear)
            .contentShape(Rectangle())
            .overlay(text)
    }
}

class Model : NSObject, NSItemProviderWriting {
    public static var writableTypeIdentifiersForItemProvider: [String] {
        return [] // something here
    }
    
    public func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Swift.Void) -> Progress? {
        return nil // something here
    }
}
