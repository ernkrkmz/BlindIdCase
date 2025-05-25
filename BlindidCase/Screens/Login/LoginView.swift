//
//  LoginView.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//


import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                
                TextField("E-mail", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
                
                Button("Login") {
                    viewModel.login(appState: appState)

                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.yellow)
                .foregroundColor(.black)
                .cornerRadius(8)
                
                Spacer()
                
                NavigationLink(destination: RegisterView()) {
                    Text("Don't you have an account?")
                        
                }
                
            }
            .padding()
            .background(
                Image("Bg")
                    .resizable()
                    .ignoresSafeArea()
            )
        }.tint(.yellow)
        
    }
}

