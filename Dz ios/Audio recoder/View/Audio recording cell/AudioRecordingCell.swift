//
//  AudioRecordingCell.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 01.Jul.22.
//

import UIKit

class AudioRecordingCell: UITableViewCell {

    @IBOutlet weak private var recordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(name: String) {
        recordLabel.text = name
    }

}
