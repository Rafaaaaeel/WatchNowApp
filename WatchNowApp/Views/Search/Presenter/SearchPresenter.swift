//
//  SearchPresenter.swift
//  WatchNowApp
//
//  Created by Rafael Oliveira on 25/07/22.
//

import Foundation
import UIKit

typealias SearchDelegate = SearchPresenterDelegate & UIViewController

protocol SearchPresenterDelegate: AnyObject{
    func presentMovies(movies: [Movie]) async
}

class SearchPresenter{
    
    weak var delegate: SearchDelegate?
    private var movieservice = MovieStore.shared
    
    public func getMoviesByQuery(text: String) async {
        
        do{
            let movies = try await movieservice.searchMovie(query: text)
            await self.delegate?.presentMovies(movies: movies)
        }catch{
            print("Error")
        }
    }
    
    public func showNewScreen(movieID: Int){
        let vc = MovieViewController(movieID: movieID)
        self.delegate?.navigationController?.pushViewController(vc, animated: true )
    }
    
    public func setViewDelegate(delegate: SearchDelegate){
        self.delegate = delegate
    }
}
