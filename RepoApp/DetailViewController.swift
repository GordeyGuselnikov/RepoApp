//
//  DetailViewController.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 24.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var repo: Repo!
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var licenseLabel: UILabel!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        loginLabel.text = "Login: " + (repo.owner.login ?? "")
        licenseLabel.text = "License: " + (repo.license ?? "Null")
        
        
        DispatchQueue.global().async {
            NetworkManager.shared.fetchImage(repo: self.repo) { (image) in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.avatarImageView.image = image
                }
            }
        }
    }
}
