//
//  AppState.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 22.05.2025.
//


import Foundation

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = AuthManager.shared.token != nil
}