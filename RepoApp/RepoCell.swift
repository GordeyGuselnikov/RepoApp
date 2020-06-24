//
//  RepoCell.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 22.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var starLabel: UILabel!
    @IBOutlet var forkLabel: UILabel!
   
    func configure(with repo: Repo) {
        
        nameLabel.text = repo.name
        descriptionLabel.text = "Description: " + (repo.description ?? "Unknown")
        languageLabel.text = "Language: " + (repo.language ?? "Unknown")
        starLabel.text = "Stars: \(repo.stargazers_count ?? 0)"
        forkLabel.text = "Forks: \(repo.forks_count ?? 0)"
    }
}
