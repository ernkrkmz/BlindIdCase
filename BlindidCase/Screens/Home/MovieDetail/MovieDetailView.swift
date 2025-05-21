import SwiftUI

struct MovieDetailView: View {
    @StateObject private var viewModel = MovieDetailViewModel()
    
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
            
            
            HStack(spacing: 40) {
                Button(action: {
                    print("Like tapped for \(movie.title)")
                    viewModel.likeMovie(movieId: movie.id)
                }) {
                    Label("Like", systemImage: "hand.thumbsup.fill")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    print("Dislike tapped for \(movie.title)")
                    viewModel.unlikeMovie(movieId: movie.id)
                }) {
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
            if let message = viewModel.successMessage {
                Text(message)
                    .foregroundColor(.green)
            }
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
