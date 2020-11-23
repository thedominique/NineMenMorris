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
    private let approvedPos: Set = ["00", "03", "06", "11", "13", "15", "22", "23", "24", "30", "31", "32", "34", "35", "36", "42", "43", "44","51", "53", "55", "60", "63", "66"]
    
    private let indexTable = ["00": 3, "03": 6, "06": 9, "11": 2, "13": 5, "15": 8, "22": 1, "23": 4, "24": 7, "30": 24, "31": 23, "32": 22, "34": 10, "35": 11, "36": 12, "42": 19, "43": 16, "44": 13,"51": 20, "53": 17, "55": 14, "60": 21, "63": 18, "66": 15]
    
    func getRedTeamSize() -> Int{
        print(gameState.redmarker)
        return gameState.redmarker
    }
    func getBlueTeamSize() -> Int{
        return gameState.bluemarker
    }
    
    func checkSquareValidity(row: Int, column: Int) -> Bool{
        if approvedPos.contains(row.description+column.description){
            return true;
        }
        return false
    }
    
    func getSquare(row: Int, column: Int) -> Int{
        if let index = indexTable[row.description+column.description]{
            return index
        } else{
            assert(1 == 2, "Row and Column are wrong")
        }
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
    
    func checkMill(To: Int) -> Bool {
        return gameState.remove(to: To)
    }
    
    func removePiece(from: Int, color: String) -> Bool{
        print(color)
        if(color == NMM_VM.red){
            return gameState.remove(From: from, color: 5)
        }else if(color == NMM_VM.blue){
            return gameState.remove(From: from, color: 4)
        }
        return false
        
    }
}
