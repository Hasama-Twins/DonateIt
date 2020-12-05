//
//  MyPostsTableViewController.swift
//  DonateIt
//
//  Created by Evelyn Hasama on 12/3/20.
//

import UIKit
import Parse
import AlamofireImage

class MyPostsTableViewController: UITableViewController {
    
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Item")
        query.limit = 20
        query.order(byDescending: "createdAt")
        query.whereKey("author", equalTo: PFUser.current()?.username!)
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
        
    }
    
    @IBAction func onLogout(_ sender: Any) {
            PFUser.logOut()
            let main = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
            let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
            delegate.window?.rootViewController = loginViewController
        }
    
    // MARK: - Table view data source
    
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
 */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPostTableViewCell") as! MyPostTableViewCell

        let post = posts[indexPath.row]
        
        cell.itemNameLabel.text = post["itemName"] as? String
        cell.categoryLabel.text = post["itemCategory"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.itemImage.af_setImage(withURL: url)
        
        if post["itemStatus"] as! Bool == true {
            cell.statusSwitch.selectedSegmentIndex = 1
        }else if post["itemStatus"] as! Bool == false{
            cell.statusSwitch.selectedSegmentIndex = 0
        }
        
        let date = post.createdAt!
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone(name: "PST") as TimeZone?
        formatter.dateFormat = "MMM d, y"
        cell.dateLabel.text = formatter.string(from: date as! Date)
        
        cell.post = post
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails"{
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let MyDetailsViewController = segue.destination as! myDetailsViewController
            MyDetailsViewController.post = posts[indexPath!.row] as? PFObject
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
