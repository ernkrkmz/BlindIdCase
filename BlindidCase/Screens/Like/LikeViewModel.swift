//
//  HomeViewModel.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 22.05.2025.
//


import Foundation

class LikeViewModel: ObservableObject {
    @Published var likedMovies: [Movie] = []
    @Published var likedMovieIds: [Int] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchLikedMovies() {
        
        NetworkManager.shared.getLikedMovies { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.likedMovies = movies
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error.localizedDescription)
                }
            }
            
        }
        
    }
    
}
