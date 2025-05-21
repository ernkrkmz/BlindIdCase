//
//  NetworkManager.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 21.05.2025.
//


import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func postRequest<T: Decodable>(
        url: String,
        body: [String: Any],
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let requestUrl = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if let token = AuthManager.shared.token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    
    func getRequest<T: Decodable>(
            url: String,
            responseType: T.Type,
            completion: @escaping (Result<T, Error>) -> Void
        ) {
            guard let requestUrl = URL(string: url) else {
                completion(.failure(NSError(domain: "Invalid URL", code: 0)))
                return
            }

            var request = URLRequest(url: requestUrl)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            if let token = AuthManager.shared.token {
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NSError(domain: "No data", code: 0)))
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
         
}

//MARK: - Auth
extension NetworkManager {
    
    func loginUser(
        email: String,
        password: String,
        completion: @escaping (Result<LoginResponse, Error>) -> Void
    ) {
        let body: [String: Any] = [
            "email": email,
            "password": password
        ]

        postRequest(
            url: "https://moviatask.cerasus.app/api/auth/login",
            body: body,
            responseType: LoginResponse.self,
            completion: completion
        )
    }
    
    func registerUser(
            name: String,
            surname: String,
            email: String,
            password: String,
            completion: @escaping (Result<RegisterResponse, Error>) -> Void
        ) {
            let body: [String: Any] = [
                "name": name,
                "surname": surname,
                "email": email,
                "password": password
            ]

            postRequest(
                url: "https://moviatask.cerasus.app/api/auth/register",
                body: body,
                responseType: RegisterResponse.self,
                completion: completion
            )
        }
}
//MARK: - GET functions
extension NetworkManager {
    
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        getRequest(
            url: "https://moviatask.cerasus.app/api/movies",
            responseType: [Movie].self,
            completion: completion
        )
    }
    
    func getLikedMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
            let url = "https://moviatask.cerasus.app/api/users/liked-movies"
            getRequest(url: url, responseType: [Movie].self, completion: completion)
        }
}

//MARK: - POST functions

extension NetworkManager {
    func likeMovie(movieId: Int, completion: @escaping (Result<LikeResponse, Error>) -> Void) {
        let url = "https://moviatask.cerasus.app/api/movies/like/\(movieId)"
        
        postRequest(
            url: url,
            body: [:], 
            responseType: LikeResponse.self,
            completion: completion
        )
    }
    func unlikeMovie(movieId: Int, completion: @escaping (Result<LikeResponse, Error>) -> Void) {
        let url = "https://moviatask.cerasus.app/api/movies/unlike/\(movieId)"
        
        postRequest(
            url: url,
            body: [:],
            responseType: LikeResponse.self,
            completion: completion
        )
    }
}

