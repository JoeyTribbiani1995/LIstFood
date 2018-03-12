//
//  MealTableViewController.swift
//  LIstFood
//
//  Created by Dũng Võ on 3/10/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {

    var mealList : [Meal] = []
    
    @IBOutlet weak var editBarButtonItem: UIBarButtonItem!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
       navigationItem.leftBarButtonItem = editBarButtonItem
        
        if let saveMealList = loadFromFile() {
            mealList += saveMealList
        }else {
            mealList = Meal.loadSampleData()
        }
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
        saveToFile()
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
            saveToFile()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    @IBAction func editBarButtonItemTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let moveMeal = mealList.remove(at: fromIndexPath.row)
        mealList.insert(moveMeal, at: to.row)
        saveToFile()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    @IBAction func unwindToTableView(_ unwindSeque : UIStoryboardSegue){
        guard unwindSeque.identifier == "saveUnwind" else { return }
        
        let sourceVC = unwindSeque.source as! MealViewController
        
        if let meal = sourceVC.meal {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                mealList[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else {
                let newIndexPath = IndexPath(row: mealList.count, section: 0)
                
                mealList.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveToFile()
        }
        
    }
    
    
  func saveToFile(){
        let isSuccessFulSave = NSKeyedArchiver.archiveRootObject(mealList, toFile: Meal.archieveURL.path)
        
        if isSuccessFulSave{
            os_log("meal list successfully saved",log: OSLog.default,type :.debug)
        }else {
            os_log("failed to save meal list ...", log: OSLog.default,type : .error)
        }
    }
    
   func loadFromFile() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.archieveURL.path) as? [Meal]
    }
    
   
    

    
}
