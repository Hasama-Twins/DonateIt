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
    
    
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var shadowLayer: UIView!
    
    @IBOutlet weak var mainBackground: UIView!
    
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
    
    func setupCell() {
            
            // Round the corners
            self.mainBackground.layer.cornerRadius = 8
            self.mainBackground.layer.masksToBounds = true
            self.shadowLayer.layer.cornerRadius = 8
            self.shadowLayer.layer.masksToBounds = false
            //self.shadowLayer.layer.shadowColor = UIColor.black.cgColor
        
        self.shadowLayer.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.shadowLayer.layer.shadowRadius = 3
        self.shadowLayer.layer.shadowOpacity = 0.3
        self.shadowLayer.layer.shadowPath = UIBezierPath(roundedRect: testView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.shadowLayer.layer.shouldRasterize = true
        self.shadowLayer.layer.rasterizationScale = UIScreen.main.scale
        
            
        }
    
}

