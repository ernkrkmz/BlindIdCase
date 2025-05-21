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

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterUrl = "poster_url"
    }
}
