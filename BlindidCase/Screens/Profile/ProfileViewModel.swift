//
//  MovieDetailViewModel.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 22.05.2025.
//


import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func fetchProfile() {
        isLoading = true
        errorMessage = nil
        
        NetworkManager.shared.getCurrentUser { result in
            DispatchQueue.main.async {
                self.isLoading = false

                switch result {
                case .success(let user):
                    self.user = user
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func logOut(appState: AppState) {
        AuthManager.shared.logout()
        appState.isLoggedIn = false
    }
    
    func updateUser(_ user: UpdateUserRequestModel) {
        
        NetworkManager.shared.putRequest(
            url: "/users/profile",
            body: user,
            responseType: UserResponse.self
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let updatedUser):
                    print("Güncellendi: \(updatedUser)")
                    self.user?.name = updatedUser.name
                    self.user?.surname = updatedUser.surname
                    self.user?.email = updatedUser.email
                case .failure(let error):
                    print("Hata: \(error)")
                }
            }
        }
    }
    
}
