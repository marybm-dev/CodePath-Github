//
//  SettingsTableViewController.swift
//  GithubDemo
//
//  Created by Mary Martinez on 10/20/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, StarSliderDelegate, LanguageSwitchDelegate {
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        sliderDelegate?.updateSettings(newValue: self.minStars)
        self.dismiss(animated: true, completion: nil)
    }
    
    var searchSettings = GithubRepoSearchSettings()
    var minStars = Int()
    var sliderDelegate: StarSliderDelegate?
    var languageDelegate: LanguageSwitchDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func updateSettings(newValue: Int) {
        self.minStars = newValue
    }

    func languageSwitchDidToggle(cell: LanguageCell, newValue: Bool) {
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell") as! LanguageCell
        if !cell.onOffSwitch.isOn {
            return searchSettings.languages.count
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "starSliderCell", for: indexPath) as! StarSliderCell
            cell.minStarsLabel.text = "min: \(searchSettings.minStars)"
            cell.minStarsSlider.value = Float(searchSettings.minStars)
            cell.delegate = self
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath) as! LanguageCell
            cell.languageLabel?.text = "Languages"
            cell.onOffSwitch?.isOn = false
            cell.delegate = self
            return cell
        }    
    }
}
