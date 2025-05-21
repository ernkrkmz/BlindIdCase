//
//  RegisterResponse.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//


struct RegisterResponse: Decodable {
    let token: String?
    let message: String?
}