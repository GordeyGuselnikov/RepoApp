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

struct Repo: Decodable {
    let name: String?
    let fullName: String?
    let description: String?
    let language: String?
    let stargazersCount: Int?
    let forksCount: Int?
    let owner: Owner?
    let license: String?
    
    init(value: [String: Any]) {
        name = value["name"] as? String
        fullName = value["full_name"] as? String
        description = value["description"] as? String
        language = value["language"] as? String
        stargazersCount = value["stargazers_count"] as? Int
        forksCount = value["forks_count"] as? Int
        
        let ownerDictionary = value["owner"] as? [String: String] ?? [:]
        owner = Owner(value: ownerDictionary)
        
        license = value["license"] as? String
    }
    
    static func getRepos(from value: Any) -> [Repo]? {
        guard let value = value as? [[String: Any]] else { return [] }
        return value.compactMap { Repo(value: $0) }
    }
}

struct Owner: Decodable {
    let login: String?
    let avatarUrl: String?
    let type: String?
    
    init(value: [String: String]) {
        login = value["login"]
        avatarUrl = value["avatarUrl"]
        type = value["type"]
    }
    
}
