import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.movies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieGridItemView(movie: movie)
                            }
                        }
                        
                    }
                    .padding()
                }
                
            }
            .onAppear {
                viewModel.fetchMovies()
            }
            .background(
                Image("Bg")
                    .resizable()
                    .ignoresSafeArea()
            )
            
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .tint(.yellow)
        
        
    }
    
    
}
