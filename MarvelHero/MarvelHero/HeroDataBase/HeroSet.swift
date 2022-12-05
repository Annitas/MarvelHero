//
//  HeroSet.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 16.11.2022.
//

import RealmSwift
import Kingfisher

 @objcMembers
class HeroSet: Object {
    dynamic var heroes = List<HeroDBModel>()
}
