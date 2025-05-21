//
//  LoginViewModel.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//


import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = "john@example.com"
    @Published var password: String = "password123"
    @Published var errorMessage: String?
    @Published var isLoggedIn: Bool = false

    func login(email: String, password: String) {
        let params: [String: Any] = [
            "email": email,
            "password": password
        ]

        NetworkManager.shared.postRequest(
            url: "https://moviatask.cerasus.app/api/auth/login",
            body: params,
            responseType: LoginResponse.self
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("Token: \(response.token ?? "Yok")")
                    UserDefaults.standard.set(response.token, forKey: "authToken")

                case .failure(let error):
                    print("Login hatası: \(error.localizedDescription)")
                }
            }
        }
    }

}
