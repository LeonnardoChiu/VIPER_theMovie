//
//  MovieDetailPresenter.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 22/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import Foundation

class MovieDetailPresenter: ViewToPresenterMovieDetailProtocol {
    
    var view: PresenterToViewMovieDetailProtocol?
    
    var interactor: PresenterToInteractorMovieDetailProtocol?
    
    var router: PresenterToRouteMovieDetailProtocol?
    
    func startRequestMovieDetail(movieID: Int) {
        interactor?.requestMovieDetail(movieID: movieID)
    }
    
    func startRequestMovieReview(movieID: Int, page: Int) {
        interactor?.requestMovieReview(movieID: movieID, page: page)
    }
    
    func getTrailerVideo(movieID: Int) {
        interactor?.getMovieTrailer(movieID: movieID)
    }
}

extension MovieDetailPresenter: InteractorToPresenterMovieDetailProtocol {
    
    
    func movieDetailRequestSuccess(movieDetail: MovieDetailModel) {
        view?.showMovieDetail(movieDetail: movieDetail)
    }
    
    func movieDetailRequestFailed(error: String) {
        print(error)
    }
    
    func movieReviewRequestSuccess(movieReview: [MovieReviewModel]) {
        view?.showMovieReview(movieReview: movieReview)
    }
    
    func movieReviewRequestFailed(error: String) {
        print(error)
    }
    
    func movieVideoRequestSuccess(movieVideo: [MovieVideoModel]) {
        view?.showMovieTrailer(movieVideo: movieVideo)
    }
    
    func movieVideoRequestFailed(error: String) {
        print(error)
    }
}
