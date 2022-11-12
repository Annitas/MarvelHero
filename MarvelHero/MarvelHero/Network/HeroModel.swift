//
//  HeroModel.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 02.11.2022.
//

struct MarvelData: Decodable {
  /// The list of characters returned by the call.
    let results: [Character]?
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct Character: Decodable {
  /// The unique ID of the character resource.
    let id: Int?
  /// The name of the character.
    let name: String?
  ///  A short bio or description of the character.
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
  /// The HTTP status code of the returned result.
    let code: Int?
  /// The results returned by the call.
    let data: MarvelData?

    enum CodingKeys: String, CodingKey {
        case code
        case data
    }
}
