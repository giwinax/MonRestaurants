//
//  RestaurantDetailTwoColumnCell.swift
//  MonRestaurants
//
//  Created by s b on 26.04.2022.
//

import UIKit

class RestaurantDetailTwoColumnCell: UITableViewCell {

    @IBOutlet var column1TitleLabel: UILabel! {
        didSet {
            column1TitleLabel.text = column1TitleLabel.text?.uppercased()
            column1TitleLabel.numberOfLines = 0
            column1TitleLabel.adjustsFontForContentSizeCategory = true
        }
    }
    
    @IBOutlet var column1TextLabel: UILabel! {
        didSet {
            column1TextLabel.numberOfLines = 0
            column1TextLabel.adjustsFontForContentSizeCategory = true
        }
    }
    
    @IBOutlet var column2TitleLabel: UILabel! {
        didSet {
            column2TitleLabel.text = column2TitleLabel.text?.uppercased()
            column2TitleLabel.numberOfLines = 0
            column2TitleLabel.adjustsFontForContentSizeCategory = true
        }
    }
    
    @IBOutlet var column2TextLabel: UILabel! {
        didSet {
            column2TextLabel.numberOfLines = 0
            column2TextLabel.adjustsFontForContentSizeCategory = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
