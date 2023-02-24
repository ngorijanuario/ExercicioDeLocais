//
//  ExerciciodeMapaApp.swift
//  ExerciciodeMapa
//
//  Created by Ngori Januario on 21/02/23.
//

import SwiftUI

@main
struct ExerciciodeMapaApp: App {
    
    @StateObject private var vm = localizacaoViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            localizacaoView()
                .environmentObject(vm)
        }
    }
}
