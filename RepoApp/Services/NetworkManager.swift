//
//  NetworkManager.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 22.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchRepositoriesFromNetwork(_ complition: @escaping ([Repository]) -> Void) {
        AF.request(URLConstants.reposLexDeBashAPI.rawValue)
            .validate()
            .responseDecodable(of: [Repository].self) { response in
                switch response.result {
                case .success(let repositories):
                    complition(repositories)
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func getImageWithAlamofire(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                guard let responseURL = dataResponse.response?.url else { return }
                guard responseURL == url else { return }
                switch dataResponse.result {
                case .success(let imageData):
                    completion(imageData, dataResponse.response!)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
