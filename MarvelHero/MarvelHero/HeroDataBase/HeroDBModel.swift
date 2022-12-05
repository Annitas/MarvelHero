//
//  HeroDBModel.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 16.11.2022.
//

import RealmSwift

final class HeroDBModel: Object {
    @Persisted var name: String = ""
    @Persisted var descriptionHero: String = ""
    @Persisted var pictureHero = Data()
}
