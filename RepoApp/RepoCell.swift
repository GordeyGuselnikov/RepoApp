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
                
//        DispatchQueue.global().async {
//            guard let stringURL = course.imageUrl else { return } // извлекаем опционалы из модели
//            guard let imageURL = URL(string: stringURL) else { return } // делаем URL
//            guard let imageData = try? Data(contentsOf: imageURL) else { return } // пытаемся получить данные
//            guard let stringAvatarURL =
//            DispatchQueue.main.async {
//                self.courseImage.image = UIImage(data: imageData)
//            }
//        }
    }
}
