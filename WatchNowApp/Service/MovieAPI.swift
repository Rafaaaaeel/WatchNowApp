//
//  MovieAPI.swift
//  WatchNowApp
//
//  Created by Rafael Oliveira on 25/07/22.
//

import Foundation

class MovieStore: MovieService {
    
    static let shared = MovieStore()
    private init() {}
    
    private let apiKey = "edc2152165299261835d73c2a0848d24"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovies(from endpoint: MovieListEndpoint) async throws -> [Movie] {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)?api_key=\(apiKey)&language=en-US&page=1") else {
            throw MovieError.invalidEndpoint
        }
        
        let movieResponse: MovieResponse = try await self.loadURLAndDecode(url: url)
        
        return movieResponse.results
    }
    
    func fetchMovie(id: Int) async throws -> Movie {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            throw MovieError.invalidEndpoint
        }
        
        return try await self.loadURLAndDecode(url: url, params: [
            "append_to_response":"videos,credits"])
    }
    
    func fetchSimilarMovies(id: Int) async throws -> [Movie] {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)/similar?") else {
            throw MovieError.invalidEndpoint
        }
        
        let movieResponse: MovieResponse = try await self.loadURLAndDecode(url: url)
        
        return movieResponse.results
    }
    
    func fetchGenres() async throws -> [Genre] {
        guard let url = URL(string: "\(baseAPIURL)/genre/movie/list?\(apiKey)&language=en-US") else {
            throw MovieError.invalidEndpoint
        }
        let genreRsponse: GenreResponse  = try await self.loadURLAndDecode(url: url)
        
        return genreRsponse.genres
    }

    func searchMovie(query: String) async throws -> [Movie] {
        guard let url = URL(string: "\(baseAPIURL)/search/movie") else {
            throw MovieError.invalidEndpoint
        }
        
        let movieResponse: MovieResponse = try await self.loadURLAndDecode(url: url, params: [
            "language":"en-US",
            "iclude_adults":"false",
            "region":"US",
            "query":query
        ])
        
        return movieResponse.results
    }
    
    private func loadURLAndDecode<D:Decodable>(url: URL, params: [String: String]? = nil) async throws -> D{
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw MovieError.invalidEndpoint
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        if let params = params {
            queryItems.append(contentsOf: params.map {URLQueryItem(name: $0.key, value: $0.value)})
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            throw MovieError.invalidEndpoint
        }
        print(finalURL)
        
        let (data, response) = try await urlSession.data(from: finalURL)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw MovieError.invalidResponse
        }
        
        return try self.jsonDecoder.decode(D.self, from: data)
    }
    
}
