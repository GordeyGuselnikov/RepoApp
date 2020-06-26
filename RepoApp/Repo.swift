//
//  Repo.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 22.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

// https://api.github.com/users/GordeyGuselnikov/repos
//В ячейке списка с информацией о репозитории должны быть следующие данные:
//- название репозитория;
//- краткое описание;
//- язык программирования;
//- количество звезд;
//- количество форков.
//
//В деталях страницы надо реализовать:
//- имя владельца и его аватар;
//- информация о лицензии.

struct Repo: Codable {
    var name: String?
    var fullName: String?
    var owner: Owner?
    var description: String?
    var language: String?
    var stargazersCount: Int?
    var forksCount: Int?
    
    var license: String?
    
    init(value: [String: Any]) {
        name = value["name"] as? String
        
        fullName = value["full_name"] as? String
        
        let ownerDictionary = value["owner"] as? [String: Any] ?? [:]
        owner = Owner(value: ownerDictionary)
        
        description = value["description"] as? String
        
        language = value["language"] as? String
        
        stargazersCount = value["stargazers_count"] as? Int
        
        forksCount = value["forks_count"] as? Int
        
        license = value["license"] as? String
    }
    
    init(login: String, avatarUrl: String) {
        let owner = Owner(login: login, avatarUrl: avatarUrl)
        self.owner = owner
    }
    
    static func getRepo(from value: Any) -> [Repo]? {
        guard let value = value as? [[String: Any]] else { return [] }
        print("!!!!!!!!VALUE: \(value)")
        let tempValue = value.compactMap { Repo(value: $0) }
        print("!!!!!!!!tempValue: \(value)")
        return tempValue
    }
}

struct Owner: Codable {
    var login, avatarUrl: String?
    
    init(value: [String: Any]) {
        login = value["login"] as? String
        avatarUrl = value["avatar_url"] as? String
    }
    
    init(login: String, avatarUrl: String) {
        self.login = login
        self.avatarUrl = avatarUrl
    }
}
