//
//  NetworkManager.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 22.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    let urlString = "https://api.github.com/users/LexDeBash/repos"
    
    private init() {}
    
    func fetchData(with complition: @escaping ([Repo]) -> Void) {
        
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }

            do {
                let repos = try JSONDecoder().decode([Repo].self, from: data)
                complition(repos)
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
            
        }.resume()
    }
    
    func fetchImage(repo: Repo, with complition: @escaping (UIImage) -> Void) {
        
        guard let imageURL = URL(string: repo.owner.avatar_url ?? "") else { return }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error { print(error); return }
            if let response = response { print(response) }
            
            if let data = data, let image = UIImage(data: data) {
                complition(image)
            }
        }.resume()
    }
}
