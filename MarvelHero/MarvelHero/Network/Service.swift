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

    
    private let baseUrl = "https://gateway.marvel.com/v1/public/"
    
    func endpoint(path: String) -> String {
        return baseUrl + path
    }
    //MARK: get some data from marvel api
//    func getSmthFromInternet() {
//
//        AF.request(
//            endpoint(path: "characters"),
//            method: .get,
//            parameters: getParams(),
//            encoder: URLEncodedFormParameterEncoder(destination: .queryString)
//        ).response { (responseData) in
//            guard let data = responseData.data else { return }
//            do {
//                let heroes = try JSONDecoder().decode(CharacterDataWrapper.self, from: data)
//                print("heroes == \(heroes)")
//            } catch {
//                print("Error decoding == \(error)")
////            }
//        }
//    }
    
    func getSmthFromInternet() {
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
                    print(jsondata)
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
