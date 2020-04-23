//
//  MovieProtocol.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 20/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: class {
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouteProtocol? {get set}
    func startRequestMovie(page: Int, genres: [String])
    func searchMovie(page: Int, keyword: String)
    func showMovieDetail(movieID: Int, navigationController: UINavigationController)
    func showMovieGenres(selectedGenre: [String], navigationController: UINavigationController)
}

protocol PresenterToViewProtocol: class {
    func showMovie(movieArray: [MovieModel])
}

protocol PresenterToRouteProtocol: class {
    static func createModule() -> MovieViewController
    func pushToMovieDetail(movieID: Int, navigationController: UINavigationController)
    func pushToMovieGenres(selectedGenre: [String], navigationController: UINavigationController)
}

protocol PresenterToInteractorProtocol: class {
    var presenter: InteractorToPresenterProtocol? {get set}
    var genreList: [GenreModel]? { get set }
    func requestMovie(page: Int, genres: [String])
    func searchMovie(page: Int, keyword: String)
    func getMovieImage(imageURL: String) -> UIImage
    func requestGenre(completionHandler: () -> Void)
}

protocol InteractorToPresenterProtocol: class {
    func movieRequestSuccess(movieArray: [MovieModel])
    func movieRequestFailed(error: String)
    func movieSearchSuccess(movieArray: [MovieModel])
    func movieSearchFailed(error: String)
}
