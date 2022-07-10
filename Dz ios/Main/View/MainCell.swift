//
//  MainCell.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 22.Mar.22.
//

import UIKit

class MainCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(menu: Menu) {
        
        self.label.text = menu.name
        contentView.backgroundColor = UIColor(named: menu.background)
    }

}
