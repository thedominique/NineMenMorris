//
//  BoardPosition.swift
//  NineMenMorris
//
//  Created by Dominique Persson on 2020-11-21.
//

import SwiftUI

struct BoardGrid: View {
    @EnvironmentObject var gameState: NMM_VM
    @Binding var rect: CGPoint
    
    var body: some View{
        GeometryReader{
            geometry in
            VStack(spacing: 0){
                ForEach(0..<7){row in
                    HStack(spacing: 0){
                        ForEach(0..<7){column in
                            if gameState.checkSquareValidity(row: row, column: column){
                                BoardSquare(row: row, column: column)
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
            _ = found.loadObject(ofClass: String.self, completionHandler: { stringdata,error in
                if(error == nil){
                    if let emoji = stringdata {
                        DispatchQueue.main.async {
                            var color = emoji
                            var destrow = 8
                            var destcol = 8
                            if(emoji.count == 3){
                                color = emoji[emoji.index(emoji.startIndex, offsetBy: 0)].description
                                destrow = Int.init(emoji[emoji.index(emoji.startIndex, offsetBy: 1)].description)!
                                destcol = Int.init(emoji[emoji.index(emoji.startIndex, offsetBy: 2)].description)!
                            }
                            if(gameState.legalMove(row: row, column: column, destRow: destrow, destCol: destcol, piece: color)){
                                print("Checking Mill")
                                gameState.checkMill(row: row, column: column, color: color)
                            }else{
                            }
                        }
                    }
                }else{
                    print("""
                There was an error in loading the drop item: ### \(#function),
                \(String(describing: error?.localizedDescription))
                """)
                }
            })
            return true
        } else{
            print("No Go")
            return false
        }
    }
}
