//
//  TotalCell.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 01.Apr.22.
//

import UIKit

class TotalCell: UITableViewCell {
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerCount: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(beer: Beer) {
        beerImage.image = UIImage(named: beer.image)
        beerName.text = beer.name
        beerCount.text = String(beer.count)
    }

}
