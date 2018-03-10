//
//  MealTableViewController.swift
//  LIstFood
//
//  Created by Dũng Võ on 3/10/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {

    var mealList : [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       mealList = Meal.loadSampleData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealIdentifier", for: indexPath) as! MealTableViewCell

        let meal = mealList[indexPath.row]
        
        cell.updateCellView(with: meal)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MealDetail" {
            let indexPath = tableView.indexPathForSelectedRow!
            let meal = mealList[indexPath.row]
            let mealViewController = segue.destination as! MealViewController
            mealViewController.meal = meal
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            mealList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    

    

    
}