//
//  RepoListTableViewController.swift
//  RepoApp
//
//  Created by Гордей Гусельников on 22.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import UIKit

final class RepositoryListTableViewController: UITableViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var repositories: [Repository] = []
    private var filteredRepositories: [Repository] = []
    private var searchBarIsEmpty: Bool { // возвращает true если строка поиска пустая
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 120
        downloadData()
        setupRefreshControl()
        setupSearchController()
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredRepositories.count : repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepositoryTableViewCell
        
        let repository = isFiltering ? filteredRepositories[indexPath.row] : repositories[indexPath.row]
        cell.configure(with: repository)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentRepository = isFiltering ? filteredRepositories[indexPath.row] : repositories[indexPath.row]
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
extension RepositoryListTableViewController: UISearchResultsUpdating {
    
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
        refreshControl?.attributedTitle = NSAttributedString(
            string: "Updating...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        refreshControl?.tintColor = .darkGray
        refreshControl?.addTarget(
            self,
            action: #selector(updateView),
            for: .valueChanged
        )
        tableView.addSubview(refreshControl ?? UIRefreshControl())
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .white
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
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
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredRepositories = repositories.filter({ (repository: Repository) -> Bool in
            return repository.name?.lowercased().contains(searchText.lowercased()) ?? false
        })
        
        tableView.reloadData()
    }
}
