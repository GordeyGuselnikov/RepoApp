//
//  DetailViewController.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 24.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var result: Repo!
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var licenseLabel: UILabel!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        setValues(with: result)
    }
    
    private func setValues(with result: Repo) {
        
        if let imageURL = result.owner?.avatarUrl {
            NetworkManager.shared.getAvatarImage(from: imageURL) { imageData in
                self.activityIndicator.stopAnimating()
                self.avatarImageView.image = UIImage(data: imageData)
            }
        }
        
        loginLabel.text = "Login: " + (result.owner?.login ?? "")
        licenseLabel.text = "License: " + (result.license ?? "Null")
    }
}
