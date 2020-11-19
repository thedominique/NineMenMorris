//
//  NMM_Model.swift
//  NineMenMorris
//
//  Created by Abraham Elmgren on 2020-11-17.
//

import Foundation

struct NMM_Model {
    private (set) var blackTeam : team
    private (set) var whiteTeam : team
    
    init(){
        blackTeam = team(t: Teams.black)
        whiteTeam = team(t: Teams.white)
    }
    
    struct team {
        private(set) var pieces: [Piece]
        
        init(t : Teams){
            pieces = [Piece]()
            for _ in 0..<10{
                self.pieces.append(Piece(team: t))
            }
        }
        
        mutating func changePosition(x: Int, y: Int){
            
        }
        
        struct Piece : Identifiable {
            private(set) var x : Int
            private(set) var y : Int
            private(set) var team: Teams
            private(set) var id = UUID()
           
            init(team: Teams) {
                self.x = 0
                self.y = 0
                self.team = team
            }
            
            mutating func changePosition(x: Int, y: Int){
                self.x += x
                self.y += y
            }

        }
    }
    
   
    
}





