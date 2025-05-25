//
//  LoginViewModel.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//


import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = "" //test : eren@gmail.com
    @Published var password: String = "" // test : eren1234
    @Published var errorMessage: String?
    @Published var isLoggedIn: Bool = false

    func login(appState: AppState) {
        NetworkManager.shared.loginUser(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let token = response.token {
                        AuthManager.shared.token = token
                        appState.isLoggedIn = true
                    } else {
                        self.errorMessage = response.message ?? "Giriş başarısız"
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }


}
