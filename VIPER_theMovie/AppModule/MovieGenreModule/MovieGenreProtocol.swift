//
//  MovieGenreProtocol.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 23/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterMovieGenreProtocol: class {
    var view: PresenterToViewMovieGenreProtocol? {get set}
    var interactor: PresenterToInteractorMovieGenreProtocol? {get set}
    var router: PresenterToRouteMovieGenreProtocol? {get set}
    
    func startRequestGenres()
    
    func passGenre(selectedGenre: [String], navigationController: UINavigationController)
}

protocol PresenterToViewMovieGenreProtocol: class {
    func showGenreList(genreList: [MovieGenreModel])
}

protocol PresenterToRouteMovieGenreProtocol: class {
    static func createModule(selectedGenre: [String]) -> MovieGenreViewController
    func backToMovieList(selectedGenre: [String], navigationController: UINavigationController)
}

protocol PresenterToInteractorMovieGenreProtocol: class {
    var presenter: InteractorToPresenterMovieGenreProtocol? {get set}
    func requestGenres()
}

protocol InteractorToPresenterMovieGenreProtocol: class {
    func requestMovieGenresSuccess(genreList: [MovieGenreModel])
    func requestMovieGenresFailed(error: String)
}
