//
//  Movie.swift
//  WatchNowApp
//
//  Created by Rafael Oliveira on 25/07/22.
//

import Foundation

// MARK: New code
struct MovieResponse: Decodable{
    let results: [Movie]
}

struct GenreResponse: Decodable{
    let genres: [Genre]
}

struct Movie: Decodable, Identifiable{
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runTime: Int?
    let genreIds: [Int]?
    
    var backdropURL: String {
        return "https://image.tmdb.org/t/p/original/\(backdropPath ?? "nothing")"
    }
    
    var posterURL: String {
        return "https://image.tmdb.org/t/p/w342/\(posterPath ?? "nothing")"
    }
}

struct Genre: Decodable, Identifiable{
    let id: Int
    let name: String
    
}
