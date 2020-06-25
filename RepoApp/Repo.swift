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
    
//    init(dictionaryRepo: [String: Any]) {
//        name = dictionaryRepo["name"] as? String
//        fullName = dictionaryRepo["full_name"] as? String
//        description = dictionaryRepo["description"] as? String
//        language = dictionaryRepo["language"] as? String
//        stargazersCount = dictionaryRepo["stargazers_count"] as? Int
//        forksCount = dictionaryRepo["forks_count"] as? Int
//        owner = dictionaryRepo["owner"] as? Owner
//        license = dictionaryRepo["license"] as? String
//    }
    
//    static func getRepos(from value: Any) -> [Repo]? {
//        guard let value = value as? [[String: Any]] else { return nil }
//        return value.compactMap { Repo(dictionaryRepo: $0) }
//    }
}

struct Owner: Decodable {
    let login: String?
    let avatarUrl: String?
    let type: String?
    
//    init(dictionaryOwner: [String: Any]) {
//        login = dictionaryOwner["login"] as? String
//        avatarUrl = dictionaryOwner["avatarUrl"] as? String
//        type = dictionaryOwner["type"] as? String
//    }
    
}
