import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
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
                            ForEach(viewModel.movies) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    VStack {
                                        
                                        AsyncImage(url: URL(string: movie.posterUrl)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                            
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 100, height: 130, alignment: .center)
                                        .clipped()
                                        .cornerRadius(8)
                                        
                                        Text(movie.title)
                                            .font(.headline)
                                            .multilineTextAlignment(.center)
                                            
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                                .frame(width:160)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Filmler")
            .onAppear {
                viewModel.fetchMovies()
                
            }
        }
    }
}
