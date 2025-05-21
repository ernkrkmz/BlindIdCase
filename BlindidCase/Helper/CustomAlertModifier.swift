//
//  CustomAlertModifier.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//

import SwiftUI

struct CustomAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    let message: String
    let isSuccess: Bool

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)

                CustomAlertView(
                    title: title,
                    message: message,
                    isSuccess: isSuccess
                ) {
                    isPresented = false
                }
                .transition(.scale)
                .zIndex(1)
            }
        }
    }
}
