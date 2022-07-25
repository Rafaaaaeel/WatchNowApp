//
//  MovieService.swift
//  WatchNowApp
//
//  Created by Rafael Oliveira on 25/07/22.
//

import Foundation

protocol MovieService {
    func fetchMovies(from endpoint: MovieListEndpoint) async throws -> [Movie]
    func fetchMovie(id: Int) async throws -> Movie
    func fetchSimilarMovies(id: Int) async throws -> [Movie]
    func searchMovie(query: String) async throws -> [Movie]
    func fetchGenres() async throws -> [Genre]
}

enum MovieListEndpoint: String, CaseIterable{
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    
    var description: String{
        switch self{
            
        case .nowPlaying:
            return "Now Playing"
        case .upcoming:
            return "Upcoming"
        case .topRated:
            return "Top Rated "
        case .popular:
            return "Popular"
        }
    }
}

enum MovieError: Error, CustomNSError{
    case apiError
    case invalidEndpoint
    case noData
    case invalidResponse
    case serializationError
    
    var localizedDescription: String{
        switch self {
        case .apiError:
            return "Failed to fetch the data"
        case .invalidEndpoint:
            return "Invaid Endpoint"
        case .noData:
            return "No data"
        case .invalidResponse:
            return "Invalid Response"
        case .serializationError:
            return "Failed to decode Data"
        }
    }
    
    var errorUserInfo: [String : Any]{
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
