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
//    let urlString = "https://api.github.com/users/GordeyGuselnikov/repos"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 100
        
        NetworkManager.shared.fetchData() { (repos) in
            DispatchQueue.main.async { // выходим из фонового режима в основной // это можно реализовать в NetworkManager
                self.repos = repos // присвоение свойству класса RepoListTableViewController экземпляр который вернул коплишнХендлер
                self.tableView.reloadData() // нам надо перегрузить методы протоколов UITableViewDataSource // пока данные возвращаются из коплишнХендлер, методы numberOfRowsInSection уже работают, поэтому перегружаем
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            if segue.identifier == "showDetails" {
                let DetailsVC = segue.destination as! DetailViewController
    //            trackDetailsVC.track = trackList[indexPath.row]
                DetailsVC.repo = sender as? Repo
            }
        }

}
