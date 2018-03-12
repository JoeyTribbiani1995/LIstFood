//
//  Meal.swift
//  LIstFood
//
//  Created by Dũng Võ on 3/10/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit
import Foundation
import os.log



class Meal : NSObject ,NSCoding {
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

    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
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
    
    static let documentDictionary = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archieveURL = documentDictionary.appendingPathComponent("ListFood")
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name,forKey: PropertyKey.name)
        aCoder.encode(photo,forKey : PropertyKey.photo)
        aCoder.encode(rating,forKey :PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey : PropertyKey.name)as? String else {
            os_log("unable to decode the name for a meal object", log: OSLog.default,type :.debug)
            return nil
        }
        
        let photo = aDecoder.decodeObject(forKey : PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        self.init(name:name ,photo:photo, rating : rating)
    }
    
   
   

}















