//
//  Movie.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//


struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let posterUrl: String
    let category: String
    let rating: Double
    let description: String
    let actors: [String]

    enum CodingKeys: String, CodingKey {
        case id, title, category, rating, description, actors
        case posterUrl = "poster_url"
    }
}

