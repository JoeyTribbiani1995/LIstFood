//
//  Meal.swift
//  LIstFood
//
//  Created by Dũng Võ on 3/10/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import Foundation

class Meal {
    var name : String
    var photo : String?
    var rating : Int
    
    init?(name : String , photo : String? , rating : Int) {
        if name.isEmpty || rating < 0 {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    static func loadSampleData() -> [Meal] {
        let meal1 = Meal(name: "pizza", photo: "Pizza", rating: 4)
        let meal2 = Meal(name: "chicken", photo: "Chicken", rating: 3)
        let meal3 = Meal(name: "salad", photo: "Salad", rating: 2)
        
        return [meal1!,meal2!,meal3!]
    }
    
}
