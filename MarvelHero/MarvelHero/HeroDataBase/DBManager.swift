//
//  DBManager.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 20.11.2022.
//

import RealmSwift

protocol DBManager {
    func saveHero(hero: HeroSet)
    func obtainHeroes() -> [HeroSet]
    func removeHeroes()
}

class DBManagerImpl: DBManager {
    fileprivate lazy var realm = {
        let config = Realm.Configuration(
        schemaVersion: 2,
        migrationBlock: { migration, oldSchemaVersion in
            if oldSchemaVersion < 2 {
            }
        }
        )
        Realm.Configuration.defaultConfiguration = config
        return try! Realm()
    }()
    func saveHero(hero: HeroSet) {
        try! realm.write {
            realm.add(hero)
        }
    }
    func removeHeroes() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    func obtainHeroes() -> [HeroSet] {
        let models = realm.objects(HeroSet.self)
        return Array(models)
    }
}
