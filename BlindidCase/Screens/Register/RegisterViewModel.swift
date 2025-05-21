//
//  RegisterViewModel.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//


import Foundation
import Combine

class RegisterViewModel: ObservableObject {
    @Published var name: String = "Eren"
    @Published var surname: String = "Korkmaz"
    @Published var email: String = "eren@gmail.com"
    @Published var password: String = "eren1234"

    @Published var errorMessage: String?
    @Published var isRegistered: Bool = false

    func register() {
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
                        UserDefaults.standard.set(token, forKey: "authToken")
                        self.isRegistered = true
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
