//
//  ContentView.swift
//  NineMenMorris
//
//  Created by Abraham Elmgren and Dominique Persson on 2020-11-17.
//

import SwiftUI

struct SplashView: View {
    // 1.
    @State var isActive:Bool = false
    
    var body: some View {
        VStack {
            // 2.
            if self.isActive {
                // 3.
                NMM_menu()
            } else {
                // 4.
                Text("Welcome to NMM!")
                    .font(Font.largeTitle)
            }
        }
        // 5.
        .onAppear {
            // 6.
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                // 7.
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
}


struct NMM_menu : View {
    @State private var selection: String? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                //start game
                NavigationLink(destination: NMM_View(load: false), tag: "NMM_View", selection: $selection) {  Button(action: {
                    self.selection = "NMM_View"
                }) {
                    Text("Start new game")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 2)
                        )
                } }.padding()
                
                // load game
                NavigationLink(destination: NMM_View(load: true), tag: "NMM_View", selection: $selection) { Button(action: {
                    self.selection = "NMM_View"
                }) {
                    Text("Load and continue game")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 2)
                        )
                } }.padding()
                
                // info
                NavigationLink(destination: Info_View(), tag: "Info_View", selection: $selection) { Button(action: {
                    self.selection = "Info_View"
                }) {
                    Text("Info")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }}.padding()
                
                
                
            }.background(Color.white)
        }
    }
    
}

struct Info_View: View {
    var body: some View{
        Text("Info lalalalalal")
    }
}

struct menu_item: View {
    @State private var selection: String? = nil
    @State var dest : String
    
    
    
    let title : String
    var body: some View{
        Text("hej")
    }
}


struct NMM_View: View {
    @EnvironmentObject var game: NMM_VM
    @State var load : Bool
    var body: some View {
        VStack {
            HStack{
                Text(game.getMessage())
            }.padding()
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
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NMM_menu().environmentObject(NMM_VM())
    }
}
