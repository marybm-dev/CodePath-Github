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

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var minStarsSlider: UISlider!
    @IBOutlet weak var minStarsLabel: UILabel!
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        delegate?.updateSettings(didChangeSlider: Int(minStarsSlider.value))
        self.dismiss(animated: true, completion: nil)
    }
    
    var minStars = Int()
    var delegate: StarSliderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        minStarsSlider.value = Float(minStars)
        minStarsLabel.text = "min: \(Int(minStarsSlider.value))"
        
        minStarsSlider.addTarget(self, action: #selector(selectorAction(slider:)), for: UIControlEvents.valueChanged)
    }

    func selectorAction(slider: UISlider) {
        NSLog("slider changed: \(slider.value)")
        minStarsLabel.text = "min: \(Int(slider.value))"
    }
}
