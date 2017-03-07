//
//  ViewController.swift
//  Calculator
//
//  Created by Jonatas Ramos Domingos on 01/05/16.
//  Copyright © 2016 Jonatas Ramos Domingos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet fileprivate weak var display: UILabel!
    
    fileprivate var userIsInTheMiddleOfTyping = false
    fileprivate var isDigitPoint = false
    
    @IBAction fileprivate func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            if(isDigitPoint && digit=="."){
                display.text = textCurrentlyInDisplay
                
            }else{
                display.text = textCurrentlyInDisplay + digit
            }
        }else{
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true
        if(digit == "."){
            isDigitPoint = true
        }
        
    }
    
    fileprivate var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    fileprivate var brain = CalculatorBrain()
    
    @IBAction fileprivate func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping{
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
            isDigitPoint = false
        }
        
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
}

