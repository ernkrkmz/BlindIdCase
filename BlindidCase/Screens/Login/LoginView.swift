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
                    viewModel.login(email: "john@example.com", password: "password123")
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
                
            }
            .padding()
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                Text("Hoş geldin, \(viewModel.email)!")
                    .font(.title)
            }
        }
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
