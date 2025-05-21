//
//  CustomAlertView.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//


import SwiftUI

struct CustomAlertView: View {
    var title: String
    var message: String
    var isSuccess: Bool
    var onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: isSuccess ? "checkmark.circle" : "xmark.octagon")
                .font(.system(size: 40))
                .foregroundColor(isSuccess ? .green : .red)

            Text(title)
                .font(.headline)

            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)

            Button("Kapat") {
                onDismiss()
            }
            .padding(.top, 8)
        }
        .padding()
        .frame(maxWidth: 300)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 10)
    }
}
