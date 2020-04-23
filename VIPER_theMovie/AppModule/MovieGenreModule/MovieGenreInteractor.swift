//
//  MovieGenreInteractor.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 23/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class MovieGenreInteractor: PresenterToInteractorMovieGenreProtocol {
    
    var presenter: InteractorToPresenterMovieGenreProtocol?
    
    func requestGenres() {
        Alamofire.request("\( baseURL)genre/movie/list?api_key=\(apiKey)").responseJSON { (response) in

            switch response.result {
            case .success:
                if let json = response.result.value as AnyObject? {
                    let arrayResponse = json["genres"]
                    let arrayGenre = Mapper<MovieGenreModel>().mapArray(JSONArray: arrayResponse as! [[String : Any]])
                    
                    self.presenter?.requestMovieGenresSuccess(genreList: arrayGenre)
                }
                
            case .failure(let error):
                self.presenter?.requestMovieGenresFailed(error: error.localizedDescription)
            }
        }

    }
}
