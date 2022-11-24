//
//  DataModel.swift
//  Loop_Demo
//
//  Created by MOKSHA on 31/10/22.
//

import Foundation

struct MoivesInfo: Codable {
    let Moives: [Moives]
}

struct Cast : Codable {
    let name : String?
    let pictureUrl : String?
    let character : String?

//    enum CodingKeys: String, CodingKey {
//
//        case name = "name"
//        case pictureUrl = "pictureUrl"
//        case character = "character"
//    }
//
//    init(dataDetails datadir: NSDictionary) {
//        
//        self.pictureUrl = datadir["pictureUrl"] as? String
//        self.name = datadir["name"] as? String
//        self.character = datadir["character"] as? String
//    }

}

struct Director : Codable {
    let name : String?
    let pictureUrl : String?

//    enum CodingKeys: String, CodingKey {
//
//        case name = "name"
//        case pictureUrl = "pictureUrl"
//    }
//
//    init(dataDetails datadir: NSDictionary) {
//        self.pictureUrl = datadir["pictureUrl"] as? String
//        self.name = datadir["name"] as? String
//    }

}


struct Moives : Codable {
    let rating : Double?
    let id : Int?
    let revenue : Int?
    let releaseDate : String?
    let director : Director?
    let posterUrl : String?
    let cast : [Cast]?
    let runtime : Int?
    let title : String?
    let overview : String?
    let reviews : Int?
    let budget : Int?
    let language : String?
    let genres : [String]?

    enum CodingKeys: String, CodingKey {

        case rating = "rating"
        case id = "id"
        case revenue = "revenue"
        case releaseDate = "releaseDate"
        case director = "director"
        case posterUrl = "posterUrl"
        case cast = "cast"
        case runtime = "runtime"
        case title = "title"
        case overview = "overview"
        case reviews = "reviews"
        case budget = "budget"
        case language = "language"
        case genres = "genres"
    }

    init(movieDetails datadir: NSDictionary) {

        self.rating = datadir["rating"] as? Double
        self.id = datadir["id"] as? Int
        self.revenue = datadir["revenue"] as? Int
        self.releaseDate = datadir["releaseDate"] as? String
        self.director = datadir["director"] as? Director
        self.posterUrl = datadir["posterUrl"] as? String
        self.cast = datadir["cast"] as? [Cast]
        self.runtime = datadir["runtime"] as? Int
        self.title = datadir["title"] as? String
        self.overview = datadir["overview"] as? String
        self.reviews = datadir["reviews"] as? Int
        self.budget = datadir["budget"] as? Int
        self.language = datadir["language"] as? String
        self.genres = datadir["genres"] as? [String]

    }

}

