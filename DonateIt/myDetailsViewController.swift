//
//  myDetailsViewController.swift
//  DonateIt
//
//  Created by Evelyn Hasama on 12/4/20.
//

import UIKit
import Parse
import AlamofireImage

class myDetailsViewController: UIViewController {


    var post: PFObject!
        
        
        @IBOutlet weak var author: UILabel!
        @IBOutlet weak var category: UILabel!
        @IBOutlet weak var itemImage: UIImageView!
        @IBOutlet weak var itemName: UILabel!
        @IBOutlet weak var itemStatus: UILabel!
        @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var pickupTime: UILabel?
        @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var donatedLabel: UILabel!
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            author.text = post["author"] as? String
            category.text = post["itemCategory"] as? String
            itemName.text = post["itemName"] as? String
            if post["itemStatus"] as! Bool == true {
                itemStatus.text = "Status: Donated"
                donatedLabel.isHidden = false
            }
            else {
                itemStatus.text = "Status: Available"
                donatedLabel.isHidden = true
            }
            itemDescription.text = post["description"] as? String
            
            let date = post.createdAt!
            let formatter = DateFormatter()
            formatter.timeZone = NSTimeZone(name: "PST") as TimeZone?
            formatter.dateFormat = "MMM d, y"
            dateLabel.text = formatter.string(from: date as! Date)
            
            pickupTime?.text = post["pickupTime"] as! String
            
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
           itemImage.af_setImage(withURL: url)
        
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
