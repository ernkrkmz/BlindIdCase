//
//  LoginView.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//


import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Giriş Yap")
                    .font(.largeTitle)
                    .bold()
                
                TextField("E-posta", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                
                SecureField("Şifre", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
                
                Button("Giriş Yap") {
                    print("burda")
                    viewModel.login()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Spacer()
                
                NavigationLink(destination: RegisterView()) {
                    Text("Hesabın yok mu?")
                }
                
                NavigationLink(
                    destination: MovieTabView(),
                    isActive: $viewModel.isLoggedIn
                ) {
                    EmptyView()
                }
            }
            .padding()
            
            
        }
    }
}

