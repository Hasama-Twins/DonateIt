//
//  MyCategories.swift
//  DonateIt
//
//  Created by Evelyn Hasama on 12/11/20.
//

import UIKit


class MyCategories: UIScrollView{
    var scrollViewWidth:Float = 0.0
    scrollViewWidth = scrollViewWidth + Float(size.width)
        }
    scrollView.contentSize = CGSize(width: scrollViewWidth, height: 40)// height should whatever you want.
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

class SegmentedCategories: UISegmentedControl {
    let items  = ["All Fruits", "Orange", "Grapes", "Banana",  "Mango", "papaya", "coconut", "django"]
    for (index, element) in items.enumerated() {
        let size = element.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20.0)]) //you can change font as you want
        segmentCon.setWidth(size.width, forSegmentAt: index)
    
    }
}
