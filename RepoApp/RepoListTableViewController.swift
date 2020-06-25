//
//  RepoListTableViewController.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 22.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import UIKit

class RepoListTableViewController: UITableViewController {

    private var repos: [Repo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 100
        
        NetworkManager.shared.fetchDataAlamofire() { (repos) in
            DispatchQueue.main.async {
                self.repos = repos
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepoCell
        
        let repo = repos[indexPath.row]
        cell.configure(with: repo)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let repo = repos[indexPath.row]
        print(repo)
        performSegue(withIdentifier: "showDetails", sender: repo)
    }

    // MARK: - Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showDetails" {
                let DetailsVC = segue.destination as! DetailViewController
                DetailsVC.repo = sender as? Repo
            }
        }
}
