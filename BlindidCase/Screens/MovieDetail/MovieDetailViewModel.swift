//
//  MovieDetailViewModel.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//


import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    @Published var isLiked = false
    @Published var isUnliked = false

    @Published var errorMessage: String?
    @Published var successMessage: String?
    
    @Published var likedMovieIds: [Int] = []

    
    func likeMovie(movieId: Int) {
        
        NetworkManager.shared.likeMovie(movieId: movieId) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.successMessage = response.message
                    self.isLiked = true
                    self.likedMovieIds.append(movieId)

                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isUnliked = true
                    
                }
            }
        }
        
    }
    
    func unlikeMovie(movieId: Int) {
        NetworkManager.shared.unlikeMovie(movieId: movieId) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.successMessage = response.message
                    self.isLiked = false
                    self.likedMovieIds.removeAll(where: { $0 == movieId })
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isUnliked = false
                }
            }
        }
    }

    
    func fetchLikedMovieIds() {
            NetworkManager.shared.getLikedMovieIds { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let ids):
                        self.likedMovieIds = ids
                    case .failure(let error):
                        print("Error fetching liked movie IDs: \(error)")
                    }
                }
            }
        }
}
