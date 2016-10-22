//
//  StarSliderCell.swift
//  GithubDemo
//
//  Created by Mary Martinez on 10/21/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

protocol StarSliderDelegate {
    func updateSettings(newValue: Int)
}

class StarSliderCell: UITableViewCell {
    
    @IBOutlet weak var minStarsSlider: UISlider!
    @IBOutlet weak var minStarsLabel: UILabel!
    
    var delegate: StarSliderDelegate?
    
    @IBAction func didChangeValue(_ sender: AnyObject) {
        delegate?.updateSettings(newValue: Int(minStarsSlider.value))
        minStarsLabel.text = "min: \(Int(minStarsSlider.value))"
    }
    
}
