//
//  CenterDetailsViewController.swift
//  DonateIt
//
//  Created by Evelyn Hasama on 12/5/20.
//

import UIKit
import Parse

class CenterDetailsViewController: UIViewController {

    var dcobj : PFObject!
    
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
        print(dcobj!)
        
        centerName.text = dcobj["Name"] as? String
        centerDescription.text = dcobj["Description"] as? String
        centerHours.text = dcobj["hours"] as? String
        address.text = dcobj["Address"] as? String
        phoneNumber.text = dcobj["PhoneNumber"] as? String
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
