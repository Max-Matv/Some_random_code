//
//  CommentTableViewCell.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 22.Jun.22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak private var commentLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(comment: Comment) {
        commentLabel.text = comment.getTextBody()
        dateLabel.text = comment.getDate()
    }
    
}
