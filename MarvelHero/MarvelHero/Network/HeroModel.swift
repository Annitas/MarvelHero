//
//  HeroModel.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 02.11.2022.
//

//struct Hero: Decodable {
////    var name: String?
////    var description: String?
////    var path: String? //The directory path of to the image
//    private var message: String?
//    private var code: String?
//
//    enum CodingKeys: String, CodingKey {
////        case name = "name"
////        case description = "description"
////        case path = "path"
//        case code = "code"
//        case message = "message"
//    }
//}
struct MarvelInfo: Codable {
    let code:Int
    let status:String
    let data:MarvelData
}

struct MarvelData: Codable {
    let offset:Int
    let limit:Int
    let total:Int
    let count:Int
    let results:[Hero]
}

struct Hero: Codable {
    let id:Int
    let name:String
    let description:String
    let thumbnail:Thumbnail
    let urls: [HeroURL]
}

struct Thumbnail: Codable {
    let path: String
    let ext: String

    var url: String {
        return path + "." + ext
    }

    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}

struct HeroURL:Codable {
    let type:String
    let url:String
}
