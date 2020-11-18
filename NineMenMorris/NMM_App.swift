//
//  NineMenMorrisApp.swift
//  NineMenMorris
//
//  Created by Abraham Elmgren on 2020-11-17.
//

import SwiftUI

@main
struct NMM_App: App {
    var body: some Scene {
        WindowGroup {
            NMM_View().environmentObject(NMM_VM())
        }
    }
}
