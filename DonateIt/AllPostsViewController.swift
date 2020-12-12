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
    
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var radiusControl: UISegmentedControl!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var resultcount: UILabel!
    var posts = [PFObject]()
    var filteredposts = [PFObject]()
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
        scroll.contentSize = CGSize(width: scroll.contentSize.width, height: scroll.frame.size.height)
        scroll.showsHorizontalScrollIndicator = false //disable horizontal scroll
            scroll.showsVerticalScrollIndicator = false //disable vertical scroll
            segmentedControl.frame = CGRect(x: 0, y: 0, width: 1000, height: 40) //change accordingly
            segmentedControl.selectedSegmentIndex = 0 //by default selected index
            segmentedControl.backgroundColor = .clear
            segmentedControl.tintColor = .clear
            let backgroundImage = UIImage(named: "notselected.png")?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            segmentedControl.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
            let backgroundImage2 = UIImage(named: "selected.png")?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            segmentedControl.setBackgroundImage(backgroundImage2, for: .selected, barMetrics: .default)
            segmentedControl.removeBorders()
            segmentedControl.layer.cornerRadius = 15.0
            segmentedControl.layer.borderColor = UIColor.white.cgColor
            segmentedControl.layer.borderWidth = 1.0
            segmentedControl.layer.masksToBounds = true
            scroll.addSubview(segmentedControl) // add segment
            scroll.contentSize = CGSize(width: segmentedControl.frame.size.width, height: segmentedControl.frame.size.height + 10) //change accordingly
            view.addSubview(scroll) //add scroll view
        
    }
    
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
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
            layout.minimumLineSpacing = 19
            layout.minimumInteritemSpacing = 12
     
        
        //let width = (collectionView.frame.size.width - layout.minimumInteritemSpacing * 2) / 2
        let width = 173.5
            layout.itemSize = CGSize(width: width, height: 200)
        
        
        
            let query = PFQuery(className:"Item")
            query.limit = 60
            query.whereKey("location", nearGeoPoint: geolocation, withinMiles: radius)
            query.order(byDescending: "createdAt")
            query.findObjectsInBackground { (posts, error) in
                if posts != nil {
                    self.posts = posts!
                    let myindex = self.segmentedControl.selectedSegmentIndex
                    if myindex == 0{
                        self.filteredposts = self.posts
                    } else{
                        self.filteredposts = []
                        let mydata = ["All","Clothes","Electronics","Food", "Furniture","Sports","Toys", "Other"]
                        for post in self.posts{
                            if post["itemCategory"] as! String == mydata[myindex]{
                                self.filteredposts.append(post)
                            }
                        }
                    }
                    self.collectionView.reloadData()
                    self.collectionView.layoutIfNeeded()
            }
        }
    
    }
    
    
    @IBAction func changeSegment(_ sender: Any) {
        let myindex = segmentedControl.selectedSegmentIndex
        if myindex == 0{
            filteredposts = posts
        } else{
            filteredposts = []
            let mydata = ["All","Clothes","Electronics","Food", "Furniture","Sports","Toys", "Other"]
            for post in posts{
                if post["itemCategory"] as! String == mydata[myindex]{
                    filteredposts.append(post)
                }
            }
        }
        self.collectionView.reloadData()
        self.collectionView.layoutIfNeeded()
    }
    
    
    @IBAction func changeRadius(_ sender: Any) {
        viewWillAppear(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resultcount.text = String(filteredposts.count)
        return filteredposts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
        let post = filteredposts[indexPath.item]
        cell.itemName.text = post["itemName"] as! String
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.itemImage.af_setImage(withURL: url)
        
        if post["itemStatus"] as! Bool == true {
            cell.donatedLabel.isHidden = false
        }
        else {
            cell.donatedLabel.isHidden = true
        }
        
        cell.contentView.layer.cornerRadius = 12.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 5.0
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
        allDetailsViewController.post = filteredposts[indexPath!.item] as? PFObject
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

extension UISegmentedControl {
  func removeBorders() {
    setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
  }
  // create a 1x1 image with this color
  private func imageWithColor(color: UIColor) -> UIImage {
    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(color.cgColor);
    context!.fill(rect);
    let image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image!
  }
}

