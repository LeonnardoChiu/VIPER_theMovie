//
//  MovieDetailModel.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 22/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import Foundation
import ObjectMapper

private let MOVIE_ID = "id"
private let BACKDROP_PATH = "backdrop_path"
private let ORIGINAL_TITLE = "original_title"
private let TAGLINE = "tagline"
private let OVERVIEW = "overview"
private let VOTE_AVERAGE = "vote_average"
private let GENRES = "genres"
private let STATUS = "status"
private let RELEASE_DATE = "release_date"
private let RUNTIME = "runtime"

private let GENRE_ID = "id"
private let GENRE_NAME = "name"

private let REVIEW_ID = "id"
private let REVIEW_AUTHOR = "author"
private let REVIEW_CONTENT = "content"

private let VIDEO_ID = "id"
private let VIDEO_KEY = "key"

class MovieDetailModel: Mappable {
    internal var id: Int?
    internal var backdrop_path: String?
    internal var original_title: String?
    internal var tagline: String?
    internal var overview: String?
    internal var vote_average: Double?
    internal var genres: [MovieDetailGenreModel]?
    internal var status: String?
    internal var release_date: String?
    internal var runtime: Int?
    
    internal var backdrop_image: UIImage?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map[MOVIE_ID]
        backdrop_path <- map[BACKDROP_PATH]
        original_title <- map[ORIGINAL_TITLE]
        tagline <- map[TAGLINE]
        overview <- map[OVERVIEW]
        vote_average <- map[VOTE_AVERAGE]
        genres <- map[GENRES]
        status <- map[STATUS]
        release_date <- map[RELEASE_DATE]
        runtime <- map[RUNTIME]
    }
    
}

class MovieDetailGenreModel: Mappable {
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

class MovieReviewModel: Mappable {
    internal var id: Int?
    internal var author: String?
    internal var content: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map[REVIEW_ID]
        author <- map[REVIEW_AUTHOR]
        content <- map[REVIEW_CONTENT]
    }
}

class MovieVideoModel: Mappable {
    internal var id: Int?
    internal var key: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map[VIDEO_ID]
        key <- map[VIDEO_KEY]
    }
}
