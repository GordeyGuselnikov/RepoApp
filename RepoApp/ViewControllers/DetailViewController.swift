//
//  DetailViewController.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 24.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var repository: Repository!
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var licenseLabel: UILabel!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        setValues(for: repository)
    }
    
    private func setValues(for repository: Repository) {

        loginLabel.text = "Login: " + (repository.owner?.login ?? "")
        licenseLabel.text = "License: " + (repository.license?.name ?? "Null")
        
        if let imageURL = repository.owner?.avatarUrl {
            NetworkManager.shared.getAvatarImage(from: imageURL) { imageData in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.avatarImageView.image = UIImage(data: imageData)
                }
            }
        }
    }
}
