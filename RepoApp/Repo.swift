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
    let owner: Owner
    let license: String?
}

struct Owner: Decodable {
    let login: String?
    let avatarUrl: String?
    let type: String?
}
