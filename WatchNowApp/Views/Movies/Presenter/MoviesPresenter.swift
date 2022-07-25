//
//  MoviesPresenter.swift
//  WatchNowApp
//
//  Created by Rafael Oliveira on 25/07/22.
//

import Foundation
import UIKit

typealias MoviesDelegate = MoviePresenterDelegate & UICollectionViewCell

protocol MoviePresenterDelegate: AnyObject{
    func presentMovies(movies: [Movie]) async
}

class MoviePresenter{
    
    weak var delegate: MoviesDelegate?
    private var movieService = MovieStore.shared
    
    public func getMovies(endpoint: MovieListEndpoint) async {
        
        do{
            let movies = try await movieService.fetchMovies(from: endpoint)
            await self.delegate?.presentMovies(movies: movies)
        }catch{
            print("Error")
        }
    }
    
    public func setViewDelegate(delegate: MoviesDelegate){
        self.delegate = delegate
    }
}
