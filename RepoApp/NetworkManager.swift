//
//  NetworkManager.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 22.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    let urlString = "https://api.github.com/users/LexDeBash/repos"
//    let urlString = "https://api.github.com/users/GordeyGuselnikov/repos"
    
    private init() {}
    
//    func fetchDataURLSession(with complition: @escaping ([Repo]) -> Void) {
//
//        guard let url = URL(string: urlString) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            if let error = error { print(error); return }
//            guard let data = data else { return }
//
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//            do {
//                let repos = try decoder.decode([Repo].self, from: data)
//                complition(repos)
//            } catch let jsonError {
//                print(jsonError.localizedDescription)
//            }
//
//        }.resume()
//    }
    
    func fetchDataAlamofire(with complition: @escaping ([Repo]) -> Void) {
        
        guard let url = URL(string: urlString) else { return }

        AF.request(url)
            .validate()
            .responseJSON { (dataResponse) in
                
                switch dataResponse.result {
                case .success(let value):
                    guard let results = Repo.getRepos(from: value) else { return }
                    complition(results)
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func fetchImage(from url: String, with complition: @escaping (Data) -> Void) {
        
        AF.request(urlString)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let imageData):
                    complition(imageData)
                case .failure(let error):
                    print(error)
                }
        }
    }
}
