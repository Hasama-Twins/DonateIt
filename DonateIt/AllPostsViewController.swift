//
//  AllPostsViewController.swift
//  DonateIt
//
//  Created by Evelyn Hasama on 12/3/20.
//

import UIKit
import Parse
import AlamofireImage

class AllPostsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    var posts = [PFObject]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 5
        
        let width = (collectionView.frame.size.width - layout.minimumInteritemSpacing * 2) / 2
            layout.itemSize = CGSize(width: width, height: 230)
        print(layout.itemSize)
            let query = PFQuery(className:"Item")
            query.limit = 20
            query.order(byDescending: "createdAt")
            query.findObjectsInBackground { (posts, error) in
                if posts != nil {
                    self.posts = posts!
                    self.collectionView.reloadData()
                    self.collectionView.layoutIfNeeded()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
