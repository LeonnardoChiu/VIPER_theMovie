//
//  MovieDetailProtocol.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 22/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterMovieDetailProtocol: class {
    var view: PresenterToViewMovieDetailProtocol? {get set}
    var interactor: PresenterToInteractorMovieDetailProtocol? {get set}
    var router: PresenterToRouteMovieDetailProtocol? {get set}
    
    func startRequestMovieDetail(movieID: Int)
    func startRequestMovieReview(movieID: Int, page: Int)
    func getTrailerVideo(movieID: Int)
}

protocol PresenterToViewMovieDetailProtocol: class {
    func showMovieDetail(movieDetail: MovieDetailModel)
    func showMovieReview(movieReview: [MovieReviewModel])
    func showMovieTrailer(movieVideo: [MovieVideoModel])
}

protocol PresenterToRouteMovieDetailProtocol: class {
    static func createModule(movieID: Int) -> MovieDetailViewController
}

protocol PresenterToInteractorMovieDetailProtocol: class {
    var presenter: InteractorToPresenterMovieDetailProtocol? {get set}
    func requestMovieDetail(movieID: Int)
    func getMovieImage(imageURL: String) -> UIImage
    func requestMovieReview(movieID: Int, page: Int)
    func getMovieTrailer(movieID: Int)
}

protocol InteractorToPresenterMovieDetailProtocol: class {
    func movieDetailRequestSuccess(movieDetail: MovieDetailModel)
    func movieDetailRequestFailed(error: String)
    func movieReviewRequestSuccess(movieReview: [MovieReviewModel])
    func movieReviewRequestFailed(error: String)
    func movieVideoRequestSuccess(movieVideo: [MovieVideoModel])
    func movieVideoRequestFailed(error: String)
}
