//
//  CenterDetailsViewController.swift
//  DonateIt
//
//  Created by Evelyn Hasama on 12/5/20.
//

import UIKit
import Parse

class CenterDetailsViewController: UIViewController {

    var dcname : String!
    var centers = [PFObject]()
    
    @IBOutlet weak var centerName: UILabel!
    
    @IBOutlet weak var centerDescription: UILabel!
    
    @IBOutlet weak var centerHours: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var phoneNumber: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"DonationCenters")
        query.limit = 20
        query.whereKey("Name", equalTo: dcname!)
        query.findObjectsInBackground { (centers, error) in
            if centers != nil {
                self.centers = centers!

            }
        }
        print(centers)
        let center = centers[0]
        centerName.text = center["Name"] as? String
        centerDescription.text = center["Description"] as? String
        centerHours.text = center["hours"] as? String
        address.text = center["Address"] as? String
        phoneNumber.text = center["PhoneNumber"] as? String
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
