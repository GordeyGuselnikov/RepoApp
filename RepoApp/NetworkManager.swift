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
        
        var repos: [Repo] = []
        
        guard let url = URL(string: urlString) else { return }

        AF.request(url)
            .validate()
            .responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    guard let value = value as? [[String: Any]] else { return }
            
                    for dictionaryRepo in value {
                        let repo = Repo(
                            name: dictionaryRepo["name"] as? String,
                            fullName: dictionaryRepo["full_name"] as? String,
                            description: dictionaryRepo["description"] as? String,
                            language: dictionaryRepo["language"] as? String,
                            stargazersCount: dictionaryRepo["stargazers_count"] as? Int,
                            forksCount: dictionaryRepo["forks_count"] as? Int,
                            owner: dictionaryRepo["owner"] as? Owner,
                            license: dictionaryRepo["license"] as? String
                        )
                        repos.append(repo)
                    }
                    
                    complition(repos)
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func fetchImage(repo: Repo, with complition: @escaping (UIImage) -> Void) {
        
        guard let imageURL = URL(string: repo.owner?.avatarUrl ?? "") else { return }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error { print(error); return }
            if let response = response { print(response) }
            
            if let data = data, let image = UIImage(data: data) {
                complition(image)
            }
        }.resume()
    }
}
