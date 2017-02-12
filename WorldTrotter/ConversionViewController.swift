//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by James Honeyball on 15/01/2017.
//  Copyright © 2017 James Honeyball. All rights reserved.
//

import UIKit

class conversionViewController: UIViewController,  UITextFieldDelegate{
    
    @IBOutlet var celciusLabel: UILabel!
    @IBOutlet var textField: UITextField!

    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    } ()

    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = randomSolidColour()
    }
    
    private func randomSolidColour() -> UIColor {
        let maxResultOfarc4Random = CGFloat (UINT32_MAX)
        
        func randomCGFloat() -> CGFloat {return CGFloat(arc4random())/maxResultOfarc4Random }
        
        let colour = UIColor (red: randomCGFloat(),
                              green: randomCGFloat(),
                              blue: randomCGFloat(),
                              alpha: 1.0)
        return colour
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("ConversionViewController loaded it's view.")
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
        
        if let text = textField.text, let number = numberFormatter.number(from: text)?.doubleValue {
            fahrenheitValue = number
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

    func textField(_ textField: UITextField,
                      shouldChangeCharactersIn range: NSRange,
                      replacementString string: String) -> Bool {

        
        let currentLocale = Locale.current
        let decimalSeperator = currentLocale.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeperator = textField.text?.range(of:  decimalSeperator)
        let replacementTextHasDecimalSeperator = string.range(of:  decimalSeperator)

        let setOfLetterCharacters = NSCharacterSet.letters
        let replacementTextHasCharacters = string.rangeOfCharacter(from: setOfLetterCharacters)
        

        if (replacementTextHasCharacters != nil) ||
            (existingTextHasDecimalSeperator != nil && replacementTextHasDecimalSeperator != nil) {
            return false
        } else {
            return true
        }
    }
}

