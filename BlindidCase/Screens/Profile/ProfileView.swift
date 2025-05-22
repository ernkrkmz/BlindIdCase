//
//  ProfileView.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//


import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if viewModel.isLoading {
                    ProgressView("Yükleniyor...")
                } else if let user = viewModel.user {
                    VStack(spacing: 12) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                        
                        Text("\(user.name) \(user.surname)")
                            .font(.title)
                            .fontWeight(.semibold)

                        Text(user.email)
                            .foregroundColor(.gray)

                        Divider()

                        HStack {
                            Text("Beğenilen Filmler:")
                            Spacer()
                            Text("\(user.likedMovies.count) adet")
                                .bold()
                        }

                        Divider()

                        Text("Üyelik Tarihi: \(formattedDate(user.createdAt))")
                            .font(.footnote)
                            .foregroundColor(.secondary)

                        Spacer()

                        Button(action: {
                            viewModel.logOut()
                        }) {
                            Text("Çıkış Yap")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Hata: \(errorMessage)")
                        .foregroundColor(.red)
                }

                Spacer()
            }
            .navigationTitle("Profil")
            .onAppear {
                viewModel.fetchProfile()
            }
            
        }
    }

    func formattedDate(_ isoDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let date = isoFormatter.date(from: isoDate) else {
            return isoDate
        }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }

}
