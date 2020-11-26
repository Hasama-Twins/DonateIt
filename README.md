Original App Design Project - README Template
===

# DonateIt

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Donate goods to people in your neighborhood or pick up other people's excess goods in order to help minimize waste and be sustainable.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Shopping (free items though)
- **Mobile:** uses camera, uses Apple maps, mobile first experience.
- **Story:** Allows users to donate unwanted goods to people in your neighborhood or pick up other people's excess goods in order to help minimize waste and be sustainable.
- **Market:** Anyone that has something to donate or something in excess or anyone seeking free goods.
- **Habit:** Users can find FREE items on the app daily and clean out their houses by donating their unused items. Could find someone's unwanted treasure.
- **Scope:** DonateIt starts out with a narrow scope of sharing free items within a small community. Possible expansions for a larger scope include growing to be a nationwide application.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User can register a new account
- [x] User can login to their account
- [x] User can post pictures and details of their free item
- [ ] User can find free items by scrolling through a feed
- [ ] User can select item to see additional details
- [ ] User can comment on the post
- [ ] User can see their own posted items


**Optional Nice-to-have Stories**

* Find free items on a map within a radius
* Receive the address and mapping to the item
* Search/filter/catagories for items
* Badges for levels of donating
* Messaging to contact donaters

## Video Walkthrough for Milestone 1

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/cXIPTfRtf2.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

### 2. Screen Archetypes

* Login
   * User can login to their account
* Register
   * User can register a new account
* Stream
    * User can find free items by scrolling through a feed
* Detail
    * User can select item to see additional details
    * User can comment on the post
* Creation
    * User can post pictures and details of their free item
* Profile
    * User can see their own posted items
* Maps (optional)
    * User can find free items on a map within a radius

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Stream
* Maps (optional)
* Creation
* Profile

**Flow Navigation** (Screen to Screen)

* Login
   * Stream
* Register
   * Stream
* Stream
    * Detail
* Creation
    * Stream
* Profile
    * Detail
* Maps (optional)
    * Detail

## Wireframes
<img src="https://github.com/Hasama-Twins/DonateIt/blob/main/SketchWireframe.png" width=400>

### [BONUS] Digital Wireframes & Mockups
<img src="https://github.com/Hasama-Twins/DonateIt/blob/main/digitalwireframe.png" width=800>

### [BONUS] Interactive Prototype
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
   | description   | String   | description of item |
   | pickupTimes   | String   | when the item is available for pickup |
   | pickupLocation| String   | location for pickup of item |
   | comments      | String   | comments from other users |
   | createdAt     | DateTime | date when post is created (default field) |
   | itemStatus    | Boolean  | whether the item has been donated |

### Comments
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | author        | Pointer to User | registered user |
   | post          | Pointer to post | post the user commnented on |
   | text          | String   | comment text |
   | createdAt     | DateTime | date when post is created (default field) |
   | updatedAt     | DateTime | date when post is last updated (default field) |

### Networking
#### List of network requests by screen
   - Profile Screen
      - (Read/GET) Query all posts where user is author
         ```swift
         let query = PFQuery(className:"Post")
         query.whereKey("author", equalTo: currentUser)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let posts = posts {
               print("Successfully retrieved \(posts.count) posts.")
           // TODO: Do something with posts...
            }
         }
         ```
   - Create Post Screen
      - (Create/POST) Create a new post object
        ```swift
         let itemPost = PFObject(className:"Post")
         itemPost["author"] = currentUser
         itemPost["itemName"] = nameTextField.text
         itemPost["description"] = descriptionTextField.text
         itemPost["locationCity"] = descriptionTextField.text
         itemPost["image"] = imageView.image
         itemPost["itemStatus"] = false
         itemPost.saveInBackground { (succeeded, error)  in
         if (succeeded) {
               // The post has been saved.
            } else {
               // There was a problem, check error.description
         }
         ```
   - Stream Screen
      - (Read/GET) Query all posts within the community
      ```swift
         let query = PFQuery(className:"Post")
         query.whereKey("locationCity", equalTo: ) #current user's city
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let posts = posts {
               print("Successfully retrieved.")
           // TODO: Do something with post details...
            }
         }
         ```
  - Details Screen
      - (Read/GET) Query all information for the post
      ```swift
         let query = PFQuery(className:"Post")
         query.whereKey("objectID", equalTo: ) #object ID of selected post
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let posts = posts {
               print("Successfully retrieved \(posts.count) posts.")
           // TODO: Do something with posts...
            }
         }
       ```
     - (Read/GET) Query the comments for the post
      ```swift
         let query = PFQuery(className:"Comments")
         query.whereKey("post", equalTo: ) #point to selected post
         query.findObjectsInBackground { (comments: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let comment = comment {
               print("Successfully retrieved \(comments.count) comment.")
           // TODO: Do something with comments...
            }
         }
       ```
    - (Create/COMMENT) Create a new comment object
        ```swift
         let itemComment = PFObject(className:"Comments")
         itemComment["author"] = currentUser
         itemPost["text"] = commentField.text
         itemPost.saveInBackground { (succeeded, error)  in
         if (succeeded) {
               // The post has been saved.
            } else {
               // There was a problem, check error.description
         }
         ```
   - Maps Screen (optional)
      - (Read/GET) Query all donation centers in community
      ```swift
         // (Still figuring this out)
     ```    
