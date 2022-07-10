//
//  DzTwoController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 29.Mar.22.
//

import UIKit

class DzTwoController: UIViewController {
    
    private let x = [(2, "g"), (9, "h"), (4, "a"), (7, "e"), (1, "c"), (6, "s")]

    @IBOutlet weak var initialLabel: UILabel!
    @IBOutlet weak var result: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in x {
            initialLabel.text = initialLabel.text! + "\(i)"
        }
        
        
    }
    
    @IBAction func square(_ sender: Any) {
        result.text = ""
        var number = (0,"")
        var y : [(Int, String)] = []
        for i in x {
            number = i
            number.0 *= number.0
            y.append(number)
            
        }
        result.text = result.text! + "\(y)"
    }
    
    @IBAction func even(_ sender: Any) {
        result.text = ""
        for i in x {
            if i.0 % 2 == 0 {
                result.text = result.text! + "\(i)"
            }
        }
    }
    @IBAction func streamLine(_ sender: Any) {
        result.text = ""
        var y = x
        y.sort{
            $0.1 < $1.1
        }
        for i in y {
            result.text = result.text! + "\(i)"
        }
    }
}
