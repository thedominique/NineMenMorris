//
//  NMMVM.swift
//  NineMenMorris
//
//  Created by Abraham Elmgren on 2020-11-17.
//

import Foundation
import SwiftUI

class NMM_VM: ObservableObject{
    @Published var gameState: NMM_Model = NMM_Model()
    
    
    // MARK: - intents
    
    func movePiece(_ piece : NMM_Model.team.Piece, by offset: CGSize){
        
        if let index = self.gameState.blackTeam.pieces.firstIndex(matching: piece){
            self.gameState.blackTeam.pieces[index].changePosition(x: Int(offset.width), y: Int(offset.height))
        }
        
        
        
    }
    
}


