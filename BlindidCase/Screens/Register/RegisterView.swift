//
//  RegisterView.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//


import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Kayıt Ol")
                    .font(.largeTitle)
                    .bold()

                TextField("Ad", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)

                TextField("Soyad", text: $viewModel.surname)
                    .textFieldStyle(.roundedBorder)

                TextField("E-posta", text: $viewModel.email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    

                SecureField("Şifre", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }

                Button("Register") {
                    viewModel.register()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.yellow)
                .foregroundColor(.black)
                .cornerRadius(8)

                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $viewModel.isRegistered) {
                Text("Hoş geldin, \(viewModel.name)!")
                    .font(.title)
            }
        }.background(
            Image("Bg")
                .resizable()
                .ignoresSafeArea()
        )
    }
}

