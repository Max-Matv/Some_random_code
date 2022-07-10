//
//  ColoredTableViewCell.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 14.Jun.22.
//

import UIKit

class ColoredTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    var buttonPressed: () -> Void = {}
    var delegate: CustomCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func buttonPressed(_ sender: Any) {
        buttonPressed()
        delegate?.pressButton()
    }
    
    
}

protocol CustomCellDelegate {
    func pressButton()
}
