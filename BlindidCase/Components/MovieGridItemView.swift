//
//  MovieGridItemView.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 22.05.2025.
//


import SwiftUI

struct MovieGridItemView: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: movie.posterUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 130)
            .clipped()
            .cornerRadius(8)

            Text(movie.title)
                .font(.headline)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .frame(width: 160)
    }
}
