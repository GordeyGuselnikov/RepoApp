//
//  NetworkManager.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 22.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchRepositoriesFromNetwork(_ complition: @escaping ([Repository]) -> Void) {
        
        AF.request(URLConstants.reposAFNetworkingAPI.rawValue)
            .validate()
            .responseJSON { (dataResponse) in
                
                switch dataResponse.result {
                case .success(let value):
                    guard let repositories = Repository.getRepository(from: value) else { return }
                    complition(repositories)
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func getAvatarImage(from imageUrl: String, with complition: @escaping (Data) -> Void) {
        
        AF.request(imageUrl)
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
