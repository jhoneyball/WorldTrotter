//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by James Honeyball on 15/01/2017.
//  Copyright © 2017 James Honeyball. All rights reserved.
//

import UIKit

class conversionViewController: UIViewController {
    
    @IBOutlet var celciusLabel: UILabel!
    @IBOutlet var textField: UITextField!

    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    } ()
    
    override func viewDidLoad() {
    super.viewDidLoad()
        updateCelciusValue()
    }
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelciusValue()
        }
    }
    var celciusValue: Double? {
        if let fahrenheitValue = fahrenheitValue {
            return (fahrenheitValue - 32) * (5/9)
        } else {
            return nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = value
        } else {
            fahrenheitValue = nil
        }
    }
    
    func updateCelciusValue() {
        if let celciusValue = celciusValue {
            celciusLabel.text = numberFormatter.string(from: NSNumber(value: celciusValue))
        } else {
            celciusLabel.text = "???"
        }
    }
    
}

