//
//  HomeView.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 22.05.2025.
//


import SwiftUI

struct LikeView: View {
    @StateObject private var viewModel = LikeViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if let error = viewModel.errorMessage {
                    Text("Hata: \(error)")
                        .foregroundColor(.red)
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.likedMovies) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    MovieGridItemView(movie: movie)
                                }
                            }

                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Beğenilen filmler")
            .onAppear {
                viewModel.fetchLikedMovies()
                
            }
            
        }
        
    }
    
}
