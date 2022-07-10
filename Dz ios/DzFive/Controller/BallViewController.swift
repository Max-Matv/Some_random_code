//
//  BallViewController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 20.Apr.22.
//

import UIKit

class BallViewController: UIViewController {

    @IBOutlet weak var ballView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBall()
        gesturePan()
    }
    private func gesturePan() {
        let panGestureRecognizer = UIPanGestureRecognizer()
        panGestureRecognizer.addTarget(self, action: #selector(dragBall))
        ballView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc
    private func dragBall(_ sender: UIPanGestureRecognizer) {
        if sender.state == .changed {
            let translation = sender.translation(in: self.view)
            let newX = ballView.center.x + translation.x
            let newY = ballView.center.y + translation.y
            ballView.center = CGPoint(x: newX, y: newY)
            sender.setTranslation(CGPoint.zero, in: self.view)
        }
    }
    
    private func setupBall() {
        ballView.layer.cornerRadius = ballView.frame.size.width / 2
        ballView.clipsToBounds = true
    }


}
