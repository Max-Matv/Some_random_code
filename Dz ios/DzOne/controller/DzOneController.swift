//
//  DzOneController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 22.Mar.22.
//

import UIKit

class DzOneController: UIViewController {

    
    @IBOutlet weak var resultLabel: UILabel!
    private var firstTyping = false
    private var firstOperand: Double = 0
    private var secondOperand: Double = 0
    private var singn: Int = 4
    private var dot = false
    var currentInput: Double {
        get {
            return Double(resultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                resultLabel.text = "\(valueArray[0])"
            } else {
                resultLabel.text = "\(newValue)"
            }
            
            firstTyping = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupSwipeDelete()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        
        let number = sender.tag
        if firstTyping {
            resultLabel.text = resultLabel.text! + String(number)
        } else {
            resultLabel.text = String(number)
            firstTyping = true
        }
        
    }
    @IBAction func percentPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
        firstTyping = false
    }
    @IBAction func operandButton(_ sender: UIButton) {
        singn = sender.tag
        firstOperand = currentInput
        firstTyping = false
        dot = false
    }
   
    @IBAction func clearButton(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        resultLabel.text = "0"
        firstTyping = false
        dot = false
        singn = 4
    }
    @IBAction func plusMinusButton(_ sender: UIButton) {
        currentInput = -currentInput
    }
    @IBAction func dotButton(_ sender: Any) {
        if firstTyping && !dot {
            resultLabel.text = resultLabel.text! + "."
            dot = true
        } else if !firstTyping && !dot {
            resultLabel.text = "0."
        }
    }
    @IBAction func equalButton(_ sender: UIButton) {
        
        if firstTyping {
            secondOperand = currentInput
        }
        dot = false
        
        switch singn {
        case 0:
            operate{$0 + $1}
        case 1:
            operate{$0 - $1}
        case 3:
            operate{$0 / $1}
        case 2:
            operate{$0 * $1}
        default: break
    }
    func operate(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
    }
        
}
 
    func sumNumber(number: Int) -> Int {
        (number % 10) + (number / 10) % 10 + (number / 100)
    }
    
    private func SetupSwipeDelete() {
        let leftSwipe = UISwipeGestureRecognizer()
        leftSwipe.addTarget(self, action: #selector(handleSwipe))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
    }
    
    @objc
    private func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
            if resultLabel.text?.count != 1 {
                resultLabel.text? = String(resultLabel.text!.dropLast())
            } else {
                firstOperand = 0
                secondOperand = 0
                currentInput = 0
                resultLabel.text = "0"
                firstTyping = false
                dot = false
                singn = 4
            }
        default : return
        }
    }
}
