//
//  MovieAPIController.swift
//  CoreDataFavoriteMovies
//
//  Created by Parker Rushton on 11/1/22.
//

import Foundation

class MovieAPIController {
    
    let baseURL = URL(string: "https://www.omdbapi.com/")!
    let apiKey = "53a9027c"
    
    enum MovieError: Error {
        case invalidURL
    }
    
    
    func fetchMovies(with searchTerm: String) async throws -> [APIMovie] {
        // Create the URL with query parameters
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [
            URLQueryItem(name: "apikey", value: apiKey),
            URLQueryItem(name: "s", value: searchTerm)
        ]
        
        guard let url = urlComponents?.url else {
            throw MovieError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(SearchResponse.self, from: data)
        return response.movies
    }
}

    

