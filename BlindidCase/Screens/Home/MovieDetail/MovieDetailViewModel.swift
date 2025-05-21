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
    
    
    
    func likeMovie(movieId: Int) {
        
        NetworkManager.shared.likeMovie(movieId: movieId) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.successMessage = response.message
                    self.isLiked = true
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isUnliked = true
                }
            }
        }
        
//        NetworkManager.shared.getLikedMovies { result in
//            print(result)
//        }
        
    }
    
    func unlikeMovie(movieId: Int) {
        
        NetworkManager.shared.unlikeMovie(movieId: movieId) { result in
            print(result)
        }
    }
}
