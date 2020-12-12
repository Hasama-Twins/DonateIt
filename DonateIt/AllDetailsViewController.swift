//
//  AllDetailsViewController.swift
//  DonateIt
//
//  Created by Evelyn Hasama on 12/4/20.
//

import UIKit
import Parse
import AlamofireImage
import MapKit

class AllDetailsViewController: UIViewController {
    
    
    var post : PFObject!
    
    
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var category: UILabel!
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var itemStatus: UILabel!
    
    @IBOutlet weak var itemDescription: UILabel!
    
    @IBOutlet weak var pickupTime: UILabel!

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var donatedLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        author.text = post["author"] as! String
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
        
        pickupTime.text = post["pickupTime"] as! String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
       itemImage.af_setImage(withURL: url)
        itemImage.layer.cornerRadius = 20
        itemImage.clipsToBounds = true
    }
    
    
    @IBAction func getDirectionsButton(_ sender: Any) {
    
        let placemark = post["location"] as! PFGeoPoint
        let itemLatitude = placemark.latitude
        let itemLongitude = placemark.longitude
        let coordinates = CLLocationCoordinate2D(latitude: itemLatitude, longitude: itemLongitude)
        let mkplacemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: mkplacemark)
        mapItem.name = post["itemName"] as! String?
        mapItem.openInMaps()
    }
    
    
    @IBAction func onContactButton(_ sender: Any) {
        let number = post["phoneNumber"] as! String
        let username = post["author"] as! String
        let selectitem = post["itemName"] as! String
        var itemname = ""
        for char in selectitem{
            if char == " "{
                itemname += "%20"
            }else{
                itemname += String(char)
            }
        }
        let body1 = number + "&body=Hello%20@"
        let body2 = username + ",%20I%20am%20interested%20in%20the%20"
        let body3 = itemname as! String + "%20you%20are%20donating%20on%20DonateIt..."
        if let url =  URL(string: "sms:" + body1 + body2 + body3) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
        }
        
    }
    
}




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


