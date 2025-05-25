//
//  ProfileView.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//
import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @EnvironmentObject var appState: AppState

    @State private var name = ""
    @State private var surname = ""
    @State private var email = ""
    @State private var isEditing = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                if let user = viewModel.user {
                    
                    if isEditing {
                        TextField("Ad", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Soyad", text: $surname)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                    } else {
                        Text("Ad: \(user.name)")
                        Text("Soyad: \(user.surname)")
                        Text("Email: \(user.email)")
                    }
                    
                    HStack {
                        Button(isEditing ? "Kaydet" : "Değiştir") {
                            if isEditing {
                                let newUserModel = UpdateUserRequestModel(name: name, surname: surname, email: email)
                                viewModel.updateUser(newUserModel)
                                viewModel.fetchProfile()
                            } else {
                                name = user.name
                                surname = user.surname
                                email = user.email
                            }
                            isEditing.toggle()
                        }
                        .padding()
                        .frame(width: 200)
                        .background(isEditing ? Color.green : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                    
                    Text("Beğenilen Filmler: \(user.likedMovies.count)")
                    
                    Text("Üyelik Tarihi: \(user.createdAt.formattedDate())")
                        
                        
                    
                    Spacer()
                    
                    HStack{
                        Button(action: {
                            viewModel.logOut(appState: appState)
                        }) {
                            Text("Çıkış Yap")
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }.frame(maxWidth : .infinity)
                    
                    Spacer(minLength: 20)
                    
                }
                
            }
            .onAppear {
                viewModel.fetchProfile()
            }
            .padding()
            .background(
                Image("Bg")
                    .resizable()
                    .ignoresSafeArea()
            )
        }
    }
}
