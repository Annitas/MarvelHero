//
//  HeroModel.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 02.11.2022.
//

struct MarvelData: Decodable {
    let results: [Character]?
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct Character: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: Thumbnail?
}

struct Thumbnail: Decodable {
    let path: String?
    let ext: String?
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}

struct CharacterDataWrapper: Decodable {
    let code: Int?
    let data: MarvelData?

    enum CodingKeys: String, CodingKey {
        case code
        case data
    }
}
