//
//  MyPostTableViewCell.swift
//  DonateIt
//
//  Created by Evelyn Hasama on 12/3/20.
//

import UIKit

class MyPostTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    @IBOutlet weak var statusSwitch: UISegmentedControl!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
