//
//  MovieGenrePresenter.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 23/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import Foundation

class MovieGenrePresenter: ViewToPresenterMovieGenreProtocol {
    var view: PresenterToViewMovieGenreProtocol?
    
    var interactor: PresenterToInteractorMovieGenreProtocol?
    
    var router: PresenterToRouteMovieGenreProtocol?
    
}

extension MovieGenrePresenter: InteractorToPresenterMovieGenreProtocol {
    
    
}
