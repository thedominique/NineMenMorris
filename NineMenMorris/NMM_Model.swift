//
//  NMM_Model.swift
//  NineMenMorris
//
//  Created by Abraham Elmgren on 2020-11-17.
//

import Foundation

struct NMM_Model {
    private(set) var pieces: [Piece]
    private(set) var whosTurn: Teams
    
    init(){
        pieces = [Piece]()
        for _ in 0..<10{
            self.pieces.append(Piece(inPlay: true, team: Teams.black))
            self.pieces.append(Piece(inPlay: true, team: Teams.white))
        }
        self.whosTurn = Teams.white
    }
    
    struct Piece {
        private(set) var position: [[Int]]?
        private(set) var inPlay: Bool
        private(set) var team: Teams
    }
}
