//
//  MealTableViewCell.swift
//  LIstFood
//
//  Created by Dũng Võ on 3/10/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCellView(with meal : Meal) {
    
        if let photo = meal.photo {
            photoImageView.image = photo
        }else {
            photoImageView.image = UIImage(named: "image")
        }
        
        mealNameLabel.text = meal.name
        ratingControl.rating = meal.rating
        
    }

}
