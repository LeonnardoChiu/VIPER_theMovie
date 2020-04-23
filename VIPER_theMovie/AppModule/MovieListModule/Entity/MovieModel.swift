//
//  MovieModel.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 20/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import Foundation
import ObjectMapper

private let MOVIE_ID = "id"
private let TITLE = "title"
private let GENRE_IDS = "genre_ids"
private let RELEASED_DATE = "released_date"
private let VOTE_AVERAGE = "vote_average"
private let POSTER_PATH = "poster_path"

private let GENRE_ID = "id"
private let GENRE_NAME = "name"

class MovieModel: Mappable {
    internal var id: Int?
    internal var title: String?
    internal var genre_ids: [Int]?
    internal var released_date: String?
    internal var vote_average: Double?
    internal var poster_path: String?
    
    internal var genres: String?
    internal var movie_image: UIImage?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map[MOVIE_ID]
        title <- map[TITLE]
        genre_ids <- map[GENRE_IDS]
        released_date <- map[RELEASED_DATE]
        vote_average <- map[VOTE_AVERAGE]
        poster_path <- map[POSTER_PATH]
    }
    
}

class GenreModel: Mappable {
    internal var id: Int?
    internal var name: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map[GENRE_ID]
        name <- map[GENRE_NAME]
    }
}
