//
//  BoardPosition.swift
//  NineMenMorris
//
//  Created by Dominique Persson on 2020-11-21.
//

import SwiftUI

struct BoardPosition: View {
    @EnvironmentObject var gameState: NMM_VM
    @State var piece: [String] = Array.init(repeating: "", count: 25)
    @Binding var rect: CGPoint
    var body: some View{
        GeometryReader{
            geometry in
            VStack(spacing: 0){
                ForEach(0..<7){row in
                    HStack(spacing: 0){
                        ForEach(0..<7){column in
                            if checkSquareValidity(row: row, column: column){
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .contentShape(Rectangle())
                                    .allowsHitTesting(true).onTapGesture(perform: {
                                        print(row, column)
                                    }).frame(width: geometry.size.width/7, height: geometry.size.height/7)
                                    .overlay(Text(piece[BoardPosition.GetSquare(row: row, column: column)]))
                                    .onDrop(of: ["public.text"], isTargeted: nil){ providers in
                                        return self.drop(providers: providers, row: row, column: column)
                                    }
                            }else{
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .contentShape(Rectangle())
                                    .allowsHitTesting(true).onTapGesture(perform: {
                                        print(row, column)
                                    }).frame(width: geometry.size.width/7, height: geometry.size.height/7)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private static let approvedPos: Set = ["00", "03", "06", "11", "13", "15", "22", "23", "24", "30", "31", "32", "34", "35", "36", "42", "43", "44","51", "53", "55", "60", "63", "66"]
    
    private static let indexTable = ["00": 3, "03": 6, "06": 9, "11": 2, "13": 5, "15": 8, "22": 1, "23": 4, "24": 7, "30": 24, "31": 23, "32": 22, "34": 10, "35": 11, "36": 12, "42": 19, "43": 16, "44": 13,"51": 20, "53": 17, "55": 14, "60": 21, "63": 18, "66": 15]
    
    private func checkSquareValidity(row: Int, column: Int) -> Bool{
        let approvedPos: Set = ["00", "03", "06", "11", "13", "15", "22", "23", "24", "30", "31", "32", "34", "35", "36", "42", "43", "44","51", "53", "55", "60", "63", "66"]
        if approvedPos.contains(row.description+column.description){
            return true;
        }
        return false
    }
    
    fileprivate static func GetSquare(row: Int, column: Int) -> Int{
        if let index = indexTable[row.description+column.description]{
            return index
        } else{
            assert(1 == 2, "Row and Column are wrong")
        }
    }
    
    private func drop(providers: [NSItemProvider], row: Int, column: Int) -> Bool{
        if let found = providers.first {
            found.loadItem(forTypeIdentifier: "public.text", options: nil, completionHandler: {(emoji, error) in
                DispatchQueue.main.async {
                    if let emoji = emoji as? Data {
                        let gamePiece = String(decoding: emoji, as: UTF8.self)
                        if(gameState.legalMove(To: BoardPosition.GetSquare(row: row, column: column), From: 0, piece: gamePiece)){
                            self.piece[BoardPosition.GetSquare(row: row, column: column)] = gamePiece
                            print("Hello")
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
