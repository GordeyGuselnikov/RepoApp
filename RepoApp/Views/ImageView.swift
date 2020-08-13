//
//  ImageView.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 08.07.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import UIKit

class ImageView: UIImageView {
    
    // публичный метод для загрузки image // у нас будет аутлет с типом ImageView и у него мы будем ввызвать метод fetchImage
    func fetchImage(from url: String) { // будем брать url из модели с типом String
        guard let url = URL(string: url) else { // делаем URL из url String
            image = #imageLiteral(resourceName: "picture") // если что не так, то вставляем свою картинку // например битый URL // картинка в assets // image = imageLiteral-> чтобы выбрать картинку из проекта
            return
        }
        
        // Если изображение есть в кеше, то используем его
        // url выступает как идентификатор
        if let cachedImage = getCachedImage(url: url) {
            image = cachedImage
            return // если нашли изображение в кеше то сразу выходим из метода
        }
        
        // Если изображения в кеше нет, то грузим его из сети
//        ImageManager.shared.getImage(from: url) { (data, response) in
//            DispatchQueue.main.async { // выходим в сновной поток, т.к. сами данные у нас грузятся в фоне
//                self.image = UIImage(data: data) // на основе data инициализируем картинку
//            }
//            // Сохраняем изображение в кеш вместе с ответом от сервера
//            self.saveDataToCach(with: data, and: response)
//        }
        NetworkManager.shared.getImageWithAlamofire(from: url) { (data, response) in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            self.saveDataToCach(with: data, and: response)
        }
        
    }
    
    // приватный метод для выбора/поиска изображения в кеше с определенным URL адресом
    private func getCachedImage(url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url) // ответ от сервера с этим url
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) { // запрос к кешу по ответу urlRequest // если получится получить данные в кеше, то может инициализировать изображение по data которая в cachedResponse
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    //сохранение Данных и URLResponse в кеш, передаем Data и URLResponse
    private func saveDataToCach(with data: Data, and response: URLResponse) {
        guard let urlResponse = response.url else { return } // взяли url из ответа
        let cachedResponse = CachedURLResponse(response: response, data: data) // объединили ответ с данными
        let urlRequest = URLRequest(url: urlResponse) // создали реквест по url
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest) // сохранили в кеш ответ с реквестом
    }
}

