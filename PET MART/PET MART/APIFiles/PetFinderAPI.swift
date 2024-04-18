//
//  PetFinderAPI.swift
//  PET MART
//
//  Created by Vinay Reddy Gujjula on 4/6/24.
//

import Foundation

class APIConstants {
    static let clientId = "kK4MSKCnl6f8CT0w7qPg9c9VfwfOFPfdQe8CUcPfxWLxMbvQXI"
    static let clientSecret = "D31cBJy3f7LMBCU8tgyNMqoNlmmG3JdD1Hhn4ZhA"
    static let host = "api.petfinder.com"
    static let grantType = "client_credentials"
    
    static let bodyParams = [
        "client_id": clientId,
        "client_secret": clientSecret,
        "grant_type": grantType
    ]
}

class APIService {
    
    static let shared = APIService()
    
    private init() {}
    
    func createAccessTokenRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.host
        components.path = "/v2/oauth2/token"
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: APIConstants.bodyParams)
        return urlRequest
    }
    
    func getAccessToken() async throws -> Token {
        let urlRequest = try createAccessTokenRequest()
        let (data, httpResponse) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = httpResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let results = try decoder.decode(Token.self, from: data)
        return results
    }
    
    func fetchAnimalsData() async throws -> [Animal] {
        let token = try await APIService.shared.getAccessToken()
        guard let url = URL(string: "https://api.petfinder.com/v2/animals?limit=100") else {
            throw NetworkError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("Bearer " + token.accessToken, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, httpResponse) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = httpResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let results = try decoder.decode(Response.self, from: data)
            return results.animals
        } catch {
            print("Error decoding JSON: \(error)")
        }
        return []
    }
}

struct Token: Codable {
    let tokenType: String
    let expiresIn: Int
    let accessToken: String
}

struct Response: Codable {
    let animals: [Animal]
}
