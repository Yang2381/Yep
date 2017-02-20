//
//  BusinessCellTableViewCell.swift
//  Yelp
//
//  Created by YangSzu Kai on 2017/2/14.
//  Copyright © 2017年 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCellTableViewCell: UITableViewCell {
    
    var business: Business!{
        didSet {
            titleLabel.text = business.name
            foodImage.setImageWith(business.imageURL!)
            category.text = business.categories
            addressLabel.text = business.address
            reviewLabel.text = "\(business.reviewCount!) Reviews"
            starImage.setImageWith(business.ratingImageURL!)
            distanceLabel.text = business.distance
        }
    }
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        foodImage.layer.cornerRadius = 5
        foodImage.clipsToBounds = true
       // titleLabel.preferredMaxLayoutWidth = titleLabel.frame.size.width
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
