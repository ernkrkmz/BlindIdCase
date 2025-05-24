import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    
    @StateObject private var viewModel = MovieDetailViewModel()
    
    var isLiked: Bool {
        viewModel.likedMovieIds.contains(movie.id)
    }
    let movie: Movie
    
    var body: some View {
        ZStack{
            Color.clear.background(
                Image("Bg")
                    .resizable()
                    .ignoresSafeArea()
            )
            
            VStack {
                ScrollView {
                    VStack(spacing: 16) {
                        
                        ZStack(alignment: .bottomTrailing) {
                            KFImage(URL(string: movie.posterUrl))
                                .resizable()
                                .placeholder {
                                    ProgressView()
                                }
                                .cancelOnDisappear(true)
                                .scaledToFill()
                                .frame(width: 250, height: 350)
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
                        
                        
                        Text(movie.title)
                            .font(.system(size: 36, weight: .bold, design: .default))
                            .bold()
                            .multilineTextAlignment(.center)
                        
                        Text("\(movie.category)")
                            .font(.subheadline)
                            .foregroundColor(.black)
                        
                        Text("Cast:")
                            .font(.headline)
                            .padding(.top, 8)
                        
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
            }.onAppear {
                viewModel.fetchLikedMovieIds()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if isLiked {
                            viewModel.unlikeMovie(movieId: movie.id)
                        } else {
                            viewModel.likeMovie(movieId: movie.id)
                        }
                    }) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundColor(isLiked ? .red : .white)
                    }
                }
            }
        }.toolbarBackground(.hidden, for: .navigationBar)
        
    }
}

