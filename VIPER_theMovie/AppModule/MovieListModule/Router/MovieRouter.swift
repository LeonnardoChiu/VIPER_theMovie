//
//  MovieRouter.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 21/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import Foundation
import UIKit

class MovieRouter: PresenterToRouteProtocol {
    
    static func createModule() -> MovieViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(identifier: "MovieViewController") as! MovieViewController
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = MoviePresenter()
        let interactor: PresenterToInteractorProtocol = MovieInteractor()
        let router: PresenterToRouteProtocol = MovieRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static func createModuleWithGenre(selectedGenre: [String]) -> MovieViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(identifier: "MovieViewController") as! MovieViewController
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = MoviePresenter()
        let interactor: PresenterToInteractorProtocol = MovieInteractor()
        let router: PresenterToRouteProtocol = MovieRouter()
        
        view.selectedGenre = selectedGenre
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToMovieDetail(movieID: Int, navigationController: UINavigationController) {
        let movieDetailModule = MovieDetailRouter.createModule(movieID: movieID)
        navigationController.pushViewController(movieDetailModule, animated: true)
    }
    
    func pushToMovieGenres(selectedGenre: [String], navigationController: UINavigationController) {
        let movieGenresModule = MovieGenreRouter.createModule(selectedGenre: selectedGenre)
        navigationController.pushViewController(movieGenresModule, animated: true)
    }
    
}
