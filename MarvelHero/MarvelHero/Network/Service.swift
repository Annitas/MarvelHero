//
//  Service.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 30.10.2022.
//

import Alamofire
import RealmSwift
import CryptoKit

final class Service {
    private let privateKey = "ed7b59c70915033e0e20f96eb71c36ae3e8ee521"
    private let publicKey = "4a1ae51af1869016810ae8f924e935a0"
    private let baseUrl = "https://gateway.marvel.com/v1/public/"
    private let dataBaseManager: DBManager = DBManagerImpl()
    private let heroesToSave = HeroSet()
    private var models = [HeroSet]()
    private let heroView: UIImageView = {
        let heroView = UIImageView()
        heroView.clipsToBounds = true
        return heroView
    }()
    static let sharedInstance = Service()
    func endpoint(path: String) -> String {
        return baseUrl + path
    }
    var heroArray = [Character]()
    // MARK: get some data from marvel api
    func getMarvelHeroes(handler: @escaping(_ apiData: [Character]) -> Void) {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        let url = "https://gateway.marvel.com/v1/public/characters?orderBy=name&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        AF.request(url, method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: nil,
                   interceptor: nil).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode(CharacterDataWrapper.self, from: data!)
                    let heroData = jsondata.data?.results
                    let countHeroes = heroData?.count ?? 0
                    for index in 0 ..< countHeroes {
                        self.heroArray.append(heroData![index])
                        var heroStr = "\(heroData![index].thumbnail?.path ?? "")/portrait_uncanny.\(heroData![index].thumbnail?.ext ?? "")"
                        heroStr.insert(contentsOf: "s", at: heroStr.index(heroStr.startIndex, offsetBy: 4))
                        let url = URL(string: heroStr)
                        let heroM = HeroDBModel()
                        heroM.name = heroData![index].name ?? ""
                        heroM.descriptionHero = heroData![index].description ?? ""
                        heroM.pictureHero = try! Data(contentsOf: url!)
                        self.heroesToSave.heroes.append(heroM)
                    }
                    if self.dataBaseManager.obtainHeroes().isEmpty {
                        self.dataBaseManager.saveHero(hero: self.heroesToSave)
                    }
//                    self.dataBaseManager.removeHeroes()
                    handler(self.heroArray)
                } catch {
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func MD5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        return hash.map {
            String(format: "%02hhx", $0)
        }
        .joined()
    }

    private func getParams() -> Params {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        return Params(apiKey: publicKey, hash: hash)
    }
}

struct Params: Encodable {
    let apiKey: String
    let hash: String
}
