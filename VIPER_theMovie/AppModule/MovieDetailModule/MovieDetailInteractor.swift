//
//  MovieDetailInteractor.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 22/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class MovieDetailInteractor: PresenterToInteractorMovieDetailProtocol {
    
    
    var presenter: InteractorToPresenterMovieDetailProtocol?
    
    func requestMovieDetail(movieID: Int) {
        Alamofire.request("\( baseURL)movie/\(movieID)?api_key=\(apiKey)&language=en-US").responseJSON { (response) in
            
            switch response.result {
            case .success:
                if let movieDetailResponse = response.result.value as AnyObject? {
                    let movieDetail = Mapper<MovieDetailModel>().map(JSONObject: movieDetailResponse)
                    
                    movieDetail?.backdrop_image = self.getMovieImage(imageURL: movieDetail?.backdrop_path ?? "")
                    
                    self.presenter?.movieDetailRequestSuccess(movieDetail: movieDetail!)
                }
                
            case .failure(let error):
                self.presenter?.movieDetailRequestFailed(error: error.localizedDescription)
            }
        }
    }
    
    func getMovieImage(imageURL: String) -> UIImage {
        let urlKey = "\(imgBaseURL)\(imageURL)"
        let noImage = UIImage(systemName: "film")
        var movieImage:UIImage?
        
        if let url = URL(string: urlKey) {
            do{
                let data = try Data(contentsOf: url)
                movieImage = UIImage(data: data)
                
            }catch let error {
                print(error.localizedDescription)
            }
            return movieImage ?? noImage!
        }
        
        return noImage!
    }
    
    func requestMovieReview(movieID: Int, page: Int) {
        Alamofire.request("\(baseURL)movie/\(movieID)/reviews?api_key=\(apiKey)&language=en-US&page=\(page)").responseJSON { (response) in

            switch response.result {
            case .success:
                if let json = response.result.value as AnyObject? {
                    let arrayResponse = json["results"]
                    let arrayReview = Mapper<MovieReviewModel>().mapArray(JSONArray: arrayResponse as! [[String : Any]])
                    
                    self.presenter?.movieReviewRequestSuccess(movieReview: arrayReview)
                }
                
                
            case .failure(let error):
                self.presenter?.movieReviewRequestFailed(error: error.localizedDescription)
            }
        }
    }
    
    
    func getMovieTrailer(movieID: Int) {
        Alamofire.request("\(baseURL)movie/\(movieID)/videos?api_key=\(apiKey)&language=en-US").responseJSON { (response) in

            switch response.result {
            case .success:
                if let json = response.result.value as AnyObject? {
                    let arrayResponse = json["results"]
                    let arrayVideo = Mapper<MovieVideoModel>().mapArray(JSONArray: arrayResponse as! [[String : Any]])
                    
                    self.presenter?.movieVideoRequestSuccess(movieVideo: arrayVideo)
                }
                
                
            case .failure(let error):
                self.presenter?.movieVideoRequestFailed(error: error.localizedDescription)
            }
        }
    }
    
    
}
