//
//  GalleryView.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 07.Jun.22.
//

import UIKit

class GalleryView: UIView {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var delegate: GaleryViewDelegate?
    private var likeIsEnable = false {
        didSet {
            likeButton.tintColor = likeIsEnable ? .red : .gray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setLikeStatus(status: Bool) {
        likeIsEnable = status
    }
    
    @IBAction func likePressed(_ sender: Any) {
        likeIsEnable.toggle()
        delegate?.likePressed()
    }
    
    @IBAction func commentPressed(_ sender: Any) {
        delegate?.commentAction()
    }
    
    func addImage(image: UIImage) {
        self.image.image = image
    }
    
    func getImage() -> UIImage {
        self.image.image!
    }
    
    private func setupView() {
        
        guard let view = Bundle.main.loadNibNamed("GalleryView", owner: self)?.first as? UIView else {
            fatalError("error")
        }
        view.frame = bounds
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        likeButton.tintColor = likeIsEnable ? .red : .gray
        commentButton.tintColor = .gray
    }

}

protocol GaleryViewDelegate {
    func commentAction()
    func likePressed()
}
