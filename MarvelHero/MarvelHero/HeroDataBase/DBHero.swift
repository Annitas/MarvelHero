//
//  DBHero.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 16.11.2022.
//

import UIKit
import RealmSwift

final class DBHero: Object {
    @Persisted var name: String = ""
    @Persisted var descriptionHero: String = ""
    @Persisted var pictureHero = Data()
    override var description: String {
        return "\nName: \(name)\nAge: \(descriptionHero)\nPicture url: \(pictureHero)"
    }
}
