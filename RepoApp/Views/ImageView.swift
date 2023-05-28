//
//  ImageView.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 08.07.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import UIKit

final class ImageView: UIImageView {
    
    func fetchImage(from url: String) {
        guard let url = URL(string: url) else {
            image = #imageLiteral(resourceName: "picture")
            return
        }
        
        if let cachedImage = getCachedImage(url: url) {
            image = cachedImage
            return
        }
        
        NetworkManager.shared.getImageWithAlamofire(from: url) { (data, response) in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            self.saveDataToCach(with: data, and: response)
        }
    }
    
    private func getCachedImage(url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url) // ответ от сервера с этим url
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    
    private func saveDataToCach(with data: Data, and response: URLResponse) {
        guard let urlResponse = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        let urlRequest = URLRequest(url: urlResponse)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
}
