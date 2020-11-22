//
//  NMMVM.swift
//  NineMenMorris
//
//  Created by Abraham Elmgren on 2020-11-17.
//

import Foundation
import SwiftUI

class NMM_VM: ObservableObject{
    @Published var gameState: NineMenMorrisRules = NineMenMorrisRules()
    
    static let red = "🔴"
    static let blue = "🔵"
    
    func getRedTeamSize() -> Int{
        print(gameState.redmarker)
        return gameState.redmarker
    }
    func getBlueTeamSize() -> Int{
        return gameState.bluemarker
    }
    
    func legalMove(To: Int, From: Int, piece: String) -> Bool{
        if(piece == NMM_VM.red){
            print("VM")
            return gameState.legalMove(To: To, From: From, color: 2)
        }else if(piece == NMM_VM.blue){
            return gameState.legalMove(To: To, From: From, color: 1)
        }
        return false
    }
    
    
    // MARK: - intents
    
//    func movePiece(_ piece : NMM_Model.team.Piece, by offset: CGSize){
//        
//        if let index = self.gameState.blackTeam.pieces.firstIndex(matching: piece){
//            self.gameState.blackTeam.pieces[index].changePosition(x: Int(offset.width), y: Int(offset.height))
//        }
//        
        
        
    }
    



