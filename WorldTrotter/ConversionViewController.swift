//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by James Honeyball on 15/01/2017.
//  Copyright © 2017 James Honeyball. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class conversionViewController: UIViewController {
    
    @IBOutlet var celciusLabel: UILabel!
    @IBOutlet var textField: UITextField!

    override func viewDidLoad() {
    super.viewDidLoad()
        updateCelciusValue()
    }
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelciusValue()
        }
    }
    var celciusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    func updateCelciusValue() {
        if let celciusValue = celciusValue {
            celciusLabel.text = "\(celciusValue.value)"
        } else {
            celciusLabel.text = "???"
        }
    }
    
}

