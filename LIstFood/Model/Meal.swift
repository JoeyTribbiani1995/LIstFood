//
//  Meal.swift
//  LIstFood
//
//  Created by Dũng Võ on 3/10/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class Meal {
    var name : String
    var photo : UIImage?
    var rating : Int
    
    init?(name : String , photo : UIImage? , rating : Int) {
        if name.isEmpty || rating < 0 {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    static func loadSampleData() -> [Meal] {
        let photo1 = UIImage(named: "Pizza")
        let photo2 = UIImage(named: "Chicken")
        let photo3 = UIImage(named: "Salad")
        
        let meal1 = Meal(name: "pizza", photo:photo1, rating: 4)
        let meal2 = Meal(name: "chicken", photo: photo2, rating: 3)
        let meal3 = Meal(name: "salad", photo: photo3, rating: 2)
        
        return [meal1!,meal2!,meal3!]
    }
    
}
