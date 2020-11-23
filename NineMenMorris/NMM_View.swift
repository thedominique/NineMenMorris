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
        VStack {
            ZStack {
                Board().scaledToFit()
            }.padding()
            HStack {
                ForEach(0..<game.getRedTeamSize(), id: \.self){ piece in
                    if(game.remove == Teams.none){
                        Text(NMM_VM.red).onDrag({ NSItemProvider(object: NMM_VM.red as NSString) })
                    } else{
                        Text(NMM_VM.red)
                    }
                }
                ForEach(0..<game.getBlueTeamSize(), id: \.self){ piece in
                    if(game.remove == Teams.none){
                        Text(NMM_VM.blue).onDrag({ NSItemProvider(object: NMM_VM.blue as NSString) })
                    } else {
                        Text(NMM_VM.blue)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NMM_View().environmentObject(NMM_VM())
    }
}
