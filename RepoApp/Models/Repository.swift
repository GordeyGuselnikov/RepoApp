//
//  Repo.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 22.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

struct Repository: Codable {
    let name: String?
    let fullName: String?
    let owner: Owner?
    let description: String?
    let language: String?
    let stargazersCount: Int?
    let forksCount: Int?
    let license: License?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case fullName = "full_name"
        case owner = "owner"
        case description = "description"
        case language = "language"
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
        case license = "license"
    }
}

struct Owner: Codable {
    let login, avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarUrl = "avatar_url"
    }
}

struct License: Codable {
    let name: String?
}
