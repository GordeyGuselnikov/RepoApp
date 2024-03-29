//
//  RepoCell.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 22.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import UIKit

final class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var starLabel: UILabel!
    @IBOutlet var forkLabel: UILabel!
    @IBOutlet var avatarImage: ImageView! {
        didSet {
            avatarImage.contentMode = .scaleAspectFit
            avatarImage.clipsToBounds = true
            avatarImage.layer.cornerRadius = avatarImage.bounds.height / 2
            avatarImage.backgroundColor = .white
        }
    }
    
    func configure(with repository: Repository) {
        
        nameLabel.text = repository.name
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 2
        descriptionLabel.text = "Description: \(repository.description ?? "Unknown")"
        languageLabel.text = "Language: \(repository.language ?? "Unknown")"
        starLabel.text = "\(repository.stargazersCount ?? 0)"
        forkLabel.text = "\(repository.forksCount ?? 0)"

        if let imageURL = repository.owner?.avatarUrl {
            avatarImage.fetchImage(from: imageURL)
        }
    }
}
