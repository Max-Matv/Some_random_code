//
//  GradientView.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 02.Apr.22.
//

import Foundation
import UIKit

func setGradient(view: UIView, colorOne: String = "colorDark", colorTwo: String = "colorLight") {
    
    let color1 = UIColor(named: colorOne)?.cgColor
    let color2 = UIColor(named: colorTwo)?.cgColor
    
    let gradientlayer = CAGradientLayer()
    gradientlayer.frame = view.bounds
    gradientlayer.colors = [color1! , color2!]
    gradientlayer.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradientlayer.endPoint = CGPoint(x: 0.0, y: 1.0)
    view.layer.insertSublayer(gradientlayer, at: 0)
}
