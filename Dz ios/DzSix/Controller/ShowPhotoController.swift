//
//  ShowPhotoController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 25.May.22.
//

import UIKit

class ShowPhotoController: UIViewController {
    
    var image = UIImage()
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var zoomImage: UIImageView!
    @IBOutlet weak private var imageHeight: NSLayoutConstraint!
    @IBOutlet weak private var contentView: UIView!
    
    
    private var topInset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setupImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let image = zoomImage.image {
            let width = image.size.width
            let height = image.size.height
            let aspect = width / height
            imageHeight.constant = zoomImage.frame.width / aspect
        }
        view.layoutIfNeeded()
        topInset = (scrollView.frame.height - zoomImage.frame.height) / 2
        scrollView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
    }
    
    private func setupImage() {
        zoomImage.contentMode = .scaleAspectFit
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        zoomImage.image = image
    }
    
}


extension ShowPhotoController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        topInset = (scrollView.frame.height - contentView.frame.height) / 2
        if topInset > 0 {
            scrollView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        } else {
            scrollView.contentInset = .zero
        }
    }
}
