//
//  Constants.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 26.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import Foundation

enum URLConstants: String {
    case reposLexDeBashAPI = "https://api.github.com/users/LexDeBash/repos"
    case reposMyAPI = "https://api.github.com/users/GordeyGuselnikov/repos"
    case reposCnoonAPI = "https://api.github.com/users/cnoon/repos"
    case reposAFNetworkingAPI = "https://api.github.com/users/AFNetworking/repos"
    case reposGoogle = "https://api.github.com/users/google/repos"
}

enum Segues: String {
    case showDetail = "showDetails"
}
