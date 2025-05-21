//
//  LoginResponse.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//


struct LoginResponse: Decodable {
    let token: String?
    let message: String?
}