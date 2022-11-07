//
//  Service.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 30.10.2022.
//

import Alamofire
import CryptoKit

final class Service {
    private let privateKey = "ed7b59c70915033e0e20f96eb71c36ae3e8ee521"
    private let publicKey = "4a1ae51af1869016810ae8f924e935a0"

    //MARK: get some data from marvel api
    func getSmthFromInternet() {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        let requestURL = "http://gateway.marvel.com:443/v1/public/characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        AF.request(requestURL, method: .get, parameters: nil, encoding: URLEncoding.default,
                   headers: nil, interceptor: nil).response { (responseData) in
            guard let data = responseData.data else { return }
            do {
                let heroes = try JSONDecoder().decode(Hero.self, from: data)
                print("heroes == \(heroes)")
            } catch {
                print("Error decoding == \(error)")
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

}
