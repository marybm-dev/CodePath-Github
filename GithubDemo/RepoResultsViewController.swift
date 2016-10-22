//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD
import AFNetworking

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StarSliderDelegate {

    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos = [GithubRepo]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
    }

    func updateSettings(didChangeSlider value: Int) {
        searchSettings.minStars = value
        self.repos.removeAll()
        self.doSearch()
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            for repo in newRepos {
                self.repos.append(repo)
                print(repo)
            }
            
            self.tableView.reloadData()
            
            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.repoViewCell", for: indexPath) as! RepoTableViewCell
        let repo = repos[indexPath.row]
        
        cell.repoImageView.setImageWith(URL(string: repo.ownerAvatarURL!)!)
        cell.repoLabel.text = repo.name!
        cell.nameLabel.text = "by \(repo.ownerHandle!)"
        cell.starCountLabel.text = "\(repo.stars!)"
        cell.forkCountLabel.text = "\(repo.forks!)"
        cell.descriptionLabel.text = "\(repo.repoDescription!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSettingsViewController" {
            
            let navViewController = segue.destination as! UINavigationController
            let settingsViewController = navViewController.topViewController as! SettingsTableViewController
            settingsViewController.minStars = searchSettings.minStars
            settingsViewController.sliderDelegate = self
        }
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
