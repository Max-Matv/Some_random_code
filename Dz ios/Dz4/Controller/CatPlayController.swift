//
//  CatPlayController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 05.Apr.22.
//

import UIKit

class CatPlayController: UIViewController {

    @IBOutlet weak var playButtond: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setupButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupButton()
    }
    @IBAction func playPressed(_ sender: UIButton) {
        sender.frame.origin.x = CGFloat(CGFloat.random(in: view.frame.minX ... view.frame.maxX - 100))
        sender.frame.origin.y = CGFloat(CGFloat.random(in: view.frame.minY + 40 ... view.frame.maxY - 100))
        
    }
    
   func setupButton() {
        setGradient(view: playButtond, colorOne: "simpleRed", colorTwo: "peach")
        playButtond.layer.cornerRadius = playButtond.frame.size.width / 2
        playButtond.clipsToBounds = true
    }
   
    
}
