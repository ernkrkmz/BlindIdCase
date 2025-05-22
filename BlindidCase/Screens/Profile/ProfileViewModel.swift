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
        
        let url = "https://moviatask.cerasus.app/api/auth/me"
        
        NetworkManager.shared.getRequest(url: url, responseType: User.self) { result in
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
    
    func logOut() {
        AuthManager.shared.logout()
        
    }
}
