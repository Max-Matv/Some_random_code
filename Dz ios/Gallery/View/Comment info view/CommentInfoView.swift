//
//  CommentInfoView.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 11.Jun.22.
//

import UIKit

class CommentInfoView: UIView {

    
    
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var commentLabel: UILabel!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setComment(comment: String) {
        commentLabel.text = comment
    }
    
    func setDate(date: String) {
        dateLabel.text = date
    }
    
    
    private func setupView() {
        
       guard let view = Bundle.main.loadNibNamed("CommentInfoView", owner: self)?.first as? UIView else {
           fatalError("error")
        }
        view.frame = bounds
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        view.layer.cornerRadius = 20
    }
}
