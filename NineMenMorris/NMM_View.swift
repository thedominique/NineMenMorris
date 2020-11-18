//
//  ContentView.swift
//  NineMenMorris
//
//  Created by Abraham Elmgren on 2020-11-17.
//

import SwiftUI

struct NMM_View: View {
    @EnvironmentObject var game: NMM_VM
    var body: some View {
        Board()
            .stroke(Color.black)
            .frame(width: 300, height: 300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NMM_View().environmentObject(NMM_VM())
    }
}
