//
//  LoginViewModel.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//


import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = "eren@gmail.com"
    @Published var password: String = "eren1234"
    @Published var errorMessage: String?
    @Published var isLoggedIn: Bool = false

    func login() {
            NetworkManager.shared.loginUser(
                email: email,
                password: password
            ) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        if let token = response.token {
                            UserDefaults.standard.set(token, forKey: "authToken")
                            print(response.token)
                            AuthManager.shared.token = token
                            self.isLoggedIn = true
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
