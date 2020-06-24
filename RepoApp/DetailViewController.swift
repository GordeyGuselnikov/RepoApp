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
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        loginLabel.text = repo.owner.login
        fetchImage()
    }
    
    private func fetchImage() {

        guard let imageURL = URL(string: repo.owner.avatar_url ?? "") else { return }
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            
            if let error = error { print(error); return }
            if let response = response { print(response) }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.avatarImageView.image = image
                }
            }
        }.resume()
    }
}

    //        DispatchQueue.global().async {
    //            guard let stringURL = course.imageUrl else { return } // извлекаем опционалы из модели
    //            guard let imageURL = URL(string: stringURL) else { return } // делаем URL
    //            guard let imageData = try? Data(contentsOf: imageURL) else { return } // пытаемся получить данные
    //            guard let stringAvatarURL =
    //            DispatchQueue.main.async {
    //                self.courseImage.image = UIImage(data: imageData)
    //            }
    //        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

