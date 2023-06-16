//
//  APIMovie.swift
//  CoreDataFavoriteMovies
//
//  Created by Parker Rushton on 11/5/22.
//

//import Foundation
//import CoreData
//
//struct SearchResponse: Codable {
//    let movies: [APIMovie]
//
//    enum CodingKeys: String, CodingKey {
//        case movies = "Search"
//    }
//}
//
//struct APIMovie: Codable, Identifiable, Hashable {
//    let title: String
//    let year: String
//    let imdbID: String
//    let posterURL: URL?
//
//    var id: String { imdbID }
//
//    enum CodingKeys: String, CodingKey {
//        case title = "Title"
//        case year = "Year"
//        case imdbID
//        case posterURL = "Poster"
//    }
//
//    init(from decoder: Decoder) throws {
//        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
//        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
//        self.year = try valueContainer.decode(String.self, forKey: CodingKeys.year)
//        self.imdbID = try valueContainer.decode(String.self, forKey: CodingKeys.imdbID)
//        self.posterURL = try valueContainer.decode(URL.self, forKey: CodingKeys.posterURL)
//    }
//
//}
//
//extension Movie {
//
//    var  posterURL: URL {
//        guard let posterURL = self.posterURL else {
//            return nil
//        }
//
//        return URL(string: posterURL)
//    }
//}

import Foundation
import CoreData

struct SearchResponse: Codable {
    let movies: [APIMovie]

    enum CodingKeys: String, CodingKey {
        case movies = "Search"
    }
}

struct APIMovie: Codable, Identifiable, Hashable {
    let title: String
    let year: String
    let imdbID: String
    let posterURL: URL?

    var id: String { imdbID }

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case posterURL = "Poster"
    }

    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try valueContainer.decode(String.self, forKey: .title)
        self.year = try valueContainer.decode(String.self, forKey: .year)
        self.imdbID = try valueContainer.decode(String.self, forKey: .imdbID)
        self.posterURL = try valueContainer.decodeIfPresent(URL.self, forKey: .posterURL)
    }

}

extension Movie  {
    var moviePosterURL: URL? {
           guard let posterURL = self.posterURL else {
               return nil
           }
   
        return URL(string: posterURL)
       }

}
