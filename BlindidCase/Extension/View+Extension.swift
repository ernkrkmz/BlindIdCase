//
//  View+Extension.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//
import SwiftUI

extension View {
    func customAlert(isPresented: Binding<Bool>, title: String, message: String, isSuccess: Bool = true) -> some View {
        self.modifier(CustomAlertModifier(isPresented: isPresented, title: title, message: message, isSuccess: isSuccess))
    }
}
