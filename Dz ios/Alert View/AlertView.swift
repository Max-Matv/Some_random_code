//
//  AlertView.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 04.Jun.22.
//

import UIKit

class AlertView: UIView {

    @IBOutlet weak private var alertLabel: UILabel!
    @IBOutlet weak private var alertDescription: UILabel!
    @IBOutlet weak private var contentView: UIView!
    @IBOutlet weak var alertView: UIView!
    
    private var buttons: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func addButton(title: String, style: AlertStyle, action: UIAction) {
        let button = UIButton()
        switch style {
        case .normal:
            button.setTitleColor(.white, for: .normal)
            button.layer.borderColor = CGColor(gray: 1, alpha: 1)
        case .cancel:
            button.setTitleColor(.red, for: .normal)
            button.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        }
        
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.backgroundColor = .brown
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.addAction(UIAction(handler: { _ in
            self.removeFromSuperview()
        }), for: .touchUpInside)
        button.addAction(action, for: .touchUpInside)
        buttons.append(button)
       
        setButtonsConstarints()
    }
    
    private func setButtonsConstarints() {
        contentView.constraints.forEach({ $0.isActive = false })
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: alertDescription.bottomAnchor, constant: 10).isActive = true
        contentView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 10).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        contentView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor,constant: 10).isActive = true
        contentView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: 10).isActive = true
        var index = 0
        for button in buttons {
            if button == buttons.first {
                button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            } else {
                button.widthAnchor.constraint(equalTo: buttons[index - 1].widthAnchor).isActive = true
                button.leadingAnchor.constraint(equalTo: buttons[index - 1].trailingAnchor).isActive = true
                
            }
            if button == buttons.last {
                button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            } else {
                button.trailingAnchor.constraint(equalTo: buttons[index + 1].leadingAnchor, constant: -5).isActive = true
            }
            button.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            index += 1
        }
        
    }
    
    func setupTitle(title: String = "", description: String = "") {
        alertLabel.text = title
        alertDescription.text = description
    }
    
    private func setupView() {
        
        guard let view = Bundle.main.loadNibNamed("AlertView", owner: self)?.first as? UIView else {
            fatalError("error")
        }
        view.frame = bounds
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        alertLabel.text = ""
        alertDescription.text = ""
        alertView.layer.cornerRadius = 20
        alertView.backgroundColor = .brown
    }
    
     enum AlertStyle {
        case normal
        case cancel
    }

}
