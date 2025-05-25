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
                    Text("Profil")
                        .font(.headline)
                        .fontWeight(.bold)
                    if isEditing {
                        TextField("Name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Surname", text: $surname)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                    } else {
                        Text("Name: \(user.name)")
                        Text("Surname: \(user.surname)")
                        Text("Email: \(user.email)")
                    }
                    
                    HStack {
                        Button(isEditing ? "Save" : "Change") {
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
                        .background(isEditing ? Color.green : Color.yellow)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                    
                    Text("Liked movie count: \(user.likedMovies.count)")
                    
                    Text("Created at: \(user.createdAt.formattedDate())")
                    Spacer()
                    HStack{
                        Button(action: {
                            viewModel.logOut(appState: appState)
                        }) {
                            Text("Logout")
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
