//
//  SettingsTableViewController.swift
//  GithubDemo
//
//  Created by Mary Martinez on 10/20/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    
    @IBAction func didTouchCancelButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
