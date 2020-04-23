//
//  MovieGenreRouter.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 23/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import Foundation
import UIKit

class MovieGenreRouter: PresenterToRouteMovieGenreProtocol {
    
    var window: UIWindow?

    static func createModule(selectedGenre: [String]) -> MovieGenreViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(identifier: "MovieGenreViewController") as! MovieGenreViewController
            
        let presenter: ViewToPresenterMovieGenreProtocol & InteractorToPresenterMovieGenreProtocol = MovieGenrePresenter()
        let interactor: PresenterToInteractorMovieGenreProtocol = MovieGenreInteractor()
        let router: PresenterToRouteMovieGenreProtocol = MovieGenreRouter()
        
        view.selectedGenre = selectedGenre
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func backToMovieList(selectedGenre: [String], navigationController: UINavigationController) {
        let movieModule = MovieRouter.createModuleWithGenre(selectedGenre: selectedGenre)
        
        navigationController.viewControllers[0] = movieModule
        
        navigationController.popToRootViewController(animated: true)
        
    }
    
}
