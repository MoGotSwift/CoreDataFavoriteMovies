//
//  MovieController.swift
//  CoreDataFavoriteMovies
//
//  Created by Parker Rushton on 11/1/22.
//


//import Foundation
//import CoreData
//
//class MovieController {
//    static let shared = MovieController()
//
//    private let apiController = MovieAPIController()
//    private var viewContext = PersistenceController.shared.viewContext
//
//    func fetchMovies(with searchTerm: String) async throws -> [APIMovie] {
//        return try await apiController.fetchMovies(with: searchTerm)
//    }
//
//    func favoriteMovie(_ movie: APIMovie) {
//        let newMovie = Movie(context: viewContext)
//        newMovie.title = movie.title
//        newMovie.year = movie.year
//        newMovie.imdbID = movie.imdbID
//        newMovie.posterURL = movie.posterURL?.absoluteString
//
//        do {
//            try viewContext.save()
//            print("Movie saved to Core Data")
//        } catch {
//            print("Failed to save movie to Core Data: \(error)")
//        }
//    }
//
//    func fetchFavoriteMovies() -> [Movie] {
//        let request = Movie.fetchRequest()
//        do {
//            let favs: [Movie] = try viewContext.fetch(request)
//            return favs
//        } catch {
//            print("Fetch failed")
//            return []
//        }
//    }
//
//    func unfavoriteMovie(_ movie: Movie) {
//        viewContext.delete(movie)
//
//        do {
//            try viewContext.save()
//            print("Movie removed from Core Data")
//        } catch {
//            print("Failed to remove movie from Core Data: \(error)")
//        }
//    }
//}


import Foundation
import CoreData

class MovieController {
    static let shared = MovieController()

    private let apiController = MovieAPIController()
    private var viewContext = PersistenceController.shared.viewContext
    
    func fetchMovies(with searchTerm: String) async throws -> [APIMovie] {
        return try await apiController.fetchMovies(with: searchTerm)
    }
    
    func favoriteMovie(_ movie: APIMovie) {
        if let newMovie = favoriteMovie(from: movie) {
            do {
                try viewContext.save()
                print("Movie saved to Core Data")
            } catch {
                print("Failed to save movie to Core Data: \(error)")
            }
        }
    }
    
    func favoriteMovie(from movie: APIMovie) -> Movie? {
        let newMovie = Movie(context: viewContext)
        newMovie.title = movie.title
        newMovie.year = movie.year
        newMovie.imdbID = movie.imdbID
        newMovie.posterURL = movie.posterURL?.absoluteString
        return newMovie
    }
    
    func fetchFavoriteMovies() -> [Movie] {
        let request = Movie.fetchRequest()
        do {
            let favs: [Movie] = try viewContext.fetch(request)
            return favs
        } catch {
            print("Fetch failed")
            return []
        }
    }
    
    func unfavoriteMovie(_ movie: Movie) {
        viewContext.delete(movie)
        
        do {
            try viewContext.save()
            print("Movie removed from Core Data")
        } catch {
            print("Failed to remove movie from Core Data: \(error)")
        }
    }
}
