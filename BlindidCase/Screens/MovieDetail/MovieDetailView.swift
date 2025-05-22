import SwiftUI

struct MovieDetailView: View {
    @StateObject private var viewModel = MovieDetailViewModel()
    
    var isLiked: Bool {
        viewModel.likedMovieIds.contains(movie.id)
    }
    let movie: Movie
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    AsyncImage(url: URL(string: movie.posterUrl)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 300)
                    .cornerRadius(12)
                    
                    Text(movie.title)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    Text("Kategori: \(movie.category)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("Puan: \(movie.rating, specifier: "%.1f")")
                        .font(.subheadline)
                    
                    Text("Oyuncular:")
                        .font(.headline)
                        .padding(.top, 8)
                    
                    // Actors listesi
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(movie.actors, id: \.self) { actor in
                            Text("• \(actor)")
                                .font(.body)
                        }
                    }
                    
                    Text(movie.description)
                        .font(.body)
                        .padding(.top)
                    
                    Spacer()
                }
                .padding()
            }
            
                Button(action: {
                    if isLiked {
                        viewModel.unlikeMovie(movieId: movie.id)
                    }else {
                        viewModel.likeMovie(movieId: movie.id)
                    }
                    
                }) {
                    if !isLiked {
                        Label("Like", systemImage: "hand.thumbsup.fill")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                    }else {
                        Label("Dislike", systemImage: "hand.thumbsdown.fill")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    
                }
            .padding([.horizontal, .bottom])
            
        }.onAppear {
            viewModel.fetchLikedMovieIds()
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
