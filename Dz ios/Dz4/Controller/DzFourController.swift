//
//  DzFourController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 05.Apr.22.
//

import UIKit

class DzFourController: UIViewController {

    @IBOutlet weak var catPlayButton: UIButton!
    @IBOutlet weak var squareButton: UIButton!
    @IBOutlet weak var circleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
        
    }
    
    
    func setupButton() {
        setGradient(view: catPlayButton, colorOne: "simpleRed", colorTwo: "peach")
        catPlayButton.layer.cornerRadius = catPlayButton.frame.size.width / 2
        catPlayButton.clipsToBounds = true
    }
    
}
