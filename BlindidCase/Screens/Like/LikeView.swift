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
                    
                        ScrollView {
                            Text("Liked movies")
                                .font(.system(size: 32, weight: .bold))
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
                .onAppear {
                    viewModel.fetchLikedMovies()
                    
                }
        
            .background(
                Image("Bg")
                    .resizable()
                    .ignoresSafeArea()
            )
            
            }.tint(.yellow)
        
    }
    
}
