//
//  MovieGenreModel.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 23/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import Foundation
import ObjectMapper

private var GENRE_ID = "id"
private var GENRE_NAME = "name"

class MovieGenreModel: Mappable {
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
