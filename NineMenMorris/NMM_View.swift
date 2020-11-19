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
                Board()
                    .stroke(Color.black)
                    .frame(width: 300, height: 300)
                
            }.padding()
            
            HStack {
                menu(team: Teams.black, pieces: testData)
                menu(team: Teams.white, pieces: testData2)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NMM_View().environmentObject(NMM_VM())
    }
}





struct piece : View, Identifiable {
    var id: Int
    let team : Teams
    var body : some View {
        if(team == Teams.black){
            Text("⚫️")
        } else if(team == Teams.white){
            Text("⚪️")
        }
        
    }
}

struct menu : View {
    var team : Teams
    var pieces : [piece]
    var body : some View {
        HStack {
            ForEach(pieces) { p in
                piece(id: p.id, team: team)
            }
        }.padding()
    }
}


func createTestData(t : Teams) -> [piece] {
    var ret = Array<piece>()
    for i in 0..<4 {
        ret.append(piece(id: i,  team: t))
    }
    return ret
}

let testData = createTestData(t: Teams.black)
let testData2 = createTestData(t: Teams.white)

