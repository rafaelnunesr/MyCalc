//
//  ViewController.swift
//  MyCalc
//
//  Created by Rafael Rios on 9/3/20.
//  Copyright © 2020 Rafael Rios. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var firstNumber: String?
    var secondNumber: String?
    var currentOperation: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        labelDisplay.text = "0"
    }
    
    // make statusbar color white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var labelDisplay: UILabel!
    
    // Numeric Buttons
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eigthButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    
    // DOT BUTTON & AC BUTTON
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var acButton: UIButton!
    
    // OPERATIONS
    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!

    
    @IBAction func numericBtnPressed(_ sender: UIButton) {
        if let btnValue = sender.currentTitle {
            concatNum(numberAsString: btnValue)
        }
    }
    
    private func handleLabelDisplay(message: String) {
        labelDisplay.text = message
    }
    
    private func checkIfLabelIsZero() -> Bool {
        if labelDisplay.text == "0" {
            return true
        }
        
        return false
    }
    
    private func checkFirstNumberOrSecondNumber() -> Int {
        if currentOperation == nil {
            return 1
        }
        
        return 2
    }
    
    private func concatNum(numberAsString num: String) {
        
        if num == "0" && checkIfLabelIsZero() {
           return
        }
        
        var display: String = ""
        
        let whichOperator = checkFirstNumberOrSecondNumber()
        
        if whichOperator == 1 {
            if let firstNumber = firstNumber {
                self.firstNumber = "\(firstNumber)\(num)"
            }else {
                firstNumber = num
            }
                
            display = firstNumber ?? ""
            
        }else if whichOperator == 2 {
            
            if let secondNumber = secondNumber {
                self.secondNumber = "\(secondNumber)\(num)"
            }else {
                secondNumber = num
            }
            
            display = labelDisplay.text ?? ""
            display = "\(display)\(num)"

        }
        
        handleLabelDisplay(message: display)
        
    }
    
    private func handleDotResult(result: String) -> String {
        
        let dotIndex = result.firstIndex(of: ".") ?? result.endIndex
        let afterDot = result[dotIndex...]
        let beforeDot = result[..<dotIndex]
        
        if afterDot.count <= 3 {
            if afterDot == ".00" || afterDot == ".0" {
                return String(beforeDot)
            }
            else {
                return result
            }
        }else {
            if afterDot.count >= 6 {
                let newAfterDot = String(afterDot.prefix(6))
                return "\(beforeDot)\(newAfterDot)"
            }
            
            return result
        }
        
    }
    
    
    private func doMath() {
        var operator1: Double = 0
        var operator2: Double = 0
        var total: Double = 0
        
        if let firstNumber = firstNumber {
            operator1 = Double(firstNumber)!
        }
        
        if let secondNumber = secondNumber {
            operator2 = Double(secondNumber)!
        }
        
        switch currentOperation {
        case "+":
            total = operator1 + operator2
        case "-":
            total = operator1 - operator2
        case "/":
            total = operator1 / operator2
        case "x":
            total = operator1 * operator2
        default:
            labelDisplay.text = "Error"
            return
        }
        
        handleLabelDisplay(message: handleDotResult(result: String(total)))
        
        firstNumber = nil
        secondNumber = nil
        currentOperation = nil
        
    }
    
    @IBAction func operationBtnPressed(_ sender: UIButton) {
        
        var display: String = labelDisplay.text ?? "0"
        
        if let btnValue = sender.currentTitle {
            if btnValue != "=" {
                if currentOperation == nil {
                    currentOperation = btnValue
                }
                
                currentOperation = btnValue
                
                display = "\(display) \(btnValue) "
                handleLabelDisplay(message: display)
                
            }else {
                doMath()
                currentOperation = nil
            }
        }
    }
    
    @IBAction func dotBtnPressed(_ sender: UIButton) {
        
        let whichOperator = checkFirstNumberOrSecondNumber()
        var display: String = ""
        
        if whichOperator == 1 {
            if let firstNumber = firstNumber {
                if !firstNumber.contains(".") {
                    self.firstNumber = "\(firstNumber)."
                }
            }else {
                firstNumber = "0."
            }
            
            display = firstNumber ?? ""
    
            
        }else if whichOperator == 2 {
            if let secondNumber = secondNumber {
                if !secondNumber.contains(".") {
                    self.secondNumber = "\(secondNumber)."
                }
            }else {
                secondNumber = "0."
            }
            
            display = labelDisplay.text ?? ""
            display = "\(display)\(secondNumber!)"
            
        }
        
        handleLabelDisplay(message: display)
    }
    
    @IBAction func acBtnPressed(_ sender: UIButton) {
        firstNumber = nil
        secondNumber = nil
        labelDisplay.text = "0"
    }
    
}

