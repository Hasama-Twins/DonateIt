
# DonateIt

## Demo

[![](http://img.youtube.com/vi/NbfG26QO_wQ/0.jpg)](http://www.youtube.com/watch?v=NbfG26QO_wQ "DonateIt Demo")

Youtube Demo: https://youtu.be/NbfG26QO_wQ

## Featured Articles
https://blog.codepath.org/made-by-our-students-donateit/

https://blog.codepath.org/2020-codepath-org-fall-semester-demo-day-ios-winners-announced/

“This is such a thoughtful product in the time that we are in right now. During COVID-19 we’re accumulating so many things. From a technical perspective, what a beautiful design. The craft of the app really showed through, and the integration is super top notch. Loved the donation center integration and how it felt like it was part of the core app. Loved the integration with maps and loved the non-profit angle. Congratulations. Really great work.” 

Alan McConnell – Head of Live Engineering at Instagram

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Donate goods to people and donation centers in your neighborhood or pick up other people's excess goods in order to help minimize waste and be sustainable.

### App Evaluation
- **Category:** Shopping (free items though)
- **Mobile:** uses camera, uses Apple maps, uses Messages, mobile first experience.
- **Story:** Allows users to donate unwanted goods to people and donation centers in your neighborhood or pick up other people's excess goods in order to help minimize waste and be sustainable.
- **Market:** Anyone that has something to donate or something in excess or anyone seeking free goods.
- **Habit:** Users can find FREE items on the app daily and clean out their houses by donating their unused items. Could find someone's unwanted treasure.
- **Scope:** DonateIt starts out with a narrow scope of sharing free items within a small community. Possible expansions for a larger scope include growing to be a nationwide application.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User can register a new account
- [x] User can login to their account
- [x] User can post pictures and details of their free item
- [x] User can find free items by scrolling through a feed
- [x] User can select item to see additional details
- [x] User can see their own posted items


**Optional Nice-to-have Stories**

* Find donation centers on a map
* Receive the address and mapping to the item
* Filter catagories and radius for items
* Messaging to contact donaters

### Final Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/M80KpQqgkq.gif' title='Final Video Walkthrough' width='' alt='Final Video Walkthrough' />


### Video Walkthrough for Milestone 1

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/cXIPTfRtf2.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

### Video Walkthroughs for Milestone 2

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/Ny4Nmj1cOB.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Here's another more recently developed walkthrough:

<img src='http://g.recordit.co/NJv7xHE8nB.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

### Video Walkthrough for Milestone 3

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/lsMxoL522o.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

### 2. Screen Archetypes

* Login
   * User can login to their account
   * User can register a new account
* Stream
    * User can find free items by scrolling through a feed
    * User can filter for different mile radius
    * User can filter by category
* Detail (Item)
    * User can select item to see additional details
    * User can get directions to the item's location
    * User can contact the item's owner
* Detail (My Item)
    * User can select item to see additional of their details
* Creation
    * User can post pictures and details of their free item
* Profile
    * User can see their own posted items
    * User can change the status of their item to Donated or Available
* Maps
    * User can find donation centers on a map
* Detail (Center)
    * User can select pin on map to see additional details
    * User can get directions to the center's location

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Stream
* Maps
* Profile

**Flow Navigation** (Screen to Screen)

* Login
   * Stream
* Stream
    * Detail (Item)
* Profile
    * Detail (My Item)
    * Creation
    * Login
* Maps
    * Detail (Center)

## Orginal Wireframes
<img src="https://github.com/Hasama-Twins/DonateIt/blob/main/SketchWireframe.png" width=400>

### [BONUS] Original Digital Wireframes & Mockups
<img src="https://github.com/Hasama-Twins/DonateIt/blob/main/digitalwireframe.png" width=800>

### [BONUS] Original Interactive Prototype
<img src='http://g.recordit.co/nYdhCpX0qa.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Schema 

### Models
#### Post

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | author        | Pointer to User| registered user |
   | image         | File     | image that user posts |
   | itemName      | String   | name of item | 
   | itemCategory  | String   | category of item |
   | description   | String   | description of item |
   | pickupTimes   | String   | when the item is available for pickup |
   | location      | GeoCoord | location for pickup of item |
   | phoneNumber   | String   | user's phone number |
   | createdAt     | DateTime | date when post is created (default field) |
   | itemStatus    | Boolean  | whether the item has been donated |

### Networking
#### List of network requests by screen
   - Profile Screen
      - (Read/GET) Query all posts where user is author
         ```swift
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
         ```
   - Create Post Screen
      - (Create/POST) Create a new post object
        ```swift
         let post = PFObject(className: "Item")
       
        post["location"] = geolocation
        post["itemName"] = itemName.text!
        post["description"] = itemDescription.text!
        post["itemCategory"] = pickerData[itemCategory.selectedRow(inComponent: 0)]
        post["itemStatus"] = false
        post["phoneNumber"] = phoneNumber.text!
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
         ```
   - Stream Screen
      - (Read/GET) Query all posts within the community
      ```swift
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
         ```


