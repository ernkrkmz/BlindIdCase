//
//  BlindidCaseApp.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//

import SwiftUI

@main
struct BlindidCaseApp: App {
    
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                MovieTabView()
                    .environmentObject(appState)
            } else {
                LoginView()
                    .environmentObject(appState)
            }
        }
    }
}
