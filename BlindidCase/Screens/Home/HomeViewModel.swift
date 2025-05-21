//
//  HomeViewModel.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//


import Foundation

class HomeViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchMovies() {
        isLoading = true
        NetworkManager.shared.getMovies { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let movies):
                    self.movies = movies
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
