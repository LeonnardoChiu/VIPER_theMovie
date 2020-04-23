//
//  MovieGenrePresenter.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 23/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import Foundation
import UIKit

class MovieGenrePresenter: ViewToPresenterMovieGenreProtocol {
    
    var view: PresenterToViewMovieGenreProtocol?
    
    var interactor: PresenterToInteractorMovieGenreProtocol?
    
    var router: PresenterToRouteMovieGenreProtocol?
    
    func startRequestGenres() {
        interactor?.requestGenres()
    }
    
    func passGenre(selectedGenre: [String], navigationController: UINavigationController) {
        router?.backToMovieList(selectedGenre: selectedGenre, navigationController: navigationController)
    }
}

extension MovieGenrePresenter: InteractorToPresenterMovieGenreProtocol {
    func requestMovieGenresSuccess(genreList: [MovieGenreModel]) {
        view?.showGenreList(genreList: genreList)
    }
    
    func requestMovieGenresFailed(error: String) {
        print(error)
    }
    
    
    
}
