//
//  CircleController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 06.Apr.22.
//

import UIKit

class CircleController: UIViewController {

    @IBOutlet weak var circle: UIView!
    @IBOutlet weak var up: UIButton!
    @IBOutlet weak var right: UIButton!
    @IBOutlet weak var down: UIButton!
    @IBOutlet weak var left: UIButton!
    @IBOutlet weak var infoLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCicle()
        setupSwipeDirection()
      
    }
    @IBAction func upPressed(_ sender: UIButton) {
        
        if circle.frame.origin.y - view.bounds.minY > view.bounds.minY  {
            setupDirection(direction: .up)
        }
        stepCheck(direction: .down)
    }
    @IBAction func leftPressed(_ sender: UIButton) {
        if circle.frame.origin.x - view.bounds.minX > view.bounds.minX {
            setupDirection(direction: .left)
        }
        stepCheck(direction: .right)
    }
    @IBAction func rightPressed(_ sender: UIButton) {
        if circle.frame.origin.x - view.bounds.minX < view.bounds.maxX - 50  {
            setupDirection(direction: .right)
        }
        stepCheck(direction: .left)
    }
    @IBAction func downPressed(_ sender: UIButton) {
        if circle.frame.origin.y - view.bounds.minY < view.bounds.maxY - 50 {
            setupDirection(direction: .down)
        }
        stepCheck(direction: .up)
    }
    
    private func stepCheck(direction: Direction) {
       
        if circle.frame.intersects(up.frame) {
            setupDirection(direction: direction)
            infoLable.text = "соприкосновение с кнопкой up " + direction.directionMessage()
        } else if circle.frame.intersects(down.frame) {
            setupDirection(direction: direction)
            infoLable.text  = "соприкосновение с кнопкой down " + direction.directionMessage()
        } else if circle.frame.intersects(right.frame) {
            setupDirection(direction: direction)
            infoLable.text = "соприкосновение с кнопкой right " + direction.directionMessage()
        } else if circle.frame.intersects(left.frame){
            setupDirection(direction: direction)
            infoLable.text = "соприкосновение с кнопкой left " + direction.directionMessage()
        } else if circle.frame.intersects(infoLable.frame){
            setupDirection(direction: direction)
            infoLable.text = "соприкосновение с infolabel " + direction.directionMessage()
        } else {
            infoLable.text = ""
        }
    }
    
    private func setupDirection(direction: Direction) {
        switch direction {
        case .up:
            circle.center.y -= 10
        case .left:
            circle.center.x -= 10
        case .right:
            circle.frame.origin.x += 10
        case .down:
            circle.frame.origin.y += 10
        }
    }
    
    private func setupCicle() {
        circle.layer.cornerRadius = circle.frame.size.width / 2
        circle.clipsToBounds = true
        infoLable.layer.borderWidth = 2.0
        
    }
    
    private func setupSwipeDirection() {
        let topSwipe = UISwipeGestureRecognizer()
        topSwipe.addTarget(self, action: #selector(handleSwipe))
        topSwipe.direction = .up
        view.addGestureRecognizer(topSwipe)
        
        let downSwipe = UISwipeGestureRecognizer()
        downSwipe.addTarget(self, action: #selector(handleSwipe))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer()
        leftSwipe.addTarget(self, action: #selector(handleSwipe))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer()
        rightSwipe.addTarget(self, action: #selector(handleSwipe))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
    }
    
    @objc
    private func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
            if circle.frame.origin.x - view.bounds.minX < view.bounds.maxX - 50  {
                setupDirection(direction: .right)
            }
            stepCheck(direction: .left)
        case .left:
            if circle.frame.origin.x - view.bounds.minX > view.bounds.minX {
                setupDirection(direction: .left)
            }
            stepCheck(direction: .right)
        case .up:
            if circle.frame.origin.y - view.bounds.minY > view.bounds.minY  {
                setupDirection(direction: .up)
            }
            stepCheck(direction: .down)
        case .down:
            if circle.frame.origin.y - view.bounds.minY < view.bounds.maxY - 50 {
                setupDirection(direction: .down)
            }
            stepCheck(direction: .up)
        default: return
        }
    }

}
