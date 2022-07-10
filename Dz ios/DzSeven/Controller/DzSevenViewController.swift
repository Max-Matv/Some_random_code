//
//  DzSevenViewController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 11.May.22.
//

import UIKit

class DzSevenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientView()
    }
    
    private func createGradientView() {
        let view = UIView()
        view.frame.size = CGSize(width: 200, height: 200)
        view.center.x = self.view.center.x
        view.center.y = self.view.center.y
        
        view.dropShadow()
        self.view.addSubview(view)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.green.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.masksToBounds = false
        gradientLayer.cornerRadius = 25
        view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
}
