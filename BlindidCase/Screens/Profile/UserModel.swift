//
//  User.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 22.05.2025.
//


struct User: Decodable {
    let _id: String
    let name: String
    let surname: String
    let email: String
    let likedMovies: [Int]
    let createdAt: String
    let updatedAt: String
}
