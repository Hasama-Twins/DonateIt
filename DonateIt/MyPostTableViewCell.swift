//
//  MyPostTableViewCell.swift
//  DonateIt
//
//  Created by Evelyn Hasama on 12/3/20.
//

import UIKit
import Parse

class MyPostTableViewCell: UITableViewCell {

    var post : PFObject!
    
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    @IBAction func onFlipSwitch(_ sender: Any) {
        if post["itemStatus"] as! Bool == true{
            post["itemStatus"] = false
       }else if post["itemStatus"] as! Bool == false {
        post["itemStatus"] = true
       }
        post.saveInBackground()
        
    }

    
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
