//
//  MoviePresenter.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 21/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import Foundation
import UIKit

class MoviePresenter: ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouteProtocol?
    
    func startRequestMovie(page: Int, genres: [String]) {
        interactor?.requestMovie(page: page, genres: genres)
    }
    
    func searchMovie(page: Int, keyword: String) {
        interactor?.searchMovie(page: page, keyword: keyword)
    }
    
    func showMovieDetail(movieID: Int, navigationController: UINavigationController) {
        router?.pushToMovieDetail(movieID: movieID, navigationController: navigationController)
    }
    
    func showMovieGenres(selectedGenre: [String], navigationController: UINavigationController) {
        router?.pushToMovieGenres(selectedGenre: selectedGenre, navigationController: navigationController)
    }
    
}

extension MoviePresenter: InteractorToPresenterProtocol {
    
    func movieRequestSuccess(movieArray: [MovieModel]) {
        view?.showMovie(movieArray: movieArray)
    }
    
    func movieRequestFailed(error: String) {
        print(error)
    }
    
    func movieSearchSuccess(movieArray: [MovieModel]) {
        view?.showMovie(movieArray: movieArray)
    }
    
    func movieSearchFailed(error: String) {
        print(error)
    }
    
    
}
