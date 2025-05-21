//
//  AuthManager.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//

import Foundation


class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    var token: String? {
        UserDefaults.standard.string(forKey: "authToken")
    }
    
    func isLoggedIn() -> Bool {
        return token != nil
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: "authToken")
    }
}
