//
//  LanguageCell.swift
//  GithubDemo
//
//  Created by Mary Martinez on 10/21/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

protocol LanguageSwitchDelegate {
    func languageSwitchDidToggle(cell: LanguageCell, newValue: Bool)
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
