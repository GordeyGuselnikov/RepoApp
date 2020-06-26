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
    
    private init() {}
    
    func getRepos(_ complition: @escaping ([Repo]) -> Void) {
        AF.request(URLConstants.reposLexDeBashAPI.rawValue)
            .validate()
            .responseJSON { (dataResponse) in
                switch dataResponse.result {
                case .success(let value):
//                    print(value)
                    guard let results = Repo.getRepo(from: value) else { return }
                    complition(results)
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!RESULTS: \(results)")
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func fetchImage(from imageUrl: String, with complition: @escaping (Data) -> Void) {
        
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
