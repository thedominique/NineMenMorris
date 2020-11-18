//
//  BoardView.swift
//  NineMenMorris
//
//  Created by Abraham Elmgren on 2020-11-17.
//

import SwiftUI

struct Board: Shape {
    @EnvironmentObject var game: NMM_VM
    private var points: Int = 24
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let outerRect = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height)
        let middleRect = CGRect(x: 0.15*rect.maxX, y: 0.15*rect.maxY, width: 0.70*rect.width, height: 0.70*rect.height)
        let innerRect = CGRect(x: 0.30*rect.maxX, y: 0.30*rect.maxY, width: 0.40*rect.width, height: 0.40*rect.height)
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: 0.50*rect.width, y: 0.30*rect.height))
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: 0.30*rect.width, y: 0.50*rect.height))
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0.50*rect.width, y: 0.70*rect.height))
        path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: 0.70*rect.width, y: 0.50*rect.height))
        path.addRect(outerRect)
        path.addRect(middleRect)
        path.addRect(innerRect)
    
        return path
    }
}



struct Board_Previews: PreviewProvider {
    static var previews: some View {
        Board().stroke(Color.black).frame(width: 300, height: 300)
    }
}
