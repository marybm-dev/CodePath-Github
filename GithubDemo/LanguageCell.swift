//
//  LanguageCell.swift
//  GithubDemo
//
//  Created by Mary Martinez on 10/21/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

protocol LanguageSwitchDelegate {
    func languageSwitchDidToggle(newValue: Bool)
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
        NSLog("switch.isOn: \(onOffSwitch.isOn)")
        
        onOffSwitch.setOn(onOffSwitch.isOn, animated: true)
        
        delegate?.languageSwitchDidToggle(newValue: onOffSwitch.isOn)
    }
}
