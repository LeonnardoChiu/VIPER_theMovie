//
//  MovieInteractor.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 21/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper


class MovieInteractor: PresenterToInteractorProtocol {
    
    var presenter: InteractorToPresenterProtocol?
    
    var genreList: [GenreModel]?
    
    func requestMovie(page: Int, genres: [String]) {
        
        var selectedGenreConverted = ""
        
        if genres.count != 0 {
            selectedGenreConverted = genres.joined(separator: ",")
        }
        
        requestGenre {
            Alamofire.request("\( baseURL)discover/movie?api_key=\(apiKey)&language=en-US&include_adult=false&page=\(page)&with_genres=\(selectedGenreConverted)").responseJSON { (response) in

                switch response.result {
                case .success:
                    if let json = response.result.value as AnyObject? {
                        let arrayResponse = json["results"]
                        let arrayMovie = Mapper<MovieModel>().mapArray(JSONArray: arrayResponse as! [[String : Any]])
                        
                        for movie in arrayMovie {
                            movie.movie_image = self.getMovieImage(imageURL: movie.poster_path ?? "")

                            var genres = ""
                            for genreID in movie.genre_ids! {
                                for genre in self.genreList! {
                                    if genreID == genre.id {
                                        genres = genres + " | " + genre.name!
                                    }
                                }
                            }
                            genres = genres + " | "
                            movie.genres = genres
                        }
                        
                        self.presenter?.movieRequestSuccess(movieArray: arrayMovie)
                    }
                    
                    
                case .failure(let error):
                    self.presenter?.movieRequestFailed(error: error.localizedDescription)
                }
            }
        }
        
    }
    
    func searchMovie(page: Int, keyword: String) {
        let replacedKey = keyword.replacingOccurrences(of: " ", with: "%20")
        
        requestGenre {
            Alamofire.request("\(baseURL)search/movie?api_key=\(apiKey)&query=\(replacedKey)&page=\(page)").responseJSON { (response) in

                switch response.result {
                case .success:
                    if let json = response.result.value as AnyObject? {
                        let arrayResponse = json["results"]
                        let arrayMovie = Mapper<MovieModel>().mapArray(JSONArray: arrayResponse as! [[String : Any]])
                        
                        for movie in arrayMovie {
                            movie.movie_image = self.getMovieImage(imageURL: movie.poster_path ?? "")

                            var genres = ""
                            for genreID in movie.genre_ids! {
                                for genre in self.genreList! {
                                    if genreID == genre.id {
                                        genres = genres + " | " + genre.name!
                                    }
                                }
                            }
                            genres = genres + " | "
                            movie.genres = genres
                        }
                        
                        self.presenter?.movieSearchSuccess(movieArray: arrayMovie)
                    }
                    
                    
                case .failure(let error):
                    self.presenter?.movieSearchFailed(error: error.localizedDescription)
                }
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

    func requestGenre(completionHandler: () -> Void) {
        
        Alamofire.request("\( baseURL)genre/movie/list?api_key=\(apiKey)").responseJSON { (response) in

            switch response.result {
            case .success:
                if let json = response.result.value as AnyObject? {
                    let arrayResponse = json["genres"]
                    let arrayGenre = Mapper<GenreModel>().mapArray(JSONArray: arrayResponse as! [[String : Any]])
                    self.genreList = arrayGenre
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        completionHandler()
        
    }
    
}
