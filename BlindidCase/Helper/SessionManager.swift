//
//  SessionManager.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//

import Combine
import Foundation


class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool = AuthManager.shared.isLoggedIn()

    func login(token: String) {
        UserDefaults.standard.set(token, forKey: "authToken")
        isLoggedIn = true
    }

    func logout() {
        AuthManager.shared.logout()
        isLoggedIn = false
    }
}
