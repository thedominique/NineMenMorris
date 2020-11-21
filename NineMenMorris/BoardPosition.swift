//
//  BoardPosition.swift
//  NineMenMorris
//
//  Created by Dominique Persson on 2020-11-21.
//

import SwiftUI

struct BoardPosition: View {
    var body: some View {
        Button(action: {
            print("Ah")
        }, label: {
            Text("       ")
        }).padding().background(Color.purple).foregroundColor(.white).font(.title)
    }
}

struct BoardPosition_Previews: PreviewProvider {
    static var previews: some View {
        BoardPosition()
    }
}
