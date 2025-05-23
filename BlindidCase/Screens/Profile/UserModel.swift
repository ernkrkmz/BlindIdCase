//
//  User.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 22.05.2025.
//


struct User: Decodable {
    let _id: String
    var name: String
    var surname: String
    var email: String
    let likedMovies: [Int]
    let createdAt: String
    let updatedAt: String
}

struct UserResponse: Decodable {
    let name: String
    let surname: String
    let email: String
}

struct UpdateUserRequestModel: Encodable {
    let name: String
    let surname: String
    let email: String
    
}
