//
//  RoundButton.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 23.Apr.22.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

    @IBInspectable var roundButton: Bool = false {
        didSet {
            if roundButton {
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if roundButton {
            layer.cornerRadius = frame.height / 2
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if roundButton {
            layer.cornerRadius = frame.height / 2
        }
    }

}
