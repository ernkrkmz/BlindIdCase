import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State var didLoad = false
    @State private var searchText = ""

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var filteredMovies: [Movie] {
            if searchText.isEmpty {
                return viewModel.movies
            } else {
                return viewModel.movies.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
            }
        }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredMovies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieGridItemView(movie: movie)
                            }
                        }
                    }
                    .padding()
                }
                .searchable(
                    text: $searchText,
                    prompt: "Film ara"
                )
            }
            .onAppear {
                if !didLoad {
                    viewModel.fetchMovies()
                    didLoad = true
                }
                
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
