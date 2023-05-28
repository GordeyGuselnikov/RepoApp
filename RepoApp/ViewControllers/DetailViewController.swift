//
//  DetailViewController.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 24.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    var repository: Repository!
    
    @IBOutlet var avatarImageView: ImageView!
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
        
        loginLabel.text = "Name: " + (repository.name ?? "")
        licenseLabel.text = "License: " + (repository.license?.name ?? "Null")
        
        if let imageURL = repository.owner?.avatarUrl {
            activityIndicator.stopAnimating()
            avatarImageView.fetchImage(from: imageURL)
        }
        
    }
}
