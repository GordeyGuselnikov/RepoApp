//
//  RepoCell.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 22.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import UIKit

class RepoViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var starLabel: UILabel!
    @IBOutlet var forkLabel: UILabel!
    @IBOutlet var avatarImage: UIImageView! {
        didSet {
            avatarImage.contentMode = .scaleAspectFit
            avatarImage.clipsToBounds = true
            avatarImage.layer.cornerRadius = avatarImage.bounds.height / 2
            avatarImage.backgroundColor = .white
        }
    }
    
    func configure(with repo: Repo) {
        
        nameLabel.text = repo.name
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 2
        descriptionLabel.text = "Description: \(repo.description ?? "Unknown")"
        languageLabel.text = "Language: \(repo.language ?? "Unknown")"
        starLabel.text = "\(repo.stargazersCount ?? 0)"
        forkLabel.text = "\(repo.forksCount ?? 0)"
        if let imageURL = repo.owner?.avatarUrl {
            NetworkManager.shared.getAvatarImage(from: imageURL) { imageData in
                DispatchQueue.main.async {
                    self.avatarImage.image = UIImage(data: imageData)
                }
            }
        }
    }
}
