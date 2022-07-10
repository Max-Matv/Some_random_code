//
//  TapCircleViewController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 19.Apr.22.
//

import UIKit

class TapCircleViewController: UIViewController {
    
    private var circleList: [UIView] = [UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))]
    private var isFound: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        gestureTap()

    }
    private func gestureTap() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTapsRequired = 1
        tapGesture.addTarget(self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func tap(_ sender: UIPanGestureRecognizer) {
        let circle = addCircle(coordinateX: sender.location(in: self.view).x - 25, coordinateY: sender.location(in: self.view).y - 25)
        var index = 0
        for circleView in circleList {
            if circleView.frame.intersects(circle.frame) {
                circleView.removeFromSuperview()
                circleList.remove(at: index)
                isFound = true
                return
            }
            index += 1
            isFound = false
        }
        if isFound != true {
            circleList.append(circle)
            view.addSubview(circle)
            isFound = false
        }
        
        
    }
    
    private func addCircle(coordinateX: CGFloat, coordinateY: CGFloat) -> UIView {
        let circle = UIView(frame: CGRect(x: coordinateX, y: coordinateY, width: 50, height: 50))
        circle.backgroundColor = .red
        circle.layer.cornerRadius = circle.frame.size.width / 2
        circle.clipsToBounds = true
        return circle
    }
}
