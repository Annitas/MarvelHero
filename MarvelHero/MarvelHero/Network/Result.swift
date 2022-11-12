//
//  Result.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 12.11.2022.
//

struct HeroResult {
    var name: String
    var description: String

    init?(json: [String: Any]) {

        guard
            let name = json["name"] as? String,
            let description = json["description"] as? String
        else {
            return nil
        }

        self.name = name
        self.description = description
    }

    static func getArray(from jsonArray: Any) -> [HeroResult]? {

        guard let jsonArray = jsonArray as? Array<[String: Any]> else { return nil }
        var posts: [HeroResult] = []

        for jsonObject in jsonArray {
            if let post = HeroResult(json: jsonObject) {
                posts.append(post)
            }
        }
        return posts
    }
}
