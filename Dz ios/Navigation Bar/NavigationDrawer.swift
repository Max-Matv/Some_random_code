//
//  NavigationDrawer.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 17.May.22.
//

import Foundation
import UIKit


class NavigationDrawer {
    
    private var navTitle: String?
    private var navImage: String?
    private let navView = UIView()
    private var leftConstraint = NSLayoutConstraint()
    private var topConstraint = NSLayoutConstraint()
    private var bottomConstraint = NSLayoutConstraint()
    private var rightConstraint = NSLayoutConstraint()
    private let superview: UIView
    private var backgroundColor: UIColor = .white
    private var blureView = UIVisualEffectView()
    private var closeButton = UIButton()
    private var label = UILabel()
    private var navElements: [UILabel] = []
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var contentConstraintBottom = NSLayoutConstraint()
    
    
    init(superview: UIView) {
        self.superview = superview
        addNavigationDrawer()
    }
    
    init(superview: UIView, backgroundColor: UIColor) {
        self.superview = superview
        self.backgroundColor = backgroundColor
        addNavigationDrawer(backgoundColor: backgroundColor)
    }
    
    init(superview: UIView, navTitle: String, backgroundColor: UIColor) {
        self.superview = superview
        self.navTitle = navTitle
        self.backgroundColor = backgroundColor
        addNavigationDrawer(backgoundColor: backgroundColor)
    }
    
    private func addNavigationDrawer(backgoundColor color: UIColor = .brown)  {
       
       blureView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
       blureView.frame = superview.safeAreaLayoutGuide.layoutFrame
       superview.addSubview(blureView)
       blureView.isHidden = true
       
       
        navView.backgroundColor = color
        navView.translatesAutoresizingMaskIntoConstraints = false
        
        superview.addSubview(navView)
       
        createLabel()
        createCloseButton()
        addScrollView()
        

        leftConstraint = NSLayoutConstraint(item: navView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: .equal, toItem: superview, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0)
        topConstraint = NSLayoutConstraint(item: navView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: .equal, toItem: superview.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.top
                                           , multiplier: 1.0, constant: 0)
        bottomConstraint = NSLayoutConstraint(item: navView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: .greaterThanOrEqual, toItem: superview, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: -superview.frame.height)
        rightConstraint = NSLayoutConstraint(item: navView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: .greaterThanOrEqual, toItem: superview, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: -superview.frame.width)
        superview.addConstraints([leftConstraint, topConstraint, bottomConstraint, rightConstraint])
        
        
    }
    
    private func addScrollView() {
        scrollView.frame = superview.bounds
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: navView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: navView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: navView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: scrollView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: navView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        contentConstraintBottom = NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: navView.frame.height)
        scrollView.addConstraint(contentConstraintBottom)
    }
    
    func addNavigationElement(title: String, color: UIColor) {
        let view = UILabel()
        view.text = title
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        
        if navElements.isEmpty {
            view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        } else {
            view.topAnchor.constraint(equalTo: navElements.last!.bottomAnchor).isActive = true
        }
        view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        navElements.append(view)
        contentConstraintBottom.constant += 60
        scrollView.layoutIfNeeded()
        
    }
    
    private func createLabel() {
        
        label.text = navTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        navView.addSubview(label)
        label.leftAnchor.constraint(equalTo: navView.leftAnchor, constant: 0).isActive = true
        label.topAnchor.constraint(equalTo: navView.topAnchor, constant: 0).isActive = true
        label.rightAnchor.constraint(equalTo: navView.rightAnchor, constant: 0).isActive = true
        label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        label.backgroundColor = backgroundColor
        
    }
    
     func drawerAction(style: NavigationDrawerStyle = .endToEnd) {
        
         blureView.isHidden = false
         setupNavigationStyle(style: style)
         label.text = navTitle
        
    }
    private func setupNavigationStyle(style: NavigationDrawerStyle) {
        switch style {
        case .endToEnd:
            bottomConstraint.constant = -150
            superview.layoutIfNeeded()
            rightConstraint.constant = -150
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
                self.superview.layoutIfNeeded()
            }

        case .bottomToBottom:
            rightConstraint.constant = -150
            superview.layoutIfNeeded()
            bottomConstraint.constant = -150
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
                self.superview.layoutIfNeeded()
            }


        case .diagonally:
            bottomConstraint.constant = -150
            rightConstraint.constant = -150
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
                self.superview.layoutIfNeeded()
            } 

        }
    }
    
    private func createCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(UIImage(systemName: "clear"), for: .normal)
        closeButton.imageView?.contentMode = .scaleAspectFit
        closeButton.addAction(UIAction(handler: { _ in
            self.closeNavigationDrawer()
        }), for: .touchUpInside)
        navView.addSubview(closeButton)
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.topAnchor.constraint(equalTo: navView.topAnchor, constant: 0).isActive = true
        closeButton.rightAnchor.constraint(equalTo: navView.rightAnchor, constant: 0).isActive = true
        
    }
    
    func closeNavigationDrawer() {
        
        rightConstraint.constant = -superview.frame.width
        blureView.isHidden = true
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            self.superview.layoutIfNeeded()
            self.label.text = ""
        } completion: { _ in
            self.navView.removeFromSuperview()
        }
        
    }
    
}

enum NavigationDrawerStyle {
    case endToEnd
    case bottomToBottom
    case diagonally

}
