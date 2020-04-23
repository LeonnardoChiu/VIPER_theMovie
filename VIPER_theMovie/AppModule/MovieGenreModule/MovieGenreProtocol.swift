//
//  MovieGenreProtocol.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 23/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import Foundation

protocol ViewToPresenterMovieGenreProtocol: class {
    var view: PresenterToViewMovieGenreProtocol? {get set}
    var interactor: PresenterToInteractorMovieGenreProtocol? {get set}
    var router: PresenterToRouteMovieGenreProtocol? {get set}
}

protocol PresenterToViewMovieGenreProtocol: class {
    
}

protocol PresenterToRouteMovieGenreProtocol: class {
    static func createModule(selectedGenre: [String]) -> MovieGenreViewController
}

protocol PresenterToInteractorMovieGenreProtocol: class {
    var presenter: InteractorToPresenterMovieGenreProtocol? {get set}
    
}

protocol InteractorToPresenterMovieGenreProtocol: class {
    
}
