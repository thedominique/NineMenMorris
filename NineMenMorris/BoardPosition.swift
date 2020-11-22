//
//  BoardPosition.swift
//  NineMenMorris
//
//  Created by Dominique Persson on 2020-11-21.
//

import SwiftUI

struct BoardPosition: View {
    @Binding var rect: CGPoint
    var body: some View{
        GeometryReader{
            geometry in
            VStack(spacing: 0){
                ForEach(0..<7){row in
                    HStack(spacing: 0){
                        ForEach(0..<7){column in
                            Rectangle()
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
