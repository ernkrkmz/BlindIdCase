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
        NetworkManager.shared.getLikedMovieIds { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let ids):
                    self.likedMovieIds = ids
                    self.likedMovies = []
                    for id in ids {
                        NetworkManager.shared.getMovieById(movieId: id) { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let movie):
                                    self.likedMovies.append(movie)
                                case .failure(let error):
                                    print("Error fetching movie for id \(id): \(error)")
                                }
                            }
                        }
                    }
                    
                case .failure(let error):
                    print("Error fetching liked movie IDs: \(error)")
                }
            }
        }
    }

}
