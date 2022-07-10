//
//  SquareController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 05.Apr.22.
//

import UIKit

class SquareController: UIViewController {
    
    let count: Int = 5
    var squares: [RandomView] = []
    var colors: [String] = ["beer", "colorDark", "colorLight", "peach", "simpleRed", "windowsEght"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addSquarePressed(_ sender: UIButton) {
        for _ in 1 ... 10000 {
            setup()
        }
        
        sender.isHidden = true
    }
    
    private func nextFrame() -> CGRect {
        let squreSize = CGFloat(20 + arc4random_uniform(30))
        let x = CGFloat(arc4random_uniform(UInt32(self.view.frame.size.width - squreSize)))
        let y = CGFloat(arc4random_uniform(UInt32(self.view.frame.size.height - squreSize)))
        
        return CGRect(x: x, y: y, width: squreSize, height: squreSize)
    }
    
    private func setup() {
        let frame = nextFrame()
        
        let randomView = RandomView(frame: frame)
        randomView.backgroundColor = UIColor(named: colors.randomElement()!)

        
        var shouldCreateView = true

            
        for square in squares {
            if frame.intersects(square.frame) {
                shouldCreateView = false
                break
            }
        }
        if shouldCreateView {
            view.addSubview(randomView)
            squares.append(randomView)
        }
        
        
    }
    
}

