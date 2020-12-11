//
//  AllPostsViewController.swift
//  DonateIt
//
//  Created by Evelyn Hasama on 12/3/20.
//

import UIKit
import Parse
import AlamofireImage
import CoreLocation

class AllPostsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var radiusControl: UISegmentedControl!
    
    @IBOutlet weak var resultcount: UILabel!
    var posts = [PFObject]()
    var userlocation : CLLocation!
    var geolocation : PFGeoPoint!
    var radius : Double!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.userlocation = locationManager.location
            self.geolocation = PFGeoPoint(location: userlocation)
            print(self.geolocation!)
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if radiusControl.selectedSegmentIndex==0{
            radius = 5
        }else if radiusControl.selectedSegmentIndex==1{
            radius = 10
        }else if radiusControl.selectedSegmentIndex==2{
            radius = 20
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.minimumLineSpacing = 15
            layout.minimumInteritemSpacing = 8
     
        
        let width = (collectionView.frame.size.width - layout.minimumInteritemSpacing * 2) / 2
            layout.itemSize = CGSize(width: width, height: 230)
        
        
        
            let query = PFQuery(className:"Item")
            query.limit = 20
            query.whereKey("location", nearGeoPoint: geolocation, withinMiles: radius)
            query.order(byDescending: "createdAt")
            query.findObjectsInBackground { (posts, error) in
                if posts != nil {
                    self.posts = posts!
                    self.collectionView.reloadData()
                    self.collectionView.layoutIfNeeded()
            }
        }
    
    }
    
    @IBAction func changeRadius(_ sender: Any) {
        viewDidAppear(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resultcount.text = String(posts.count)
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
        let post = posts[indexPath.item]
        cell.itemName.text = post["itemName"] as! String
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.itemImage.af_setImage(withURL: url)
        
        
        cell.contentView.layer.cornerRadius = 7.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 3.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    
   
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)
        let allDetailsViewController = segue.destination as! AllDetailsViewController
        allDetailsViewController.post = posts[indexPath!.item] as? PFObject
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
