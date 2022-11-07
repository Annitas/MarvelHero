//
//  HeroModel.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 02.11.2022.
//

struct Hero: Decodable {
    var name: String?
    var description: String?
    var path: String? 
    var message: String?
    var code: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case path = "path"
        case code = "code"
        case message = "message"
    }
}
