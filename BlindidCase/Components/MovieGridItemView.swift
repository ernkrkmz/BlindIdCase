//
//  MovieGridItemView.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 22.05.2025.
//


import SwiftUI
import Kingfisher

struct MovieGridItemView: View {
    let movie: Movie
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            KFImage(URL(string: movie.posterUrl))
                .resizable()
                .placeholder {
                    ProgressView()
                }
                .cancelOnDisappear(true)
                .scaledToFill()
                .frame(width: 160, height: 210)
                .clipped()
                .cornerRadius(8)
            
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text(String(format: "%.1f", movie.rating))
                    .foregroundColor(.white)
            }
            .padding(6)
            .background(Color.black.opacity(0.6))
            .font(.caption)
            .cornerRadius(5)
            .padding(8)
        }


        
    }
}
