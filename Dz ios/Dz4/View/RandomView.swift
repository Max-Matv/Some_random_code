//
//  randomView.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 06.Apr.22.
//

import Foundation
import UIKit

class RandomView: UIView {
    
    let borderWidth: CGFloat = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    override func draw(_ rect: CGRect) {
        let squareSize = frame.size.width - borderWidth
        let squareRect = CGRect(x: borderWidth, y: borderWidth, width: squareSize, height: squareSize)
        let squarePath = UIBezierPath(rect: squareRect)
        squarePath.lineWidth = borderWidth
        
    }
    
    private func setup() {
        backgroundColor = UIColor.clear
    }
}
