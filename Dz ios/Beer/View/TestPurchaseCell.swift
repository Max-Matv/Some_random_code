//
//  TestPurchaseCell.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 01.Apr.22.
//

import UIKit

class TestPurchaseCell: UITableViewCell {
    
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func stepper(_ sender: UIStepper) {
        beerCount.text = Int(sender.value).description
    }
    
    func setupCell(beer: Beer) {
        beerName.text = beer.name
        beerImage.image = UIImage(named: beer.image)
    }

}
