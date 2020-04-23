//
//  MovieDetailRouter.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 22/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailRouter: PresenterToRouteMovieDetailProtocol {
    static func createModule(movieID: Int) -> MovieDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(identifier: "MovieDetailViewController") as! MovieDetailViewController
        
        view.movieID = movieID
        
        let presenter: ViewToPresenterMovieDetailProtocol & InteractorToPresenterMovieDetailProtocol = MovieDetailPresenter()
        let interactor: PresenterToInteractorMovieDetailProtocol = MovieDetailInteractor()
        let router: PresenterToRouteMovieDetailProtocol = MovieDetailRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
}
