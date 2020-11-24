//
//  NMMVM.swift
//  NineMenMorris
//
//  Created by Abraham Elmgren on 2020-11-17.
//

import Foundation
import SwiftUI

class NMM_VM: ObservableObject{
    
    private var gameState: NineMenMorrisRules = NineMenMorrisRules() {
        willSet{
            objectWillChange.send()
        }
        didSet{
            NMM_VM.win = gameState.winner
            if(NMM_VM.win != Teams.none){
                print("Winner winner chicken dinner " + NMM_VM.win.rawValue)
            }
        }
    }
    private(set) var remove: Teams = Teams.none
    
    private(set) static var win: Teams = Teams.none
    
    static let red = "🔴"
    static let blue = "🔵"
    private let approvedPos: Set = ["00", "03", "06", "11", "13", "15", "22", "23", "24", "30", "31", "32", "34", "35", "36", "42", "43", "44","51", "53", "55", "60", "63", "66"]
    
    private let indexTable = ["00": 3, "03": 6, "06": 9, "11": 2, "13": 5, "15": 8, "22": 1, "23": 4, "24": 7, "30": 24, "31": 23, "32": 22, "34": 10, "35": 11, "36": 12, "42": 19, "43": 16, "44": 13,"51": 20, "53": 17, "55": 14, "60": 21, "63": 18, "66": 15, "88": 0]
    
    func getRedTeamSize() -> Int{
        return gameState.redmarker
    }
    func getBlueTeamSize() -> Int{
        return gameState.bluemarker
    }
    
    func restart(){
        gameState = NineMenMorrisRules()
    }
    
    func getPieceTeam(row: Int, column: Int) -> String {
        let position = self.getSquare(row: row, column: column)
        let color = gameState.gameplan[position]
        if(color == 4){
            return NMM_VM.blue
        }
        else if(color == 5){
            return NMM_VM.red
        }
        else{
            return ""
        }
    }
    
    func checkSquareValidity(row: Int, column: Int) -> Bool{
        if approvedPos.contains(row.description+column.description){
            return true;
        }
        return false
    }
    
    private func getSquare(row: Int, column: Int) -> Int{
        if let index = indexTable[row.description+column.description]{
            return index
        } else{
            assert(1 == 2, "Error: Row and Column have gone outside scope")
        }
    }
    
    func legalMove(row: Int, column: Int, destRow: Int, destCol: Int, piece: String) -> Bool{
        let To = self.getSquare(row: row, column: column)
        let From = self.getSquare(row: destRow, column: destCol)
        if(piece == NMM_VM.red){
            if(gameState.legalMove(To: To, From: From, color: 2)){
                if(gameState.bluemarker == 0){
                    gameState.canMove(color: 4)
                }
                return true;
            }
        }else if(piece == NMM_VM.blue){
            if(gameState.legalMove(To: To, From: From, color: 1)){
                if(gameState.redmarker == 0){
                    gameState.canMove(color: 5)
                }
                return true
            }
        }
        return false
    }
    
    func hasWon() -> Bool{
        if(NMM_VM.win != Teams.none){
            return true
        }
        return false
    }
    
    func checkMill(row: Int, column: Int, color: String) {
        let To = self.getSquare(row: row, column: column)
        if(gameState.remove(to: To) == true){
            if(color == NMM_VM.red){
                self.remove = Teams.blue
            }else{
                self.remove = Teams.red
            }
        }
    }
    
    func getMessage() -> String {
        if(gameState.winner != Teams.none){
            return String(gameState.winner.rawValue + " has won! restart from menu ")
        }else{
            if(self.remove != Teams.none){
                return String("Remove from " + self.remove.rawValue)
            }else{
                if(gameState.turn == 2){
                    return String("reds turn")
                }else{
                    return String("Blues turn")
                }
            }
        }
    }
    
    func removePiece(row: Int, column: Int, color: String){
        let from = self.getSquare(row: row, column: column)
        if(color == NMM_VM.red){
            if(gameState.remove(From: from, color: 5)){
                gameState.win(color: 4)
                self.remove = Teams.none
            }
        }else if(color == NMM_VM.blue){
            if(gameState.remove(From: from, color: 4)){
                gameState.win(color: 5)
                self.remove = Teams.none
            }
        }
    }
}
