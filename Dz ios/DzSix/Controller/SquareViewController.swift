//
//  SquareViewController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 26.Apr.22.
//

import UIKit

class SquareViewController: UIViewController {
    
    private var square = UIView()
    @IBOutlet weak var polygon: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSquare()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveRight()
    }
    
    private func moveRight() {
        UIView.animate(withDuration: 1, delay: 0, options: []) {
            self.square.frame.origin.x = self.polygon.bounds.maxX - self.square.frame.width
        } completion: { _ in
            self.moveDown()
        }

    }
    private func moveDown() {
        UIView.animate(withDuration: 1, delay: 0, options: []) {
            self.square.frame.origin.y = self.polygon.bounds.maxY - self.square.frame.height
        } completion: { _ in
            self.moveLeft()
        }

    }
    private func moveLeft() {
        UIView.animate(withDuration: 1, delay: 0, options: []) {
            self.square.frame.origin.x = self.polygon.bounds.minX
        } completion: { _ in
            self.moveUp()
        }

    }
    private func moveUp() {
        UIView.animate(withDuration: 1, delay: 0, options: []) {
            self.square.frame.origin.y = self.polygon.bounds.minY
        } completion: { _ in
            self.moveRight()
        }

    }
    
    private func setupSquare() {
        square.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        square.backgroundColor = .green
        polygon.addSubview(square)
    }

}
