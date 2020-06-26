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
        downloadData()
        setupRefreshControl()
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
        let currentRepo = repos[indexPath.row]
        performSegue(withIdentifier: Segues.showDetail.rawValue, sender: currentRepo)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == Segues.showDetail.rawValue {
                let DetailVC = segue.destination as! DetailViewController
                DetailVC.result = sender as? Repo
            }
        }
}

extension RepoListTableViewController {
    private func downloadData() {
        NetworkManager.shared.getRepos { results in
            self.repos = results
//            print(self.repos)
            self.tableView.reloadData()
        }
    }
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(updateView), for: .valueChanged)
        tableView.addSubview(refreshControl ?? UIRefreshControl())
    }
    
    @objc private func updateView() {
        NetworkManager.shared.getRepos { results in
            self.repos = results
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
}
