//
//  RegisterViewModel.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//


import Foundation
import Combine

class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""

    @Published var errorMessage: String?
    @Published var isRegistered: Bool = false

    
    func register(appstate : AppState) {
        
        NetworkManager.shared.registerUser(
            name: name,
            surname: surname,
            email: email,
            password: password
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let token = response.token {
                        AuthManager.shared.token = response.token
                        appstate.isLoggedIn = true
                    } else {
                        self.errorMessage = response.message ?? "Kayıt başarısız"
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

}
