//
//  PostViewController.swift
//  DonateIt
//
//  Created by Evelyn Hasama on 11/25/20.
//

import UIKit
import AlamofireImage
import Parse
import CoreLocation

class PostViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet var itemName: UITextField!
    
    @IBOutlet var itemDescription: UITextField!
    
    @IBOutlet var itemCategory: UIPickerView!
    
    @IBOutlet var itemPickupTime: UITextField!
    
    @IBOutlet var itemImage: UIImageView!
    
    var userlocation: CLLocation!
    var geolocation: PFGeoPoint!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.userlocation = locationManager.location
            self.geolocation = PFGeoPoint(location: userlocation)
        }
        
        self.itemCategory.delegate = self
        self.itemCategory.dataSource = self
        
        pickerData = ["Clothes","Electronics","Food", "Furniture","Sporting Equipment","Toys", "Other"]
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    @IBAction func onPhotoButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        itemImage.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostButton(_ sender: Any) {
        let post = PFObject(className: "Item")
        
        post["location"] = geolocation
        post["itemName"] = itemName.text!
        post["description"] = itemDescription.text!
        post["itemCategory"] = pickerData[itemCategory.selectedRow(inComponent: 0)]
        post["itemStatus"] = false
        
        let imageData = itemImage.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        post["image"] = file
        post["author"] = PFUser.current()?.username!
        post["pickupTime"] = itemPickupTime.text!
        
        post.saveInBackground { (success, error) in
            if success {
                print("saved")
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                print("error")
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

}
