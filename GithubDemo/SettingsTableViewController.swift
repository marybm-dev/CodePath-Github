//
//  SettingsTableViewController.swift
//  GithubDemo
//
//  Created by Mary Martinez on 10/20/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

protocol StarSliderDelegate {
    func updateSettings(didChangeSlider value: Int)
}

protocol LanguageSwitchDelegate {
    func languageSwitchDidToggle(cell: LanguageCell, newValue: Bool)
}

class StarSliderCell: UITableViewCell {
    @IBOutlet weak var minStarsSlider: UISlider!
    @IBOutlet weak var minStarsLabel: UILabel!
    
    var delegate: StarSliderDelegate?
    
    @IBAction func didChangeValue(_ sender: AnyObject) {
        delegate?.updateSettings(didChangeSlider: Int(minStarsSlider.value))
        minStarsLabel.text = "min: \(Int(minStarsSlider.value))"
    }
    
}

class LanguageCell: UITableViewCell {
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var onOffSwitch: UISwitch!
    
    var delegate: LanguageSwitchDelegate?
    
    var languageRowIdentifier: String! {
        didSet {
            languageLabel?.text = languageRowIdentifier
        }
    }
    
    @IBAction func didToggleSwitch(sender: AnyObject) {
        delegate?.languageSwitchDidToggle(cell: self, newValue: onOffSwitch.isOn)
    }
}

class SettingsTableViewController: UITableViewController, StarSliderDelegate, LanguageSwitchDelegate {
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        delegate?.updateSettings(didChangeSlider: self.minStars)
        self.dismiss(animated: true, completion: nil)
    }
    
    var searchSettings = GithubRepoSearchSettings()
    var minStars = Int()
    var delegate: StarSliderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func updateSettings(didChangeSlider value: Int) {
        self.minStars = value
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
