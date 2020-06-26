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
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 2
        descriptionLabel.text = "\(repo.description ?? "Unknown")"
        languageLabel.text = "Language: " + (repo.language ?? "Unknown")
        starLabel.text = "\(repo.stargazersCount ?? 0)"
        forkLabel.text = "\(repo.forksCount ?? 0)"
    }
}
