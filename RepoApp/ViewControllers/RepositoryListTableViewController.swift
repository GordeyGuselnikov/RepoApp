//
//  RepoListTableViewController.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 22.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import UIKit

class RepositoryListTableViewController: UITableViewController {

    private var repositories: [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 120
        downloadData()
        setupRefreshControl()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepositoryTableViewCell
        
        let repository = repositories[indexPath.row]
        cell.configure(with: repository)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentRepository = repositories[indexPath.row]
        performSegue(withIdentifier: Segues.showDetail.rawValue, sender: currentRepository)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == Segues.showDetail.rawValue {
                let DetailVC = segue.destination as! DetailViewController
                DetailVC.repository = sender as? Repository
            }
        }
}

// MARK: - Private Methods
extension RepositoryListTableViewController {
    
    private func downloadData() {
        NetworkManager.shared.fetchRepositoriesFromNetwork { repositories in
            DispatchQueue.main.async {
                self.repositories = repositories
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(updateView), for: .valueChanged)
        tableView.addSubview(refreshControl ?? UIRefreshControl())
    }
    
    @objc private func updateView() {
        NetworkManager.shared.fetchRepositoriesFromNetwork { repositories in
            DispatchQueue.main.async {
                self.repositories = repositories
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
}
